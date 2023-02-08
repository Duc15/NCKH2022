import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];
  final List<Product> _dummyItems = [];
  final String? _authToken;

  final String? _userId;
  Products(this._authToken, this._userId, this._items);
  List<Product> get dummyItems {
    return [..._dummyItems];
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    var _params;
    if (filterByUser) {
      _params = <String, String?>{
        'auth': _authToken,
        'orderBy': json.encode("creatorId"),
        'equalTo': json.encode(_userId),
      };
    }
    if (filterByUser == false) {
      _params = <String, String?>{
        'auth': _authToken,
      };
    }
    var url = Uri.https('project4-6030f-default-rtdb.firebaseio.com',
        '/products.json', _params);
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      var _params = {
        'auth': _authToken,
      };
      url = Uri.https('project4-6030f-default-rtdb.firebaseio.com',
          '/userFavorites/$_userId.json', _params);
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);

      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: (prodData['price'] as num).toDouble(),
          isFavorite:
              favoriteData == null ? false : favoriteData[prodId] ?? false,
          // isFavorite: favoriteData == null ? false : true,
          imageUrl: prodData['imageUrl'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    var params = {
      'auth': _authToken,
    };
    final url = Uri.https(
        'project4-6030f-default-rtdb.firebaseio.com', '/products.json', params);
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price.toDouble(),
          'creatorId': _userId,
        }),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      var _params = {
        'auth': _authToken,
      };
      final url = Uri.https(
        'project4-6030f-default-rtdb.firebaseio.com',
        '/products.json',
        _params,
      );
      try {
        await http.patch(url,
            body: json.encode({
              'title': newProduct.title,
              'description': newProduct.description,
              'imageUrl': newProduct.imageUrl,
              'price': newProduct.price
            }));
        _items[prodIndex] = newProduct;
        notifyListeners();
      } catch (error) {
        rethrow;
      }

      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {}
  }

  Future<void> deleteProduct(String id) async {
    var _params = {
      'auth': _authToken,
    };
    final url = Uri.https('project4-6030f-default-rtdb.firebaseio.com',
        '/products/$id.json', _params);
    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    var existingProduct = _items[existingProductIndex];
    //xóa trước nếu lỗi thì trả lại
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final respone = await http.delete(url);
    if (respone.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
  }
}
