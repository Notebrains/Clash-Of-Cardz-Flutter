import 'package:flutter/material.dart';

class Views{
  final kInnerDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(32),
  );

  final kGradientBoxDecoration = BoxDecoration(
    gradient: LinearGradient(colors: [Colors.lightBlue, Colors.cyanAccent]),
    border: Border.all(
      //color: kHintColor,
    ),
    borderRadius: BorderRadius.circular(32),
  );

  static BoxDecoration boxDecorationWidgetForIconWithBgColor(
      Color boxBackgroundColor,
      double circularRadius,
      Color shadowColor,
      double shadowX,
      double shadowY,
      double blurRadius){
    return BoxDecoration(
      color: boxBackgroundColor,
      borderRadius:
      BorderRadius.all(Radius.circular(circularRadius)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: shadowColor,
          offset: Offset(shadowX, shadowY),
          blurRadius: blurRadius,
        ),
      ],
    );
  }

  static BoxDecoration boxDecorationWidgetForPngImage(
      String assetImg,
      double circularRadius,
      Color shadowColor,
      double shadowX,
      double shadowY,
      double blurRadius){
    return BoxDecoration(
      borderRadius:
      BorderRadius.all(Radius.circular(5.0)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.blue,
          offset: Offset(1, 1),
            spreadRadius : 1,
            blurRadius : 1
        ),
      ],
    );
  }

}