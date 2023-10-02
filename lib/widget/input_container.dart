import 'package:flutter/material.dart';
import 'package:markit_jetty/utils/colors.dart';

class InputContainer extends StatelessWidget {
  const InputContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: size.width * 0.9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.mainColor3,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0,3), // changes position of shadow
            ),
          ],

        ),


        child: child
    );
  }
}
