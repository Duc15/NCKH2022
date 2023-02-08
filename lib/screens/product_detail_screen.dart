import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/qr_screen.dart';
import 'package:shop_app/widgets/buy_button.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/auth.dart';
import '../providers/orders.dart';
import '../providers/products.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter_add_to_cart_button/flutter_add_to_cart_button.dart';
import 'package:shop_app/providers/product.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../widgets/badge2.dart';
import '../widgets/products_grid.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail';

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  AddToCartButtonStateId stateId = AddToCartButtonStateId.idle;

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    //lay id
    final load = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    var showOnlyFavorites = false;
    var isInit = true;
    var isLoading = false;
    final cart = Provider.of<Cart>(context);
    @override
    void didChangeDependencies() {
      if (isInit) {
        setState(() {
          isLoading = true;
        });
        Provider.of<Products>(context).fetchAndSetProducts().then((_) {
          setState(() {
            isLoading = false;
          });
        });
      }
      isInit = false;
      super.didChangeDependencies();
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(loadedProduct.title),
              stretch: true,
              pinned: true,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                // ignore: prefer_const_literals_to_create_immutables
                stretchModes: <StretchMode>[StretchMode.zoomBackground],
                background: Hero(
                  tag: loadedProduct.id,
                  child: Image.network(
                    loadedProduct.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '\$${loadedProduct.price}',
                        style: const TextStyle(color: Colors.red, fontSize: 30),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            loadedProduct.toggleFavoriteStatus(
                              authData.token,
                              authData.userId,
                            );
                          },
                          icon: const Icon(Icons.favorite_border),
                        ),
                        IconButton(
                          // onPressed: () async {
                          //   final urlPreview =
                          //       'https://www.facebook.com/Ducky.Momo.Cute';
                          //   await Share.share(
                          //       'Mặt hàng này thật xịn xò\n\n$urlPreview');
                          // },
                          onPressed: () async {
                            final uri = Uri.parse(loadedProduct.imageUrl);
                            final res = await http.get(uri);
                            final bytes = res.bodyBytes;
                            final temp = await getTemporaryDirectory();
                            final path = '${temp.path}/image.jpg';
                            File(path).writeAsBytesSync(bytes);
                            await Share.shareFiles([path],
                                text: 'Sản phẩm này thật tuyệt');
                          },
                          icon: const Icon(Icons.share),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    loadedProduct.title,
                    softWrap: true,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                add_button(load, productId, loadedProduct),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: readmore(loadedProduct.description),
                ),
                const SizedBox(
                  height: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Sản phẩm gợi ý',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: ProductsGrid(showOnlyFavorites),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              width: 20,
            ),
            OrderButton1(cart: cart),
            AnimatedButton(
              width: 100,
              height: 50,
              text: 'QR',
              color: Colors.blue,
              pressEvent: () {
                setState(
                  () {
                    load.addItem(
                        productId, loadedProduct.price, loadedProduct.title);
                  },
                );
                Navigator.of(context).pushNamed(QR.routeName);
              },
            ),
            Consumer<Cart>(
              builder: (_, cart, ch) => Badge2(
                value: cart.itemCount.toString(),
                child: ch as Widget,
              ),
              child: AnimatedButton(
                width: 100,
                height: 50,
                text: 'Giỏ hàng',
                color: Colors.blue,
                pressEvent: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView add_button(
      Cart load, String productId, Product loadedProduct) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: AddToCartButton(
                trolley: Image.asset(
                  'assets/images/ic_cart.png',
                  width: 24,
                  height: 24,
                  color: Colors.white,
                ),
                text: const Text(
                  'Thêm vào giỏ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
                check: const SizedBox(
                  width: 48,
                  height: 48,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                borderRadius: BorderRadius.circular(24),
                backgroundColor: Colors.deepOrangeAccent,
                onPressed: (id) {
                  if (id == AddToCartButtonStateId.idle) {
                    setState(() {
                      load.addItem(
                          productId, loadedProduct.price, loadedProduct.title);
                    });
                    //handle logic when pressed on idle state button.
                    setState(() {
                      stateId = AddToCartButtonStateId.loading;
                      Future.delayed(const Duration(seconds: 2), () {
                        setState(() {
                          stateId = AddToCartButtonStateId.done;
                        });
                      });
                    });
                  } else if (id == AddToCartButtonStateId.done) {
                    //handle logic when pressed on done state button.
                    setState(() {
                      stateId = AddToCartButtonStateId.idle;
                    });
                  }
                },
                stateId: stateId,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names

  Widget readmore(String text) {
    return ReadMoreText(
      text,
      trimLines: 2,
      colorClickableText: Colors.pink,
      trimMode: TrimMode.Line,
      trimCollapsedText: 'Xem thêm',
      trimExpandedText: '( Xem bớt )',
      moreStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }
}

_showSuc(context) {
  AwesomeDialog(
    context: context,
    animType: AnimType.leftSlide,
    headerAnimationLoop: false,
    dialogType: DialogType.success,
    showCloseIcon: true,
    title: 'Thành công',
    desc: 'Thanh toán hoàn tất',
    btnOkOnPress: () {
      debugPrint('OnClcik');
    },
    btnOkIcon: Icons.check_circle,
    onDismissCallback: (type) {
      debugPrint('Dialog Dissmiss from callback $type');
    },
  ).show();
}

class OrderButtonDetail extends StatefulWidget {
  const OrderButtonDetail({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonDetail();
}

class _OrderButtonDetail extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      height: 50,
      width: 50,
      text: 'Success Dialog',
      color: Colors.green,
      pressEvent: () {
        () async {
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
          widget.cart.clear();
          // _showSuc(context);
        };
      },
    );
  }
}
