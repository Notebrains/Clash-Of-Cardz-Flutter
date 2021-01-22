import 'dart:io' show File, Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:trump_card_game/helper/constantvalues/constants.dart';
import 'package:trump_card_game/helper/shared_preference_data.dart';
import 'package:trump_card_game/model/responses/profile_res_model.dart';
import 'package:trump_card_game/ui/screens/about.dart';
import 'package:trump_card_game/ui/screens/autoplay.dart';
import 'package:trump_card_game/ui/screens/game_rules.dart';
import 'package:trump_card_game/ui/screens/gameplay.dart';
import 'package:trump_card_game/ui/screens/leaderboard.dart';
import 'package:trump_card_game/ui/screens/login.dart';
import 'package:trump_card_game/ui/screens/profile.dart';
import 'package:trump_card_game/ui/screens/setting.dart';
import 'package:trump_card_game/ui/screens/statistics.dart';
import 'package:trump_card_game/ui/widgets/custom/carousel_auto_slider.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_home_screen.dart';
import 'package:trump_card_game/ui/widgets/libraries/giffy_dialog/giffy_dialog.dart';
import 'package:trump_card_game/ui/widgets/libraries/share_package.dart';
import 'package:trump_card_game/ui/widgets/views/view_widgets.dart';

import 'game_option.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;


class HomeScreen extends StatefulWidget {

  HomeScreen({this.xApiKey, this.memberId});
  final String xApiKey;
  final String memberId;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    print('Home-apiKey ${widget.xApiKey}');
    print('Home-memberId ${widget.memberId}');

    apiBloc.fetchProfileRes(widget.xApiKey, widget.memberId);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
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
                                icon: Image.asset('assets/icons/png/ic_setting.png'),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Setting()));
                                },
                              ),
                              decoration:
                              Views.boxDecorationWidgetForIconWithBgColor(Colors.black87, 4.0, Colors.grey, 5.0, 5.0, 3.0),
                            ),

                            Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(5),
                              child: IconButton(
                                icon: Image.asset('assets/icons/png/share.png'),
                                onPressed: () {
                                  //_onShare(context, [], Constants.shareTxt, Constants.appName);
                                  urlFileShare();
                                },
                              ),
                              decoration:
                              Views.boxDecorationWidgetForIconWithBgColor(Colors.greenAccent[700], 4.0, Colors.grey, 5.0, 5.0, 3.0),
                            ),

                            Container(
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.all(5),
                                child: IconButton(
                                  splashColor: Colors.white,
                                  icon: SvgPicture.asset('assets/icons/svg/logout.svg'),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LogIn()));
                                  },
                                ),
                                decoration:
                                Views.boxDecorationWidgetForIconWithBgColor(Colors.redAccent, 4.0, Colors.grey, 5.0, 5.0, 3.0)),
                          ],
                        ),
                        preferences:
                        AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //login button
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
                                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
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
                                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
                                  child: Text(
                                    "CARDS",
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
                                //change here
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (BuildContext context) =>
                                      /*Gameplay(
                                                p2Name: 'Ram',
                                                p2MemberId: 'MEM000001',
                                                p2Image: 'https:\/\/encrypted-tbn0.gstatic.com\/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU',
                                                categoryName: 'Sports',
                                                subcategoryName: 'Cricket',
                                                gameType: 'Player vs Player',
                                                cardsToPlay: '14',

                                           ) */

                                    AutoPlay()
                                    ));
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
                                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
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
                              // ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) => GameRule(xApiKey: widget.xApiKey, memberId: widget.memberId,)));
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
                                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
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
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AboutScreen()));
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
                                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
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
                                showExitDialog();
                              },
                            ),
                            preferences:
                            AnimationPreferences(duration: const Duration(milliseconds: 1000), autoPlay: AnimationPlayStates.Forward),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: ZoomIn(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                          child: CarouselAutoSlider(),
                        ),
                        preferences:
                        AnimationPreferences(duration: const Duration(milliseconds: 2000), autoPlay: AnimationPlayStates.Forward),
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
                                icon: Image.asset('assets/icons/png/ic_statistic_white.png'),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Leaderboard()));
                                },
                              ),
                              decoration:
                              Views.boxDecorationWidgetForIconWithBgColor(Colors.greenAccent[700], 4.0, Colors.grey, 5.0, 5.0, 3.0),
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(5),
                              child: IconButton(
                                icon: Image.asset('assets/icons/png/ic_statistic_whites.png'),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Statistics()));
                                },
                              ),
                              decoration:
                              Views.boxDecorationWidgetForIconWithBgColor(Colors.indigoAccent, 4.0, Colors.grey, 5.0, 5.0, 3.0),
                            ),

                            Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(5),
                              child: IconButton(
                                icon: Image.asset('assets/icons/png/ic_profile_whites.png'),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) => Profile(xApiKey: widget.xApiKey, memberId: widget.memberId,)));
                                },
                              ),
                              decoration:
                              Views.boxDecorationWidgetForIconWithBgColor(Colors.lightBlue, 4.0, Colors.grey, 5.0, 5.0, 3.0),
                            ),
                          ],
                        ),
                        preferences:
                        AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
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

  void showExitDialog() {
    showDialog(
      context: context,
      builder: (_) =>
          AssetGiffyDialog(
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
        model.response[0].photo,
        model.response[0].points,
        model.response[0].coins,
        model.response[0].win,
        model.response[0].loss,
        model.response[0].matchPlayed,
        model.response[0].redeem,
        model.response[0].rank.toString()
    );
  }

  _onShare(BuildContext context, List<String> imagePaths, String text, String subject) async {
    // A builder is used to retrieve the context immediately
    // surrounding the RaisedButton.
    //
    // The context's `findRenderObject` returns the first
    // RenderObject in its descendent tree when it's not
    // a RenderObjectWidget. The RaisedButton's RenderObject
    // has its position and size after it's built.
    final RenderBox box = context.findRenderObject();

    if (imagePaths.isNotEmpty) {
      await Share.shareFiles(imagePaths,
          text: text,
          subject: subject,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    } else {
      await Share.share(text,
          subject: subject,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }

  Future<Null> urlFileShare() async {
    final RenderBox box = context.findRenderObject();
    if (Platform.isAndroid) {
      var url = 'https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg';
      var response = await get(url);
      final documentDirectory = (await getExternalStorageDirectory()).path;
      File imgFile = new File('$documentDirectory/clashOfCardz.png');
      imgFile.writeAsBytesSync(response.bodyBytes);

      Share.shareFiles([documentDirectory],
          subject: 'URL File Share',
          text: 'Hello, check your share files!',
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    } else {
      Share.share('Hello, check your share files!',
          subject: 'URL File Share',
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }
}
