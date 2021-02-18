import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html/parser.dart';

void setScreenOrientationToLandscape(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);

  SystemChrome.setEnabledSystemUIOverlays([]);
}

void goBackToPreviousScreen(BuildContext context){
  if (Navigator.canPop(context)) {
    Navigator.pop(context);
  } else {
    SystemNavigator.pop();
  }
}

double getScreenWidth(BuildContext context){
  return MediaQuery.of(context).size.width;
}

double getScreenHeight(BuildContext context){
  return MediaQuery.of(context).size.height;
}

//here goes the function
String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  return parse(document.body.text).documentElement.text;
}