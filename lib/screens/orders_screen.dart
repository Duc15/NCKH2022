import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hóa đơn'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return const Center(
                child: Text('Có lỗi xảy ra!'),
              );
            } else {
              return Consumer<Orders>(
                builder: ((context, orderData, child) => ListView.builder(
                      itemCount: orderData.orders.length,
                      itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                    )),
              );
            }
          }
        }),
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
      ),
    );
  }
}
