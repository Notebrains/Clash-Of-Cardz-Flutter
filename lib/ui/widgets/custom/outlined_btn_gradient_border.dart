import 'package:flutter/material.dart';

class OutlinedBtnGradientBorder extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double thickness;
  final double width;
  final double height;
  final Color gradColor1;
  final Color gradColor2;

  const OutlinedBtnGradientBorder({
    Key key,
    @required this.onPressed,
    @required this.child,
    @required this.height,
    @required this.width,
    this.gradColor1 = Colors.blueAccent,
    this.gradColor2 = Colors.cyanAccent,
    this.thickness = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [gradColor1, gradColor2]),
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
