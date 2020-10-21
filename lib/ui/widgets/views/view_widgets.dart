import 'package:flutter/material.dart';

class Views{
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
      image: DecorationImage(
        image: AssetImage(
            assetImg),
        fit: BoxFit.cover,
      ),
      borderRadius:
      BorderRadius.all(Radius.circular(5.0)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.grey,
          offset: Offset(4, 4),
          blurRadius: 3,
        ),
      ],
    );
  }

}