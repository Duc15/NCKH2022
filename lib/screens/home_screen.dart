import 'package:flutter/material.dart';
import 'package:shop_app/screens/body_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: Body(),
      // bottomNavigationBar: Container(
      //   padding: const EdgeInsets.only(left: 60, right: 60),
      //   height: 70,
      //   decoration: BoxDecoration(color: Colors.white, boxShadow: [
      //     BoxShadow(
      //       offset: Offset(0, -10),
      //       blurRadius: 35,
      //       color: Theme.of(context).primaryColor.withOpacity(0.38),
      //     )
      //   ]),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       IconButton(
      //         onPressed: (() {
              
      //         }),
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

  AppBar buildAppbar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.menu),
      ),
    );
  }
}
