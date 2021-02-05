import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:trump_card_game/helper/exten_fun/common_fun.dart';
import 'package:trump_card_game/helper/globals.dart';
import 'package:trump_card_game/helper/shared_preference_data.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'login.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animator/flutter_animator.dart';

class Setting extends StatefulWidget {
  bool isMusicOn;
  bool isNotificationOn;
  bool isSfxOn;
  String memberId;

  Setting(bool isMusicOn, bool isNotificationOn, bool isSfxOn, String memberId) {
    this.isMusicOn = isMusicOn;
    this.isNotificationOn = isNotificationOn;
    this.isSfxOn = isSfxOn;
    this.memberId = memberId;
  }

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  void initState() {
    super.initState();
    setScreenOrientationToLandscape();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: SizedBox.expand(
              child: Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/bg_img3.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SlideInDown(
                          child: MaterialButton(
                            splashColor: Colors.grey,
                            child: Container(
                              alignment: Alignment.center,
                              width: 260,
                              height: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage('assets/icons/png/bg_button.png'), fit: BoxFit.fill),
                              ),
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Image.asset(
                                        'assets/icons/png/ic_music_on.png',
                                        color: Colors.white,
                                      ),
                                      onPressed: null,
                                    ),
                                    Text(
                                      "Music",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: 'montserrat',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87),
                                    ),
                                    Switch(
                                      value: widget.isMusicOn,
                                      onChanged: (bool newValue) {
                                        setState(() {
                                          widget.isMusicOn = newValue;
                                        });
                                        changeAudioPlayerStats(widget.isMusicOn);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // ),
                            onPressed: () {
                              onTapAudio('button');
                            },
                          ),
                          preferences: AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                        ),

                        SlideInRight(
                          child: MaterialButton(
                            splashColor: Colors.grey,
                            child: Container(
                              alignment: Alignment.center,
                              width: 260,
                              height: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage('assets/icons/png/bg_button.png'), fit: BoxFit.fill),
                              ),
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Image.asset(
                                        'assets/icons/png/ic_music_on.png',
                                        color: Colors.white,
                                      ),
                                      onPressed: null,
                                    ),
                                    Text(
                                      "SFX",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: 'montserrat',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87),
                                    ),
                                    Switch(
                                      value: widget.isSfxOn,
                                      onChanged: (bool newValue) {
                                        setState(() {
                                          widget.isSfxOn = newValue;
                                        });
                                        changeAudioPlayerStats(widget.isSfxOn);
                                        SharedPreferenceHelper().saveSfxOnOffState(widget.isSfxOn);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // ),
                            onPressed: () {
                              onTapAudio('button');
                            },
                          ),
                          preferences: AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                        ),
                        SlideInLeft(
                          child: MaterialButton(
                            splashColor: Colors.grey,
                            child: Container(
                              width: 260,
                              height: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage('assets/icons/png/bg_button.png'), fit: BoxFit.fill),
                              ),
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Image.asset(
                                        'assets/icons/png/ic_notification_on.png',
                                        color: Colors.white,
                                      ),
                                      onPressed: null,
                                    ),
                                    Text(
                                      "Notification",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: 'montserrat',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87),
                                    ),
                                    Switch(
                                      value: widget.isNotificationOn,
                                      onChanged: (bool newValue) {
                                        setState(() {
                                          widget.isNotificationOn = newValue;
                                        });
                                        SharedPreferenceHelper().saveNotificationOnOffState(widget.isNotificationOn);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // ),
                            onPressed: () {
                              onTapAudio('button');
                            },
                          ),
                          preferences: AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                        ),

                        SlideInRight(
                          child: MaterialButton(
                            padding: EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
                            splashColor: Colors.grey,
                            child: Container(
                              width: 260,
                              height: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage('assets/icons/png/bg_button.png'), fit: BoxFit.fill),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
                                child: Text(
                                  "Logout",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: 'montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                              ),
                            ),
                            // ),
                            onPressed: () {
                              onTapAudio('button');
                              SharedPreferenceHelper().clearPrefData();
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LogIn()));
                            },
                          ),
                          preferences: AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                        ),

                        SlideInUp(
                          child: MaterialButton(
                            padding: EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
                            splashColor: Colors.grey,
                            child: Container(
                              width: 260,
                              height: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage('assets/icons/png/bg_button.png'), fit: BoxFit.fill),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
                                child: Text(
                                  "Close",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: 'montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                              ),
                            ),
                            // ),
                            onPressed: () {
                              onTapAudio('button');
                              goBackToPreviousScreen(context);
                            },
                          ),
                          preferences: AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                        ),

                        FadeInDown(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Player Id: ${widget.memberId}",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontFamily: 'montserrat', color: Colors.black87),
                            ),
                          ),
                          preferences: AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                        ),

                        FadeInDown(
                          child: Text(
                            "Version: 1.0.1",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontFamily: 'montserrat', color: Colors.black87),
                          ),
                          preferences: AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                        ),

                      ],
                    ),

                    ZoomIn(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 50, left: 50),
                        child: Lottie.asset(
                          'assets/animations/lottiefiles/phone-settings.json',
                          width: 200,
                          height: 300,
                          repeat: true,
                          animate: true,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      preferences:
                          AnimationPreferences(duration: const Duration(milliseconds: 2000), autoPlay: AnimationPlayStates.Forward),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void changeAudioPlayerStats(bool isMusicOn) async {
    try {
      SharedPreferenceHelper().saveMusicOnOffState(isMusicOn);
      if (isMusicOn && Globals.getAudioPlayerInstance() == null) {
        AudioPlayer instance = await AudioCache(prefix: "assets/audios/").loop("bg_mixkit-too-cool-too-crazy.mp3");
        Globals.setAudioPlayerInstance(instance);
      } else if (!isMusicOn && Globals.getAudioPlayerInstance() != null) {
        await Globals.getAudioPlayerInstance().pause();
      } else {
        await Globals.getAudioPlayerInstance().resume();
      }
    } catch (e) {
      print(e);
    }
  }
}
