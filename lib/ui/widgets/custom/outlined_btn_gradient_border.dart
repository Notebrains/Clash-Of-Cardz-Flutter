import 'package:flutter/material.dart';

class OutlinedBtnGradientBorder extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double thickness;
  final double width;
  final double height;

  const OutlinedBtnGradientBorder({
    Key key,
    @required this.onPressed,
    @required this.child,
    @required this.height,
    @required this.width,
    this.thickness = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.lightBlue, Colors.cyanAccent]),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.all(thickness),
        decoration: BoxDecoration(
          color: Color(0xFF364B5A),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: OutlinedButton(
          onPressed: onPressed,
          child: child,
        ),
      ),
    );
  }
}
