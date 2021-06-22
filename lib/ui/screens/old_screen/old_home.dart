import 'dart:io' show File, Platform;
import 'package:clash_of_cardz_flutter/helper/constantvalues/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';
import 'package:clash_of_cardz_flutter/bloc/api_bloc.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/common_fun.dart';
import 'package:clash_of_cardz_flutter/helper/shared_preference_data.dart';
import 'package:clash_of_cardz_flutter/model/responses/profile_res_model.dart';
import 'package:clash_of_cardz_flutter/ui/screens/about.dart';
import 'package:clash_of_cardz_flutter/ui/screens/game_rules.dart';
import 'package:clash_of_cardz_flutter/ui/screens/old_screen/old_leaderboard.dart';
import 'package:clash_of_cardz_flutter/ui/screens/old_screen/old_login.dart';
import 'package:clash_of_cardz_flutter/ui/screens/profile.dart';
import 'package:clash_of_cardz_flutter/ui/screens/old_screen/setting.dart';
import 'package:clash_of_cardz_flutter/ui/screens/old_screen/statistics.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/carousel_auto_slider.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/include_screens/include_home_screen.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/giffy_dialog/giffy_dialog.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/views/view_widgets.dart';

import 'games.dart';
import '../game_option.dart';

class OldHomeScreen extends StatefulWidget {
  OldHomeScreen({this.xApiKey, this.memberId});

  final String xApiKey;
  final String memberId;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<OldHomeScreen> {
  @override
  Widget build(BuildContext context) {
    //print('Home-apiKey ${widget.xApiKey}');
    //print('Home-memberId ${widget.memberId}');

    fetchProfileData();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/bg_img3.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 65,
              child: StreamBuilder(
                stream: apiBloc.profileRes,
                builder: (context, AsyncSnapshot<ProfileResModel> snapshot) {
                  if (snapshot.hasData) {
                    savePlayerInfoIntoPref(snapshot.data);
                    return buildHomeScreenPlayerInfo(snapshot.data, widget.xApiKey);
                  }
                  return Center();
                },
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: SlideInLeft(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.all(5),
                          child: IconButton(
                            icon: Image.asset(
                              'assets/icons/png/ic_setting.png',
                              color: Colors.white,
                            ),
                            onPressed: () {
                              onTapAudio('icon');
                              bool isNotifiOn;
                              SharedPreferenceHelper().getNotificationOnOffState().then((isNotificationOn) => {
                                    isNotifiOn = isNotificationOn,
                                  });
                              bool isSfxOn;
                              SharedPreferenceHelper().getSfxOnOffState().then((isSFXOn) => {
                                    isSfxOn = isSFXOn,
                                  });

                              SharedPreferenceHelper().getMusicOnOffState().then((isMusicOn) => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) => OldSetting(isMusicOn, isNotifiOn, isSfxOn, widget.memberId))),
                                  });
                            },
                          ),
                          decoration: Views.boxDecorationWidgetForIconWithBgColor(Colors.black, 4.0, Colors.grey, 5.0, 5.0, 3.0),
                        ),

                        Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.all(5),
                          child: IconButton(
                            icon: Image.asset('assets/icons/png/share.png'),
                            onPressed: () {
                              onTapAudio('icon');
                              _onShare(context, Constants.shareAndroidTxt, Constants.appName);
                              // urlFileShare();
                            },
                          ),
                          decoration: Views.boxDecorationWidgetForIconWithBgColor(Colors.greenAccent[700], 4.0, Colors.grey, 5.0, 5.0, 3.0),
                        ),
                        Container(
                            width: 40,
                            height: 40,
                            margin: EdgeInsets.all(5),
                            child: IconButton(
                              splashColor: Colors.white,
                              icon: SvgPicture.asset('assets/icons/svg/logout.svg'),
                              onPressed: () {
                                onTapAudio('icon');
                                SharedPreferenceHelper().clearPrefData();
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LogIn()));
                              },
                            ),
                            decoration: Views.boxDecorationWidgetForIconWithBgColor(Colors.redAccent, 4.0, Colors.grey, 5.0, 5.0, 3.0),
                        ),
                      ],
                    ),
                    preferences: AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                  ),
                ),

                Expanded(
                  flex: 9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeInDown(
                        child: MaterialButton(
                          splashColor: Colors.grey,
                          child: Container(
                            width: 220,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage('assets/icons/png/bg_button.png'), fit: BoxFit.fill),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                              child: Text(
                                "PLAY",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'neuropol_x_rg',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                            ),
                          ),
                          onPressed: () {
                            onTapAudio('button');
                            //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => GameOption()));
                            Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => GameOption()));
                          },
                        ),
                        preferences:
                            AnimationPreferences(duration: const Duration(milliseconds: 1000), autoPlay: AnimationPlayStates.Forward),
                      ),

                      FadeInLeft(
                        child: MaterialButton(
                          padding: EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
                          splashColor: Colors.grey,
                          child: Container(
                            width: 220,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage('assets/icons/png/bg_button.png'), fit: BoxFit.fill),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                              child: Text(
                                "GAMES",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'neuropol_x_rg',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                            ),
                          ),
                          onPressed: () {
                            onTapAudio('button');
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (BuildContext context) => Games(
                                          xApiKey: widget.xApiKey,
                                          memberId: widget.memberId,
                                        )));
                          },
                        ),
                        preferences:
                            AnimationPreferences(duration: const Duration(milliseconds: 1000), autoPlay: AnimationPlayStates.Forward),
                      ),

                      FadeInRight(
                        child: MaterialButton(
                          padding: EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
                          splashColor: Colors.grey,
                          child: Container(
                            width: 220,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage('assets/icons/png/bg_button.png'), fit: BoxFit.fill),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                              child: Text(
                                "GAME RULES",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'neuropol_x_rg',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                            ),
                          ),
                          onPressed: () {
                            onTapAudio('button');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => GameRule(
                                          xApiKey: widget.xApiKey,
                                          memberId: widget.memberId,
                                        )));
                          },
                        ),
                        preferences:
                            AnimationPreferences(duration: const Duration(milliseconds: 1000), autoPlay: AnimationPlayStates.Forward),
                      ),

                      FadeInUp(
                        child: MaterialButton(
                          padding: EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
                          splashColor: Colors.grey,
                          child: Container(
                            width: 220,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage('assets/icons/png/bg_button.png'), fit: BoxFit.fill),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                              child: Text(
                                "ABOUT",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'neuropol_x_rg',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                            ),
                          ),
                          onPressed: () {
                            onTapAudio('button');
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AboutScreen(widget.xApiKey)));
                          },
                        ),
                        preferences:
                            AnimationPreferences(duration: const Duration(milliseconds: 1000), autoPlay: AnimationPlayStates.Forward),
                      ),

                      FadeInUpBig(
                        child: MaterialButton(
                          padding: EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
                          splashColor: Colors.grey,
                          child: Container(
                            width: 220,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage('assets/icons/png/bg_button.png'), fit: BoxFit.fill),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                              child: Text(
                                "QUIT",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'neuropol_x_rg',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                            ),
                          ),
                          // ),
                          onPressed: () {
                            onTapAudio('button');
                            showExitDialog();
                          },
                        ),
                        preferences:
                            AnimationPreferences(duration: const Duration(milliseconds: 1000), autoPlay: AnimationPlayStates.Forward),
                      ),

                      //checkNetConWidget(),
                    ],
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: ZoomIn(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: CarouselAutoSlider(xApiKey: '56005600'),
                    ),
                    preferences: AnimationPreferences(duration: const Duration(milliseconds: 2000), autoPlay: AnimationPlayStates.Forward),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SlideInRight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.all(5),
                          child: IconButton(
                            icon: SvgPicture.asset(
                              'assets/icons/svg/stage.svg',
                              color: Colors.white,
                            ),
                            onPressed: () {
                              onTapAudio('icon');
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Leaderboard()));
                            },
                          ),
                          decoration: Views.boxDecorationWidgetForIconWithBgColor(Colors.amber[700], 4.0, Colors.grey, 5.0, 5.0, 3.0),
                        ),

                        Container(
                          width: 35,
                          height: 35,
                          margin: EdgeInsets.all(5),
                          child: IconButton(
                            icon: Image.asset('assets/icons/png/ic_statistic_whites.png'),
                            onPressed: () {
                              onTapAudio('icon');
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (BuildContext context) => Statistics(xApiKey: widget.xApiKey, memberId: widget.memberId,)));
                            },
                          ),
                          decoration: Views.boxDecorationWidgetForIconWithBgColor(Colors.cyan, 4.0, Colors.grey, 5.0, 5.0, 3.0),
                        ),
                        Container(
                          width: 35,
                          height: 35,
                          margin: EdgeInsets.all(5),
                          child: IconButton(
                            icon: SvgPicture.asset(
                              'assets/icons/svg/user.svg',
                              color: Colors.white,
                            ),
                            onPressed: () {
                              onTapAudio('icon');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) => Profile(
                                            xApiKey: widget.xApiKey,
                                            memberId: widget.memberId,
                                          ),),);
                            },
                          ),
                          decoration: Views.boxDecorationWidgetForIconWithBgColor(Colors.black54, 4.0, Colors.grey, 5.0, 5.0, 3.0),
                        ),
                      ],
                    ),
                    preferences: AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showExitDialog() {
    showDialog(
      context: context,
      builder: (_) => AssetGiffyDialog(
        image: Image.asset('assets/animations/gifs/exit.gif'),
        title: Text(
          'Clash Of Cardz',
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
        ),
        description: Text(
          'Do you really want to exit the App?',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
        ),
        entryAnimation: EntryAnimation.RIGHT,
        buttonOkText: Text(
          'QUIT',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        buttonOkColor: Colors.red,
        buttonCancelColor: Colors.greenAccent,
        buttonCancelText: Text(
          'PLAY',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onOkButtonPressed: () {
          onTapAudio('icon');
          SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
        },
      ),
    );
  }

  void savePlayerInfoIntoPref(ProfileResModel model) {
    print('-----mem: ${model.response[0].memberid}');
    SharedPreferenceHelper().saveUserProfileData(
        widget.xApiKey,
        model.response[0].memberid,
        model.response[0].fullname,
        model.response[0].image,
        model.response[0].points.toString(),
        model.response[0].coins,
        model.response[0].win,
        model.response[0].loss,
        model.response[0].matchPlayed,
        model.response[0].redeem,
        model.response[0].rank.toString());
  }

  _onShare(BuildContext context, String text, String subject) async {
    final RenderBox box = context.findRenderObject();
    await Share.share(text, subject: subject, sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  void fetchProfileData() async {
    await apiBloc.fetchProfileRes(widget.xApiKey, widget.memberId);
  }
}
