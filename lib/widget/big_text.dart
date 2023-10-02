import 'package:flutter/material.dart';

class Bigtext extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;

  Bigtext(
      {Key? key,
        this.color = const Color(0xff332b2b),
        required this.text,
        this.size = 20,
        this.overflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: 1,
      style: TextStyle(
          fontFamily: 'simplefont',
          color: color,
          fontWeight: FontWeight.w400,
          fontSize: size),
    );
  }
}
