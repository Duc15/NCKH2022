import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';

import '../providers/products.dart';
import '../widgets/product_item.dart';

class HotSale extends StatelessWidget {
  static const routeName = '/sale';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =  productsData.dummyItems;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hot Sale'),
        
      ),
      drawer: const AppDrawer(),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          // builder: (c) => products[i],
          value: products[i],
          child: ProductItem(
              // products[i].id,
              // products[i].title,
              // products[i].imageUrl,
              ),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
