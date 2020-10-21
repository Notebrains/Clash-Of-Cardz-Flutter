import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trump_card_game/ui/screens/Wheel.dart';
import 'package:trump_card_game/ui/screens/game_more_option.dart';
import 'package:trump_card_game/ui/screens/game_result.dart';
import 'package:trump_card_game/ui/screens/gameplay.dart';
import 'package:trump_card_game/ui/screens/leaderboard.dart';
import 'package:trump_card_game/ui/screens/profile.dart';
import 'package:trump_card_game/ui/screens/semi_circle_menu.dart';
import 'package:trump_card_game/ui/screens/setting.dart';
import 'package:trump_card_game/ui/screens/statistics.dart';
import 'package:trump_card_game/ui/widgets/views/view_widgets.dart';

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
  bool _fromTop = true;
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 50,
                    alignment: AlignmentDirectional.topStart,
                    margin: EdgeInsets.all(8.0),
                    child: Stack(
                      children: <Widget>[
                        SizedBox(
                          width: 10.0,
                          height: 55.0,
                          child: OverflowBox(
                            alignment: AlignmentDirectional.topStart,
                            maxWidth: 250.0,
                            maxHeight: 55.0,
                            child: Container(
                              padding:
                                  new EdgeInsets.fromLTRB(30.0, 8.0, 30.0, 8.0),
                              margin: EdgeInsets.fromLTRB(30.0, 8.0, 8.0, 8.0),
                              child: new Text("Elena Denrik",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900)),
                              decoration: new BoxDecoration(
                                borderRadius:
                                    new BorderRadius.all(Radius.circular(30.0)),
                                color: Colors.black87,
                                border: Border.all(
                                    color: Colors.orangeAccent, width: 1.0),
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage('assets/images/img_person_demo.jpg'),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 50,
                    alignment: AlignmentDirectional.topEnd,
                    margin: EdgeInsets.all(8.0),
                    child: Stack(
                      children: <Widget>[
                        SizedBox(
                          width: 20.0,
                          height: 50.0,
                          child: OverflowBox(
                            alignment: AlignmentDirectional.topEnd,
                            maxWidth: 250.0,
                            maxHeight: 50,
                            child: Container(
                              padding:
                                  new EdgeInsets.fromLTRB(30.0, 8.0, 30.0, 8.0),
                              margin: EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
                              child: Text("Elena Denrik",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900)),
                              decoration: new BoxDecoration(
                                borderRadius:
                                    new BorderRadius.all(Radius.circular(30.0)),
                                color: Colors.black87,
                                border: Border.all(
                                    color: Colors.orangeAccent, width: 1.0),
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage('assets/icons/png/ic_points.png'),
                        ),
                      ],
                    ),
                  ),
                )
              ],
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
                          icon: Image.asset(
                              'assets/icons/png/ic_profile_whites.png'),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Profile()));
                          },
                        ),
                        decoration: Views.boxDecorationWidgetForIconWithBgColor(
                            Colors.lightBlue, 4.0, Colors.grey, 5.0, 5.0, 3.0),
                      ),
                      Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.all(5),
                          child: IconButton(
                            splashColor: Colors.white,
                            icon:
                                SvgPicture.asset('assets/icons/svg/logout.svg'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HomeScreen()));
                            },
                          ),
                          decoration:
                              Views.boxDecorationWidgetForIconWithBgColor(
                                  Colors.redAccent,
                                  4.0,
                                  Colors.grey,
                                  5.0,
                                  5.0,
                                  3.0)),
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
                          width: 230,
                          height: 55,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/icons/png/bg_button.png'),
                                fit: BoxFit.fill),
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
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => GameOption()));
                        },
                      ),
                      MaterialButton(
                        padding: EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
                        splashColor: Colors.grey,
                        child: Container(
                          width: 230,
                          height: 55,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/icons/png/bg_button.png'),
                                fit: BoxFit.fill),
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
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Gameplay()));
                        },
                      ),
                      MaterialButton(
                        padding: EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
                        splashColor: Colors.grey,
                        child: Container(
                          width: 230,
                          height: 55,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/icons/png/bg_button.png'),
                                fit: BoxFit.fill),
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
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => GameResult()));
                        },
                      ),
                      MaterialButton(
                        padding: EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
                        splashColor: Colors.grey,
                        child: Container(
                          width: 230,
                          height: 55,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/icons/png/bg_button.png'),
                                fit: BoxFit.fill),
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
                        // ),
                        onPressed: () {
                          //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
                        },
                      ),
                      MaterialButton(
                        padding: EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
                        splashColor: Colors.grey,
                        child: Container(
                          width: 230,
                          height: 55,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/icons/png/bg_button.png'),
                                fit: BoxFit.fill),
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
                          //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: FlipCard(
                    speed: 1000,
                    direction: FlipDirection.HORIZONTAL, // default
                    front: SizedBox(
                      width: 170,
                      height: 300,
                      child: Image.asset('assets/images/img_card_demo.png'),
                    ),
                    back: SizedBox(
                      width: 170,
                      height: 300,
                      child: Image.asset('assets/images/bg_card_back.png'),
                    ),
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
                          icon: Image.asset(
                              'assets/icons/png/ic_statistic_white.png'),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Leaderboard()));
                          },
                        ),
                        decoration: Views.boxDecorationWidgetForIconWithBgColor(
                            Colors.greenAccent,
                            4.0,
                            Colors.grey,
                            5.0,
                            5.0,
                            3.0),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        margin: EdgeInsets.all(5),
                        child: IconButton(
                          icon: Image.asset(
                              'assets/icons/png/ic_statistic_whites.png'),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Statistics()));
                          },
                        ),
                        decoration: Views.boxDecorationWidgetForIconWithBgColor(
                            Colors.indigoAccent,
                            4.0,
                            Colors.grey,
                            5.0,
                            5.0,
                            3.0),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        margin: EdgeInsets.all(5),
                        child: IconButton(
                          icon: Image.asset('assets/icons/png/ic_setting.png'),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Setting()));
                          },
                        ),
                        decoration: Views.boxDecorationWidgetForIconWithBgColor(
                            Colors.black87, 4.0, Colors.grey, 5.0, 5.0, 3.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showDialog() {
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: _fromTop ? Alignment.topCenter : Alignment.bottomCenter,
          child: Container(
            height: 300,
            child: SizedBox.expand(
                child: Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/images/bg_img3.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    splashColor: Colors.grey,
                    child: Container(
                      alignment: Alignment.center,
                      width: 270,
                      height: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/icons/png/bg_button.png'),
                            fit: BoxFit.fill),
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Image.asset(
                                  'assets/icons/png/ic_music_on.png'),
                              onPressed: null,
                            ),
                            Text(
                              "Music",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                            Switch(
                              value: _value,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _value = newValue;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    // ),
                    onPressed: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
                    },
                  ),
                  MaterialButton(
                    splashColor: Colors.grey,
                    child: Container(
                      width: 270,
                      height: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/icons/png/bg_button.png'),
                            fit: BoxFit.fill),
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Image.asset(
                                  'assets/icons/png/ic_notification_on.png'),
                              onPressed: null,
                            ),
                            Text(
                              "Notification",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                            Switch(
                              value: _value,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _value = newValue;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    // ),
                    onPressed: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
                    },
                  ),
                  MaterialButton(
                    padding: EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
                    splashColor: Colors.grey,
                    child: Container(
                      width: 270,
                      height: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/icons/png/bg_button.png'),
                            fit: BoxFit.fill),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
                        child: Text(
                          "Logout",
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
                      //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Player Id: MIS0034521T",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'montserrat',
                          color: Colors.black87),
                    ),
                  ),
                  Text(
                    "Version: 1.0.1",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'montserrat',
                        color: Colors.black87),
                  ),
                ],
              ),
            )),
            margin: EdgeInsets.only(top: 50, left: 112, right: 112, bottom: 50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, _fromTop ? -1 : 1), end: Offset(0, 0))
                  .animate(anim1),
          child: child,
        );
      },
    );
  }
}
