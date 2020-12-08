import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:trump_card_game/model/responses/profile_res_model.dart';
import 'package:trump_card_game/ui/screens/about.dart';
import 'package:trump_card_game/ui/screens/game_rules.dart';
import 'package:trump_card_game/ui/screens/gameplay.dart';
import 'package:trump_card_game/ui/screens/leaderboard.dart';
import 'package:trump_card_game/ui/screens/login.dart';
import 'package:trump_card_game/ui/screens/profile.dart';
import 'package:trump_card_game/ui/screens/setting.dart';
import 'package:trump_card_game/ui/screens/statistics.dart';
import 'package:trump_card_game/ui/widgets/custom/carousel_auto_slider.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_home_screen.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_searching_players.dart';
import 'package:trump_card_game/ui/widgets/libraries/giffy_dialog/giffy_dialog.dart';
import 'package:trump_card_game/ui/widgets/views/view_widgets.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_searching_players.dart';

import 'game_option.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setScreenOrientationToLandscape();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    apiBloc.fetchProfileRes('ZGHrDz4prqsu4BcApPaQYaGgq', "MEM000001");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                      return buildHomeScreenPlayerInfo(snapshot.data);
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return Center();
                  },
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.all(5),
                          child: IconButton(
                            icon: Image.asset('assets/icons/png/ic_profile_whites.png'),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Profile()));
                            },
                          ),
                          decoration:
                              Views.boxDecorationWidgetForIconWithBgColor(Colors.lightBlue, 4.0, Colors.grey, 5.0, 5.0, 3.0),
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
                  ),
                  Expanded(
                    flex: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //login button
                        MaterialButton(
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
                        MaterialButton(
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
                            Navigator.push(
                                context, CupertinoPageRoute(builder: (BuildContext context) => Gameplay(name: '', friendId: '')));
                          },
                        ),
                        MaterialButton(
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
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => GameRule()));
                          },
                        ),
                        MaterialButton(
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
                        MaterialButton(
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
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: CarouselAutoSlider(),
                    ),
                  ),
                  Expanded(
                    flex: 2,
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
                              Views.boxDecorationWidgetForIconWithBgColor(Colors.greenAccent, 4.0, Colors.grey, 5.0, 5.0, 3.0),
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
                            icon: Image.asset('assets/icons/png/ic_setting.png'),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Setting()));
                            },
                          ),
                          decoration: Views.boxDecorationWidgetForIconWithBgColor(Colors.black87, 4.0, Colors.grey, 5.0, 5.0, 3.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
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
        buttonOkText: Text('QUIT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        buttonOkColor: Colors.red,
        buttonCancelColor: Colors.greenAccent,
        buttonCancelText: Text('PLAY', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        onOkButtonPressed: () {
          SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
        },
      ),
    );
  }
}
