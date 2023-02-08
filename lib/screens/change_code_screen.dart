import 'package:flutter/material.dart';

class Code extends StatelessWidget {
  const Code({Key? key}) : super(key: key);
  static const routeName = '/code';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        elevation: 0.0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: Text(
          'Đổi mã',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    width: 15,
                    height: 15,
                    child: Image.asset('assets/images/google.png')),
                Text(
                  '  tkcdpm24@gmail.com',
                  style: TextStyle(color: Color.fromARGB(255, 65, 64, 64)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: TextFormField(
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0)),
                  hintText: 'Nhập mã',
                ),
              ),
            ),
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 15, color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Bằng cách nhấn vào Đổi phần thưởng, bạn đồng ý với ',
                    style: TextStyle(
                        fontSize: 15, color: Color.fromARGB(255, 65, 64, 64)),
                  ),
                  TextSpan(
                    text: 'Điều khoản và điều kiện',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 15,
                        color: Color.fromARGB(255, 65, 64, 64)),
                  ),
                  TextSpan(
                    text: ' của thẻ quà tặng và Mã khuyến mãi, nếu có.',
                    style: TextStyle(
                        fontSize: 15, color: Color.fromARGB(255, 65, 64, 64)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
