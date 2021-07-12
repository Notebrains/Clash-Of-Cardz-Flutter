import 'package:clash_of_cardz_flutter/bloc/api_bloc.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/outlined_btn_gradient_border.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/gapless_audio_loop.dart';
import 'package:flutter/material.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/base_application_fun.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/common_fun.dart';
import 'package:clash_of_cardz_flutter/helper/globals.dart';
import 'package:clash_of_cardz_flutter/helper/shared_preference_data.dart';
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor:  Color(0xFF364B5A),
        body: Center(
          child: SizedBox.expand(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SlideInDown(
                      child: OutlinedBtnGradientBorder(
                        onPressed: () {onTapAudio('button');},
                        height: 40,
                        width: 260,
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Image.asset(
                                'assets/icons/png/ic_music_on.png',
                                color: Colors.lightBlueAccent,
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
                                  color: Colors.blue.shade100),
                            ),

                            Switch(
                              value: widget.isMusicOn,
                              activeColor: Colors.lightBlueAccent,
                              inactiveTrackColor: Colors.white,
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
                      preferences: AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                    ),

                    /*SlideInRight(
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
                      ),*/

                    SlideInLeft(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                        child: OutlinedBtnGradientBorder(
                          height: 40,
                          width: 260,
                          onPressed: () {onTapAudio('button');},
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Image.asset(
                                  'assets/icons/png/ic_notification_on.png',
                                  color: Colors.lightBlueAccent,
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
                                  color: Colors.blue.shade50,
                                ),
                              ),
                              Switch(
                                value: widget.isNotificationOn,
                                activeColor: Colors.lightBlueAccent,
                                inactiveTrackColor: Colors.white,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    widget.isNotificationOn = newValue;
                                    turnOnOffNotificationByApi(newValue);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      preferences: AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                    ),

                    SlideInRight(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
                        child: OutlinedBtnGradientBorder(
                          height: 40,
                          width: 260,
                          onPressed: () {
                            onTapAudio('button');
                            SharedPreferenceHelper().clearPrefData();
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LogIn()));
                          },
                          child: Text(
                            "Logout",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade100),
                          ),
                        ),
                      ),
                      preferences: AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                    ),


                    SlideInUp(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
                        child: OutlinedBtnGradientBorder(
                          height: 40,
                          width: 260,
                          onPressed: () {
                            onTapAudio('button');
                            goBackToPreviousScreen(context);
                          },
                          child: Text(
                            "Close",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade100),
                          ),
                        ),
                      ),
                      preferences: AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                    ),

                    FadeInDown(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Player Id: ${widget.memberId}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold,
                              fontFamily: 'montserrat', color: Colors.blue.shade100),
                        ),
                      ),
                      preferences: AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                    ),

                    FadeInDown(
                      child: Text(
                        "Version: 1.0.1",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold,
                            fontFamily: 'montserrat', color: Colors.blue.shade100),
                      ),
                      preferences: AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                    ),

                  ],
                ),

                ZoomIn(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 50, left: 50),
                    child: Lottie.asset(
                      'assets/animations/lottiefiles/ph_setting.json',
                      width: 200,
                      height: 280,
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
    );
  }

  void changeAudioPlayerStats(bool isMusicOn) async {
    try {
      SharedPreferenceHelper().saveMusicOnOffState(isMusicOn);
      if (isMusicOn && Globals.getAudioPlayerInstance() == null) {
        final playerInstance = GaplessAudioLoop();
        await playerInstance.loadAsset('audios/Sorry.mp3');
        await playerInstance.play();
        Globals.setAudioPlayerInstance(playerInstance);
      } else if (!isMusicOn && Globals.getAudioPlayerInstance() != null) {
        await Globals.getAudioPlayerInstance().pause();
      } else {
        await Globals.getAudioPlayerInstance().resume();
      }
    } catch (e) {
      print(e);
    }
  }

  void turnOnOffNotificationByApi(bool onOffValue) async {
    try {
      SharedPreferenceHelper().saveNotificationOnOffState(widget.isNotificationOn);
      SharedPreferenceHelper().getUserApiKey().then((xApiKey) => {
        apiBloc.fetchNotificationsOnOffRes(xApiKey, widget.memberId, onOffValue? '1': '0'),
      });

      if (!onOffValue) {
        showToast(context, 'Notification is off. But you will still get Battle Challenge notification from friends.');
      }
    } catch (e) {
      print(e);
    }
  }
}
