import 'package:flutter/material.dart';
import 'package:markit_jetty/utils/colors.dart';

class MyHeaderDrawe extends StatefulWidget {
  String name;
  String email;

  MyHeaderDrawe({Key? key, required this.name, required this.email})
      : super(key: key);

  @override
  State<MyHeaderDrawe> createState() => _MyHeaderDraweState();
}

class _MyHeaderDraweState extends State<MyHeaderDrawe> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainColor,
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/profile.jpg'),
              ),
            ),
          ),
          Text(
            widget.name,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            widget.email,
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
