import 'package:flutter/services.dart';

void setScreenOrientationToLandscape(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);

  SystemChrome.setEnabledSystemUIOverlays([]);

}