import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

import '../providers/products.dart';

class Visa extends StatefulWidget {
  static const routeName = '/visa';
  const Visa({Key? key}) : super(key: key);

  @override
  State<Visa> createState() => _VisaState();
}

class _VisaState extends State<Visa> {
  final _formKey = GlobalKey<FormState>();
  var cardName;
  void updateText(val) {
    setState(() {
      cardName = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final productId = ModalRoute.of(context)?.settings.arguments as String;
    // final loadedProduct =
    //     Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/');
            },
            icon: Icon(Icons.arrow_back_outlined)),
        elevation: 0.0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: Text(
          'Thêm thẻ tín dụng hoặc ghi nợ',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextFormField(
                validator: (value) {
                  if (value!.length < 16) {
                    return 'Hình thức thanh toán không hợp lệ hoặc không được hỗ trợ';
                  }
                  return null;
                },
                // controller: _text,
                onChanged: (val) {
                  updateText(val);
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    gapPadding: 5,
                    borderSide: BorderSide(
                      width: 2,
                      color: Color.fromARGB(255, 20, 117, 25),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 20, 117, 25),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 15,
                        width: 15,
                        child: Image.asset(
                          'assets/images/credit.png',
                        )),
                  ),
                  labelText: "Số thẻ",
                  hintText:
                      '__ __ __ __    __ __ __ __    __ __ __ __    __ __ __ __',
                  hintStyle: TextStyle(fontWeight: FontWeight.bold),
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 20, 117, 25)),
                ),
              ),
            ),
          ),

          //----------------------------------------------------
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:
                              Color.fromARGB(255, 24, 136, 30), // background
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text('Lưu'),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget heightSpacer(double myHeight) => SizedBox(height: myHeight);
