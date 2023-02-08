import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import './product_item.dart';

class ProductsGrid2 extends StatelessWidget {
  static const routeName = '/grid';
  final bool showFavs;

  ProductsGrid2(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (ctx, i) {
        int reverse = products.length - 3 - i;
        return ChangeNotifierProvider.value(
          // builder: (c) => products[i],
          value: products[reverse],
          child: ProductItem(
              // products[i].id,
              // products[i].title,
              // products[i].imageUrl,
              ),
        );
      },
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
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
