
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Dimensions/dimensions.dart';

class SocialButtons extends StatelessWidget {
  final String social;
  const SocialButtons({Key? key,
    required this.social}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Dimensions().init(context);
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20),
        side: BorderSide(width: 2,color: Dimensions.primarycolor)
      ),
        onPressed: (){},
        child: SizedBox(
          width: Dimensions.widthsize*0.34,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
              "assets/images/$social.png",
                width: 20,
                height: 40,
              ),
              Text(
                social.toUpperCase(),
                style: TextStyle(
                  color: Colors.black
                ),
              )
            ],
          ),
        )
    );
  }
}
