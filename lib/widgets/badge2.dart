import 'package:flutter/material.dart';

class Badge2 extends StatelessWidget {
  const Badge2({
    Key? key,
    required this.child,
    required this.value,
    this.color,
  }) : super(key: key);

  final Widget child;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 1,
          top: 1,
          child: Container(
            padding: const EdgeInsets.all(2.0),
            // color: Theme.of(context).accentColor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: color != null ? color : Theme.of(context).errorColor,
            ),
            constraints: const BoxConstraints(
              minWidth: 25,
              minHeight: 25,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white
              ),
            ),
          ),
        )
      ],
    );
  }
}
