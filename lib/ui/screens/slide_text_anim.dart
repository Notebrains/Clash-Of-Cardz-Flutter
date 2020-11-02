import 'package:flutter/material.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:trump_card_game/helper/exten_fun/common_fun.dart';

class SlideTextAnim extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter SlideTransition',
        theme: ThemeData.dark(),
        home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  MyHomePageState createState() => MyHomePageState();

}


class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();

    setScreenOrientationToLandscape();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -0.4)).animate(
        _animationController);

    _animationController.forward().whenComplete(() {
      // put here the stuff you wanna do when animation completed!
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SlideTransition(
          position: _animation,
          child: Center(child: Text("My Text")),
        )
    );
  }
}