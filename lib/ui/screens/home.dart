import 'dart:io' show File, Platform;
import 'package:clash_of_cardz_flutter/helper/constantvalues/constants.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/btn_left_border_sq.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/ic_svg.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/avatar_glow.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:share/share.dart';
import 'package:clash_of_cardz_flutter/bloc/api_bloc.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/common_fun.dart';
import 'package:clash_of_cardz_flutter/helper/shared_preference_data.dart';
import 'package:clash_of_cardz_flutter/model/responses/profile_res_model.dart';
import 'package:clash_of_cardz_flutter/ui/screens/about.dart';
import 'package:clash_of_cardz_flutter/ui/screens/game_rules.dart';
import 'package:clash_of_cardz_flutter/ui/screens/old_screen/old_leaderboard.dart';
import 'package:clash_of_cardz_flutter/ui/screens/profile.dart';
import 'package:clash_of_cardz_flutter/ui/screens/old_screen/setting.dart';
import 'package:clash_of_cardz_flutter/ui/screens/old_screen/statistics.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/carousel_auto_slider.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/giffy_dialog/giffy_dialog.dart';
import 'game_option.dart';
import 'leaderboard.dart';
import 'login.dart';
import 'old_screen/games.dart';

class Home extends StatefulWidget {
  Home({this.xApiKey, this.memberId});

  final String xApiKey;
  final String memberId;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    fetchProfileData();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF364B5A),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 70,
            color: Color(0xFF2C3E4B),
            child: StreamBuilder(
              stream: apiBloc.profileRes,
              builder: (context, AsyncSnapshot<ProfileResModel> snapshot) {
                if (snapshot.hasData) {
                  savePlayerInfoIntoPref(snapshot.data);
                  return SlideInDown(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 26.0),
                          child: Shimmer.fromColors(
                            baseColor: Colors.cyanAccent[100],
                            highlightColor: Colors.lightBlueAccent,
                            child: Text(snapshot.data.response[0].fullname.toUpperCase() ?? '',
                                style: TextStyle(fontSize: 22, fontFamily: 'montserrat', color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Row(
                          children: [
                            HeartBeat(
                              child: Image.asset(
                                'assets/icons/png/coins.png',
                                height: 40,
                                width: 40,
                              ),
                              preferences:
                                  AnimationPreferences(duration: const Duration(milliseconds: 2000), autoPlay: AnimationPlayStates.Loop),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(5.0, 8.0, 30.0, 8.0),
                              child: Shimmer.fromColors(
                                baseColor: Colors.cyanAccent[100],
                                highlightColor: Colors.lightBlueAccent,
                                child: Text(snapshot.data.response[0].coins ?? '0',
                                    style: TextStyle(
                                        fontSize: 20, fontFamily: 'montserrat', color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            InkWell(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 8.0, 24.0, 8.0),
                                child: AvatarGlow(
                                  child: ShapeOfView(
                                    height: 33,
                                    width: 33,
                                    shape: CircleShape(borderColor: Colors.lightBlueAccent, borderWidth: 1),
                                    elevation: 8,
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/icons/png/circle-avator-default-img.png',
                                      image: snapshot.data.response[0].image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  endRadius: 30,
                                  glowColor: Colors.cyanAccent,
                                ),
                              ),
                              onTap: () {
                                onTapAudio('icon');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => Statistics(
                                      xApiKey: widget.xApiKey,
                                      memberId: widget.memberId,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SlideInLeft(
                    child: ListView(
                      children: [
                        IcSgv(
                          ic: 'assets/icons/svg/stage.svg',
                          onClick: () {
                            onTapAudio('icon');
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Leaderboard()));
                          },
                        ),
                        IconButton(
                          icon: Image.asset(
                            'assets/icons/png/ic_statistic_whites.png',
                            height: 25,
                            width: 25,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          onPressed: () {
                            onTapAudio('icon');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => Statistics(
                                  xApiKey: widget.xApiKey,
                                  memberId: widget.memberId,
                                ),
                              ),
                            );
                          },
                        ),
                        IcSgv(
                          ic: 'assets/icons/svg/user.svg',
                          onClick: () {
                            onTapAudio('icon');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => Profile(
                                  xApiKey: widget.xApiKey,
                                  memberId: widget.memberId,
                                ),
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 20),
                          child: InkWell(
                            child: Icon(
                              Icons.settings,
                              size: 28,
                              color: Colors.white.withOpacity(0.5),
                            ),
                            onTap: () {
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
                                            builder: (BuildContext context) =>
                                                OldSetting(isMusicOn, isNotifiOn, isSfxOn, widget.memberId))),
                                  });
                            },
                          ),
                        ),


                        InkWell(
                          child: Icon(
                            Icons.share,
                            size: 25,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          onTap: () {
                            onTapAudio('icon');
                            _onShare(context, Constants.shareAndroidTxt, Constants.appName);
                            // urlFileShare();
                          },
                        ),


                        Padding(
                          padding: const EdgeInsets.only(top: 20,),
                          child: InkWell(
                            child: Icon(
                              Icons.logout,
                              size: 25,
                              color: Colors.white.withOpacity(0.5),
                            ),
                            onTap: () {
                              onTapAudio('icon');
                              SharedPreferenceHelper().clearPrefData();
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LogIn(),),);
                              // urlFileShare();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    //height: double.maxFinite,
                    color: Color(0xFF314453),
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: ZoomIn(child: CarouselAutoSlider(xApiKey: '56005600')),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 12, left: 8, right: 6),
                    child: ListView(
                      children: [
                        BtnLeftBorderSq(
                          text: 'PLAY',
                          onClick: () {
                            onTapAudio('button');
                            Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => GameOption(),),);
                          },
                        ),
                        BtnLeftBorderSq(
                          text: 'GAMES',
                          onClick: () {
                            onTapAudio('button');
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (BuildContext context) => Games(
                                  xApiKey: widget.xApiKey,
                                  memberId: widget.memberId,
                                ),
                              ),
                            );
                          },
                        ),
                        BtnLeftBorderSq(
                          text: 'GAME RULES',
                          onClick: () {
                            onTapAudio('button');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => GameRule(
                                  xApiKey: widget.xApiKey,
                                  memberId: widget.memberId,
                                ),
                              ),
                            );
                          },
                        ),
                        BtnLeftBorderSq(
                          text: 'ABOUT',
                          onClick: () {
                            onTapAudio('button');
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AboutScreen(widget.xApiKey)));
                          },
                        ),
                        BtnLeftBorderSq(
                          text: 'QUIT',
                          onClick: () {
                            onTapAudio('button');
                            showExitDialog();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
