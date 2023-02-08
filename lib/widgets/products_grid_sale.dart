import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/product_item_sale.dart';

import '../providers/products.dart';
import './product_item.dart';

class ProductsGridSale extends StatelessWidget {
  static const routeName = '/grid';
  final bool showFavs;

  ProductsGridSale(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.dummyItems;
    return 

       GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          // builder: (c) => products[i],
          value: products[i],
          child: ProductItemSale(
              // products[i].id,
              // products[i].title,
              // products[i].imageUrl,
              ),
        ),
        gridDelegate:  const SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisExtent: 200,
          maxCrossAxisExtent: 800,
          // crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 10,
          
        ),
      
    );
  }
}
