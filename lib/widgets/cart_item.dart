import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

import '../providers/products.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  CartItem(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction:
          DismissDirection.endToStart, //vo hieu hoa luot tu trai sang phai
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
        //Trong id lớp CartItem là id của CartItem (widget Dismissble) và productId là id của sản phẩm.
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                  child: const Text('Không'),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                  child: const Text('Có'),
                ),
              ],
              title: const Text('Bạn chắc chứ ?'),
              content:
                  const Text('Bạn có muốn xóa sản phẩm khỏi giỏ hàng không ?'),
            );
          },
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: FittedBox(
                  child: Text('$price'),
                ),
              ),
            ),
            // leading: ClipRRect(
            //     child: SizedBox(
            //   width: 50,
            //   height: 50,
            //   child: Image.asset(loadedProduct.imageUrl),
            // )),
            title: Text(title),
            subtitle: Text('Tổng: \$${(price * quantity).toStringAsFixed(2)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}

class BuyCHPlay extends StatelessWidget {
  const BuyCHPlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
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
                    // Row(
                    //   children: [
                    //     Container(
                    //         padding: EdgeInsets.only(left: 10,right: 10),
                    //         height: 50,
                    //         width: 50,
                    //         child: Image.asset(
                    //           'assets/images/logo.png',
                    //         )),
                    //     const Text('Kiến Shop'),
                    //   ],
                    // ),
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
                          title: Text('Kiến shop'),
                          subtitle: Text('tkcdpm24@gmail.com'),
                          trailing: Text('250.000'),
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
                    Padding(
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
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
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
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
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
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
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
      },
      child: Text('a'),
    );
  }
}
