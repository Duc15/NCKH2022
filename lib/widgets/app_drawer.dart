// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/screens/add_place_screen.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import '../screens/favorite_screen.dart';
import '../screens/user_products_screen.dart';
import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Column(
              children: const [
                Icon(
                  Icons.account_circle,
                  size: 50,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Hello',
                ),
              ],
            ),
            const Divider(height: 2,),
            ListTile(
              leading: const Icon(Icons.shop),
              title: const Text('Cửa hàng'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
                //quay về tuyến đường gốc
              },
            ),
            const Divider(height: 2,),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Hóa đơn'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(OrdersScreen.routeName);
              },
            ),
            const Divider(height: 2,),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Sản phẩm yêu thích'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(FavoriteScreen.routeName);
              },
            ),
            const Divider(height: 2,),
            ListTile(
              leading: const Icon(Icons.manage_search),
              title: const Text('Quản lý sản phẩm'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(UserProductsScreen.routeName);
              },
            ),
            const Divider(height: 2),
            ListTile(
              leading: const Icon(Icons.add_chart),
              title: const Text('Trở thành người bán hàng'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(EditProductScreen.routeName);
              },
            ),
            // const Divider(),
            // ListTile(
            //   leading: const Icon(Icons.settings),
            //   title: const Text('Cài đặt'),
            //   onTap: () {
            //     Navigator.of(context)
            //         .pushReplacementNamed(QRState.routeName);
            //   },
            // ),
            const Divider(),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
                Provider.of<Auth>(context, listen: false).logout();
              },
              child: const Text(
                'Log out',
                style: TextStyle(color: Colors.red),
              ),
            ),
            const Divider(),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed(AddPlaceScreen.routeName);
                Provider.of<Auth>(context, listen: false).logout();
              },
              child: const Text(
                'image',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
