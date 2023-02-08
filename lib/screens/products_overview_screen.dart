// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/body_screen.dart';
import 'package:shop_app/widgets/hint_grid.dart';

import '../widgets/app_drawer.dart';
import '../widgets/hotsale_grid.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';

import './cart_screen.dart';
import '../providers/products.dart';
import 'more_screen.dart';


enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: const Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.Favorites,
                child: Text('Sản phẩm yêu thích'),
              ),
              const PopupMenuItem(
                value: FilterOptions.All,
                child: Text('Tất cả sản phẩm'),
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              value: cart.itemCount.toString(),
              child: ch as Widget,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            Body(),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                SizedBox(
                  height: 24,
                  child: Stack(children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Mới nhất",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        height: 7,
                        color: Colors.blue.withOpacity(0.2),
                      ),
                    ),
                  ]),
                ),
                const Spacer(),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context)
                    .pushReplacementNamed(MoreScreen.routeName);
                  },
                  // ignore: sort_child_properties_last
                  child: const Text(
                    'More',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          ),
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(
                    height: 200,
                    child: ProductsGrid(_showOnlyFavorites),
                  ),
                  
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  SizedBox(
                    height: 24,
                    child: Stack(children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Hot Sale",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          height: 7,
                          color: Colors.blue.withOpacity(0.2),
                        ),
                      ),
                    ]),
                  ),
                  const Spacer(),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context)
                    .pushReplacementNamed(MoreScreen.routeName);
                    //     Navigator.of(context)
                    // .pushReplacementNamed(ProductsGrid2.routeName);
                    },
                    // ignore: sort_child_properties_last
                    child: const Text(
                      'More',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
            ),
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: ProductsGrid2(_showOnlyFavorites),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  SizedBox(
                    height: 24,
                    child: Stack(children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Gợi ý",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          height: 7,
                          color: Colors.blue.withOpacity(0.2),
                        ),
                      ),
                    ]),
                  ),
                  const Spacer(),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context)
                    .pushReplacementNamed(MoreScreen.routeName);
                    },
                    // ignore: sort_child_properties_last
                    child: const Text(
                      'More',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 200,
              child: ProductsGrid1(_showOnlyFavorites),
            ),
            Container(
              height:50 ,
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   padding: const EdgeInsets.only(left: 60, right: 60),
      //   height: 70,
      //   decoration: BoxDecoration(color: Colors.white, boxShadow: [
      //     BoxShadow(
      //       offset: Offset(0, -10),
      //       blurRadius: 35,
      //       color: Colors.blue.withOpacity(0.38),
      //     )
      //   ]),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       IconButton(
      //         onPressed: (() {}),
      //         icon: Icon(Icons.home),
      //       ),
      //       IconButton(
      //         onPressed: (() {}),
      //         icon: Icon(Icons.favorite),
      //       ),
      //       IconButton(
      //         onPressed: (() {}),
      //         icon: Icon(Icons.account_box),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
