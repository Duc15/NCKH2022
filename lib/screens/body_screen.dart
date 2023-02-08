// ignore_for_file: deprecated_member_use
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int pageIndex = 0;

  final List<Widget> _demo = [
    Image.asset("assets/images/bia0.jpg", fit: BoxFit.cover),
    Image.asset("assets/images/bia.jpg", fit: BoxFit.cover),
    Image.asset("assets/images/bia1.jpg", fit: BoxFit.cover),
    Image.asset("assets/images/bia0.jpg", fit: BoxFit.cover),
    Image.asset("assets/images/bia.jpg", fit: BoxFit.cover),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          header(size: size),
          Container(
            height: 230,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      child: PageView(
                        children: _demo,
                        onPageChanged: (index) {
                          setState(() {
                            pageIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                CarouselIndicator(
                  count: _demo.length,
                  index: pageIndex,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class header extends StatelessWidget {
  const header({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      height: size.height * 0.2,
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
            bottom: 50,
          ),
          height: size.height * 0.2 - 20,
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            ),
          ),
          child: Row(children: [
            Text(
              'Kiến Shop',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            // const Icon(Icons.architecture_rounded),
            Container(
                width: 50,
                height: 50,
                child: Image.asset('assets/images/black.png')),
          ]),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 10),
                  blurRadius: 50,
                  color: (Colors.blue).withOpacity(0.23),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: ((value) {}),
                    decoration: InputDecoration(
                      hintText: "Tìm kiếm",
                      hintStyle: TextStyle(
                        color: Colors.blue.withOpacity(0.5),
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      // suffixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
