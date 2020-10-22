import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:trump_card_game/ui/screens/login.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:trump_card_game/ui/widgets/custom/horizontal_progress_indicator.dart';

class SplashScreen extends StatefulWidget {
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _versionName = 'V1.0';
  final splashDelay = 6;

  @override
  void initState() {
    super.initState();
    setScreenOrientationToLandscape();
    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => LogIn()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/bg_img3.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: InkWell(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                child: ColorizeAnimatedTextKit(
                                  onTap: () {
                                    //print("Tap Event");
                                  },
                                  text: [
                                    "CLASH OF CARDZ",
                                    "LET'S PLAY",
                                    "CLASH OF CARDZ",
                                    "ROCK & ROLL",
                                  ],
                                  textStyle: TextStyle(
                                      fontSize: 60.0,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: 'Rapier'),
                                  colors: [
                                    Colors.grey[700],
                                    Colors.amber[400],
                                    Colors.lightBlue,
                                    Colors.redAccent,
                                  ],
                                  textAlign: TextAlign.center,
                                  alignment: AlignmentDirectional.center,
                                  // or Alignment.topLeft
                                  isRepeatingAnimation: true,
                                  repeatForever: true,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          width: 600,
                          height: 20,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: HorizontalProgressIndicator(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
