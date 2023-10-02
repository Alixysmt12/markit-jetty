import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;

  MyText(
      {Key? key,
      this.color = const Color(0xff332b2b),
      required this.text,
      this.size = 15,
      this.overflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        overflow: overflow,
        maxLines: 1,
        style: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontSize: size),
    );
  }
}
