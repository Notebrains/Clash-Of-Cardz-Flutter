import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {

  CustomSnackBar(this.message);
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        onPressed: () {

        },
        child: Text('Show SnackBar'),
      ),
    );
  }
}