import 'package:flutter/material.dart';
import 'ui/screens/splash.dart';

void main() => runApp(MyRootApp());

class MyRootApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: SplashScreen(),
    );
  }
}