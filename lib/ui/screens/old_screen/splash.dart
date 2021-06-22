import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/base_application_fun.dart';
import 'package:clash_of_cardz_flutter/helper/globals.dart';
import 'package:clash_of_cardz_flutter/helper/shared_preference_data.dart';
import 'package:clash_of_cardz_flutter/ui/screens/old_screen/old_home.dart';
import 'package:clash_of_cardz_flutter/ui/screens/old_screen/old_login.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/horizontal_progress_indicator.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/animated_text_kit/animated_text_kit.dart';

import '../home.dart';
//import 'package:audioplayers/audio_cache.dart';
//import 'package:audioplayers/audioplayers.dart';


class SplashScreen extends StatefulWidget {
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver{
  String _versionName = 'V1.0';
  final splashDelay = 6;
  //static AudioCache musicCache;
  //static AudioPlayer instance;

  @override
  void initState() {
    super.initState();
    setScreenOrientationToLandscape();
    _loadWidget();

    SharedPreferenceHelper().getMusicOnOffState().then((isMusicOn) {
      if (isMusicOn) {
        playMusic();
      }
    });
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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Home(xApiKey: xApiKey, memberId: memberId,)));
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
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Stack(
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
    );
  }

  void playMusic() async {
    try {
      /*if (Platform.isIOS) {
        if (musicCache.fixedPlayer != null) {
          musicCache.fixedPlayer.startHeadlessService();
        }
        instance.startHeadlessService();
      }
      musicCache = AudioCache(prefix: "assets/audios/");
      instance = await musicCache.loop("bg_mixkit-too-cool-too-crazy.mp3", mode: PlayerMode.LOW_LATENCY);

      Globals.setAudioPlayerInstance(instance);*/
    } catch (e) {
      print(e);
    }
  }

}
