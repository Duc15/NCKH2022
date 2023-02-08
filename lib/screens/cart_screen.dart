import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/visa_screen.dart';
import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/orders.dart';
import 'change_code_screen.dart';
import 'e_momo_screen.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Tổng',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.subtitle1!.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(cart: cart)
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => CartItem(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].title,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalAmount,
              );
              setState(() {
                _isLoading = false;
              });
             
showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 289,
                  color: Colors.white,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          height: 25,
                          width: double.infinity,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Image.asset(
                              'assets/images/ggplay.png',
                            ),
                          ),
                        ),
                        const Divider(
                          height: 1,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ListTile(
                              leading: Container(
                                width: 40,
                                height: 40,
                                child: Image.asset(
                                  'assets/images/logo.png',
                                ),
                              ),
                              title: Text('Mua sản phẩm trong ứng dụng'),
                              subtitle: Text('Kiến Shop'),
                              // trailing: Text(
                              //   // '${loadedProduct.price}\$',
                              //   'a'
                              // ),
                            ),
                          ),
                        ),
                        const Divider(
                          height: 1,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            setState(() {
                              // purchase = false;
                            });
                          },
                          child: Card(
                            child: ListTile(
                              leading: Image.asset('assets/images/ggpay.png'),
                              title: Text('Test card, alway approves'),
                              trailing: Icon(Icons.arrow_forward_ios_sharp),
                            ),
                          ),
                        ),

                        // ElevatedButton(
                        //     onPressed: () {
                        //       setState(() {
                        //         purchase = false;
                        //       });
                        //     },
                        //     child: Text('a')),
                        Container(
                            alignment: Alignment.bottomLeft,
                            padding:
                                EdgeInsets.only(left: 20, top: 20, bottom: 40),
                            child: Text(
                                'This is a test order, you will not be charged')),
                        const Divider(height: 1),
                        Container(
                          height: 40,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(
                                  255, 24, 136, 30), // background
                              onPrimary: Colors.white,
                            ),
                            onPressed: () async {
                              // cart.addItem(loadedProduct.id,
                              //     loadedProduct.price, loadedProduct.title);
                              setState(() {
                                _isLoading = true;
                              });
                              await Provider.of<Orders>(context, listen: false)
                                  .addOrder(
                                widget.cart.items.values.toList(),
                                widget.cart.totalAmount,
                              );

                              widget.cart.clear();
                              Navigator.pop(context);
                              setState(() {
                                _isLoading = false;
                              });
                              showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 200,
                                      child: Center(
                                          child: _isLoading
                                              ? CircularProgressIndicator()
                                              : Container(
                                                  height: 150,
                                                  width: 150,
                                                  child: Image.asset(
                                                      'assets/images/suc.gif'))),
                                    );
                                  });
                            },
                            child: Text('Thanh toán'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
      textColor: Theme.of(context).primaryColor,
      child: _isLoading
          ? const CircularProgressIndicator()
          : const Text('Thanh toán'),
    );
  }
}
