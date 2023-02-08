import 'package:flutter/material.dart';
import '../providers/auth.dart';
import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(100, 100, 100, 1),
              offset: Offset(4.0, 4.0),
              blurRadius: 8,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-4.0, -4.0),
              blurRadius: 8,
              spreadRadius: 1.0,
            ),
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: GridTile(
          footer: GridTileBar(
            title: Text(product.title),
            backgroundColor: Colors.black54,
            leading: Consumer<Product>(
              //cosumer : chi rebuild widget nay` con lai khong rebuild
              builder: (ctx, product, _) => IconButton(
                icon: Icon(product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  product.toggleFavoriteStatus(
                    authData.token,
                    authData.userId,
                  );
                },
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: (() {
                cart.addItem(product.id, product.price, product.title);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Đã thêm sản phẩm vào giỏ!'),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'Hoàn tác',
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      },
                    ),
                  ),
                );
              }),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: product.id,
              );

            },
            child: Hero(
              tag: product.id,
              child: FadeInImage(
                image: NetworkImage(
                  product.imageUrl,
                ),
                fit: BoxFit.cover,
                placeholder: const AssetImage('assets/images/background.jpg'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
