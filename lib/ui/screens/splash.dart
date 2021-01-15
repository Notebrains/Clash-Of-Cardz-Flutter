import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:trump_card_game/helper/shared_preference_data.dart';
import 'package:trump_card_game/ui/screens/home.dart';
import 'package:trump_card_game/ui/screens/login.dart';
import 'package:trump_card_game/ui/widgets/custom/horizontal_progress_indicator.dart';
import 'package:trump_card_game/ui/widgets/libraries/animated_text_kit/animated_text_kit.dart';


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
    //playUrlAudio("https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3");
    _loadWidget();
    //playUrlAudio('https://youtu.be/fnliFs-XU6w?list=TLPQMDQxMjIwMjDtI_trUlJTbw');
    //playAssetAudio('video_game_music.mp3');
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    SharedPreferenceHelper().getUserSavedData().then((sharedPrefUserProfileModel) {
      String xApiKey = sharedPrefUserProfileModel.xApiKey ?? 'NA';
      String memberId = sharedPrefUserProfileModel.memberId ?? 'NA';

      if(xApiKey != 'NA' && memberId != 'NA'){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen(xApiKey: xApiKey, memberId: memberId,)));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LogIn()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
