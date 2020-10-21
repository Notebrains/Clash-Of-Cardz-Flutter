import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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