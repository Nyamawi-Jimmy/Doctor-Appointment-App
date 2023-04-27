
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Dimensions/dimensions.dart';

class Button extends StatelessWidget {
  final String title;
   final double width;
   final bool disable;
  final Function() onPressed;

   Button({Key? key,
    required this.onPressed,
     required this.title,
     required this.width,
     required this.disable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Dimensions.primarycolor,
              foregroundColor: Colors.white
        ),
        onPressed:disable?null:onPressed,
        child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
            fontSize: 18,

          ),
        ),
      ),
    );
  }
}
