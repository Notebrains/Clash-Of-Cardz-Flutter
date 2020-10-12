import 'package:flutter/material.dart';

class Gameplay extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp( debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Gameplay'),
          centerTitle: true,
        ),
        body: Center(
          child: Text('Welcome'),
        ),
      ),
    );
  }
}