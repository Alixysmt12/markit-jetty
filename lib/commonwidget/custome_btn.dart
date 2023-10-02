import 'package:flutter/material.dart';
import 'package:markit_jetty/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;


  const CustomButton({Key? key, required this.text, required this.onTap})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: onTap,
      child: Text(
        text,
      ),
      style: ElevatedButton.styleFrom(primary:AppColors.mainColor,minimumSize: Size(size.width * 0.9, 50)),
    );
  }
}
