import 'dart:io';
import 'dart:typed_data';
import 'dart:async';

import 'dart:ui' as ui;

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shop_app/screens/cart_screen.dart';

import '../providers/cart.dart';
import 'button_widget.dart';

class QR extends StatelessWidget {
  static final String title = 'Take Screenshots';
  static const routeName = '/dem';
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MainPage(),
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Screenshot(
      controller: controller,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/');
                
              },
              icon: Icon(Icons.arrow_back_ios_new)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: buildImage()),
            const SizedBox(height: 32),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40)
                  .copyWith(bottom: 100),
              child: Column(
                children: [
                  // Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40)
                  //       .copyWith(bottom: 150),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      'PHAM MINH DUC',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: const Text('45010005055184',
                        style: TextStyle(
                          fontSize: 18,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      '${cart.totalAmount}\$',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: ui.Color.fromARGB(255, 39, 105, 160)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: const Text('BIDV-CN Hà Tây',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ButtonWidget(
                  text: 'Chia sẻ',
                  onClicked: () async {
                    final image =
                        await controller.captureFromWidget(buildImage());

                    saveAndShare(image);
                  },
                ),
                ButtonWidget(
                  text: 'Lưu ảnh',
                  onClicked: () async {
                    final image =
                        await controller.captureFromWidget(buildImage());
                    if (image == null) return;

                    await saveImage(image);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'Đã lưu ảnh',
                        style: TextStyle(fontSize: 20),
                      ),
                      backgroundColor: Colors.blue,
                    ));
                  },
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes);

    final text = 'Chia sẻ';
    await Share.shareFiles([image.path], text: text);
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();

    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = 'screenshot_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);

    return result['filePath'];
  }

  Widget buildImage() {
    final cart = Provider.of<Cart>(context);
    Future<ui.Image> _loadOverlayImage() async {
      final completer = Completer<ui.Image>();
      final byteData = await rootBundle.load('assets/images/logoQR.png');
      ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
      return completer.future;
    }

    final message =
        // ignore: lines_longer_than_80_chars
        'Thanh toán ${cart.itemCount} sản phẩm với giá \$${cart.totalAmount},';
    final qrFutureBuilder = FutureBuilder<ui.Image>(
      future: _loadOverlayImage(),
      builder: (ctx, snapshot) {
        final size = 280.0;
        if (!snapshot.hasData) {
          return Container(width: size, height: size);
        }
        return CustomPaint(
          size: Size.square(size),
          painter: QrPainter(
            data: message,
            version: QrVersions.auto,
            eyeStyle: const QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: ui.Color.fromARGB(255, 36, 86, 161),
            ),
            dataModuleStyle: const QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.circle,
              color: ui.Color.fromARGB(255, 57, 130, 189),
            ),
            // size: 320.0,
            embeddedImage: snapshot.data,
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size.square(60),
            ),
          ),
        );
      },
    );
    return qrFutureBuilder;
    // return Stack(
    //   children: [
    //     AspectRatio(
    //       aspectRatio: 1,
    //       // child: Image.network(
    //       //   'https://images.unsplash.com/photo-1469334031218-e382a71b716b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80',
    //       //   fit: BoxFit.cover,
    //       // ),
    //       child: QrImage(
    //         data: data,
    //         version: QrVersions.auto,
    //         size: 320,
    //         gapless: false,
    //         // embeddedImage: AssetImage('assets/images/logoQR.png'),
    //         embeddedImageStyle: QrEmbeddedImageStyle(
    //           size: Size(80, 80),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
