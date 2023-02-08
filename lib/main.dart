import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/qr_screen.dart';

import './screens/more_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/setting_screen.dart';
import './screens/visa_screen.dart';
import '../screens/e_momo_screen.dart';
import './screens/splash_screen.dart';
import '../providers/auth.dart';
import '../screens/edit_product_screen.dart';
import './screens/user_products_screen.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';
import '../screens/product_detail_screen.dart';
import 'providers/orders.dart';
import 'providers/products.dart';
import './screens/orders_screen.dart';
import './screens/auth_screen.dart';
import 'screens/add_place_screen.dart';
import 'screens/change_code_screen.dart';
import 'screens/favorite_screen.dart';
import './screens/hot_sale_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (ctx) => Products(null, null, []),
          update: (ctx, auth, previousProducts) => Products(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders(null, null, []),
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: ((context, value, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'MyShop',
              theme: ThemeData(
                primaryColor: Colors.blue,
                fontFamily: 'Lato',
                colorScheme:
                    ColorScheme.fromSwatch().copyWith(secondary: Colors.grey),
                brightness: Brightness.light,
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
              ),
              themeMode: ThemeMode.system,

              home: value.isAuth
                  //có được xác thực hay không
                  ? Scaffold(
                      body: ProductsOverviewScreen(),
                    )
                  //nếu có
                  : FutureBuilder(
                      //nếu không
                      future: value.tryAutoLogin(),
                      builder: ((context, snapshot) =>
                          snapshot.connectionState == ConnectionState.waiting
                              ? SplashScreen()
                              : AuthScreen()),
                    ),
              //token chưa hết hạn thì dùng productOverview
              routes: {
                ProductDetailScreen.routeName: (context) =>
                    ProductDetailScreen(),
                CartScreen.routeName: (context) => CartScreen(),
                OrdersScreen.routeName: (context) => OrdersScreen(),
                UserProductsScreen.routeName: (context) => UserProductsScreen(),
                EditProductScreen.routeName: (context) => EditProductScreen(),
                FavoriteScreen.routeName: (context) => FavoriteScreen(true),
                SettingScreen.routeName: (context) => SettingScreen(),
                MoreScreen.routeName: (context) => MoreScreen(false),
                HotSale.routeName: (context) => HotSale(),
                // ignore: equal_keys_in_map
                ProductDetailScreen.routeName: (context) =>
                    ProductDetailScreen(),
                Visa.routeName: (context) => Visa(),
                Momo.routeName: (context) => Momo(),
                Code.routeName:(context) => Code(),
                QR.routeName:((context) => QR()),
                AddPlaceScreen.routeName:((context) => AddPlaceScreen())
              },
            )),
      ),
    );
  }
}
