import 'package:flutter/material.dart';
import 'package:dark_light_button/dark_light_button.dart';
import 'package:shop_app/widgets/app_drawer.dart';

class SettingScreen extends StatefulWidget {
  static const routeName = '/setting';

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

bool iconBool = false;
IconData iconLight = Icons.wb_sunny;
IconData iconDark = Icons.nights_stay;
ThemeData lightTheme =
    ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light);
ThemeData darkTheme = ThemeData(brightness: Brightness.dark);

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cài đặt'),),
        drawer: AppDrawer(),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Text('Tính năng đang được phát triển',style: TextStyle(fontSize: 50),),
        ));
  }
}
