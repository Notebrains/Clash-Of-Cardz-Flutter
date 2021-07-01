import 'package:flutter/material.dart';

class HorizontalProgressIndicator extends StatefulWidget {

  @override
  _ProgressIndicatorDemoState createState() =>
      new _ProgressIndicatorDemoState();
}

class _ProgressIndicatorDemoState extends State<HorizontalProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 5484), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.repeat();
  }


  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
          child:  LinearProgressIndicator(
            value:  animation.value,
            backgroundColor: Colors.grey[400],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.cyanAccent[400],),
            minHeight: 20,

          ),

        )
    );
  }

}