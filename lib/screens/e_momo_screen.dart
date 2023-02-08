import 'package:flutter/material.dart';

class Momo extends StatelessWidget {
  const Momo({Key? key}) : super(key: key);
  static const routeName = '/momo';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.white,
          elevation: 0.0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: Text(
            'Thêm MoMo e-wallet',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bạn sẽ được chuyển hướng đến MoMo e-wallet để xác minh tài khoản của mình.',
                style: TextStyle(
                    fontSize: 15, color: Color.fromARGB(255, 65, 64, 64)),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Bằng cách tiếp tục bạn đồng ý với:',
                style: TextStyle(color: Color.fromARGB(255, 65, 64, 64)),
              ),
              Text('• Điều khoản dịch vụ của Google Payments',
                  style: TextStyle(color: Color.fromARGB(255, 65, 64, 64))),
              Text('• Điều khoản dịch vụ cả Momo e-wallet',
                  style: TextStyle(
                      color: Color.fromARGB(255, 65, 64, 64),
                      decoration: TextDecoration.underline)),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 65, 64, 64)),
                  children: [
                    TextSpan(
                      text: 'Thông báo quyền riêng tư',
                      style: TextStyle(
                          decoration: TextDecoration.underline, fontSize: 15),
                    ),
                    TextSpan(
                      text:
                          ' của Google Payments mô tả cách xử lý dữ liệu liên quan đến Google Payments.',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 536,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(
                                  255, 24, 136, 30), // background
                              onPrimary: Colors.white, // foreground
                            ),
                            onPressed: () {},
                            child: Text('Tiếp tục'),
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
