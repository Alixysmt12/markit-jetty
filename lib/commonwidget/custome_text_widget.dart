import 'package:flutter/material.dart';
import 'package:markit_jetty/utils/colors.dart';
import 'package:markit_jetty/widget/input_container.dart';

import '../utils/show_custom_snackbar.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final IconData icon;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.icon,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextFormField(
        obscureText: obscureText,
        cursorColor: AppColors.mainColor,
        controller:controller,
        decoration: InputDecoration(
            errorStyle: const TextStyle(fontSize: 0.01),
            icon: Icon(icon, color: AppColors.mainColor),
            hintText: hintText,
            border: InputBorder.none,
        ),
        validator:(val){

          if(val == null || val.isEmpty){

         //   return 'Enter your $hintText';
            showCustomSnackBar("Type your $hintText", title: "$hintText");
            return "";


          }
          return null;
        },
        maxLines: maxLines,

      ),
    );
  }
}
