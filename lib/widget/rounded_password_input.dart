import 'package:flutter/material.dart';

import 'input_container.dart';

class RoundedPasswordInput extends StatelessWidget {
  const RoundedPasswordInput({
    Key? key,
    required this.hint
  }) : super(key: key);

  final String hint;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
        child: TextField(
          cursorColor: Colors.red.shade300,
          obscureText: true,
          decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.red),
              hintText: hint,
              border: InputBorder.none
          ),
        ));
  }
}
