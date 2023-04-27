import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Dimensions{
  static MediaQueryData? mediaQueryData;
  static double? screenHeight;
  static double? screenWidth;

//Initialization of width and height
  void init(BuildContext context){
    var mediaQueryData=MediaQuery.of(context);
    screenHeight=mediaQueryData.size.height;
    screenWidth =mediaQueryData.size.width;
  }

  static get heightsize{
    return screenHeight;
  }

  static get widthsize {
    return screenWidth;
  }

  static const primarycolor=Colors.blueAccent;

  //spacing height
  static const spacesmall=SizedBox(height: 15,);
  static final spacemedium=SizedBox(height: screenHeight!*0.09,);
  static final spacelarge=SizedBox(height: screenHeight!*0.08,);

//Outline input border
  static const outlineborder= OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15))
  );


  //Outline focus border
  static const focusborder= OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(
          color: Colors.blueAccent
      )
  );

  //outline errorborder
  static const errorborder= OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(
        color: Colors.redAccent,
      )
  );



}
