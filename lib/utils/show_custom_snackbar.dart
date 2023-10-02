import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/big_text.dart';


void showCustomSnackBar(String message,
    {bool isError = true, String title = "Invalid Credentials"}) {
  Get.snackbar(title, message,
      titleText: Bigtext(
        text: title,
        color: Colors.white,
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.redAccent
  );
}