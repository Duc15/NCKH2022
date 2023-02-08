import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/change_code_screen.dart';
import 'package:shop_app/screens/visa_screen.dart';

import '../providers/cart.dart';
import '../providers/orders.dart';
import '../providers/products.dart';
import '../screens/e_momo_screen.dart';

class OrderButton1 extends StatefulWidget {
  const OrderButton1({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderButton1> createState() => _OrderButtonState();
}
  bool purchase = false;
class _OrderButtonState extends State<OrderButton1> {
  var _isLoading = false;

  var time;
  var suc = false;

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    final cart = Provider.of<Cart>(context, listen: false);
    return RaisedButton(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 19),
      color: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      onPressed: () {
        if (purchase == false) {
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
                              title: Text(loadedProduct.title),
                              subtitle: Text('Kiến Shop'),
                              trailing: Text(
                                '${loadedProduct.price}\$',
                              ),
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
                              purchase = false;
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
                              cart.addItem(loadedProduct.id,
                                  loadedProduct.price, loadedProduct.title);
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
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 400,
                color: Colors.white,
                child: Center(
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
                            title: Text(loadedProduct.title),
                            subtitle: Text('tkcdpm24@gmail.com'),
                            trailing: Text(
                              '${loadedProduct.price}\$',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, bottom: 10),
                        child: const Text(
                          'Hãy thêm một phương thức thanh toán vào Tài khoản Google của bạn để hoàn tất giao dịch mua.Chỉ Google mới xem được thông tin thanh toán của bạn',
                          style:
                              TextStyle(color: Color.fromARGB(255, 71, 68, 68)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).popAndPushNamed(Visa.routeName);
                          setState(() {
                            purchase = true;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              //<-- SEE HERE
                              side: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                      height: 25,
                                      width: 25,
                                      child: Image.asset(
                                        'assets/images/visa.png',
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Thêm thẻ tín dụng hoặc thẻ ghi nợ',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (() {
                          Navigator.of(context).pushNamed(Momo.routeName);
                        }),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              //<-- SEE HERE
                              side: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                      height: 25,
                                      width: 25,
                                      child: Image.asset(
                                        'assets/images/momo1.png',
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Thêm Momo e-wallet',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(Code.routeName);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              //<-- SEE HERE
                              side: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                      height: 25,
                                      width: 25,
                                      child: Image.asset(
                                        'assets/images/chplay.png',
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Đổi mã',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // ElevatedButton(
                      //   child: const Text('Close BottomSheet'),
                      //   onPressed: () => Navigator.pop(context),
                      // ),
                    ],
                  ),
                ),
              );
            },
          );
        
        }
        if (purchase == true) {
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
                              title: Text(loadedProduct.title),
                              subtitle: Text('Kiến Shop'),
                              trailing: Text(
                                '${loadedProduct.price}\$',
                              ),
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
                              purchase = false;
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
                              cart.addItem(loadedProduct.id,
                                  loadedProduct.price, loadedProduct.title);
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
        }
        // _showSuc(context);
      },
      textColor: Theme.of(context).primaryColor,
      child: _isLoading
          ? const CircularProgressIndicator()
          : const Text(
              'Mua ngay',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
    );
  }
}
