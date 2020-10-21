import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:trump_card_game/ui/screens/game_option.dart';
import 'package:trump_card_game/ui/screens/home.dart';

class GameResult extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    setScreenOrientationToLandscape();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset('assets/images/bg_img13.png', fit: BoxFit.fill),
          ),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: Image.asset('assets/images/bg_victory.png',
                      fit: BoxFit.contain)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 100),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage('assets/images/img_person_demo.jpg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Elena Denrik",
                        style: TextStyle(
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.w900,
                            fontSize: 18)),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Image.asset('assets/icons/png/ic_points.png'),
                        onPressed: null,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          "16",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[400]),
                        ),
                      ),
                      IconButton(
                        icon: Image.asset('assets/icons/png/ic_points.png'),
                        onPressed: null,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          "16",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[400]),
                        ),
                      ),
                      IconButton(
                        icon: Image.asset('assets/icons/png/ic_points.png'),
                        onPressed: null,
                      ),
                      Text(
                        "16",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[400]),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                        splashColor: Colors.grey,
                        child: Container(
                          width: 150,
                          height: 45,
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
                              "Home",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                          ),
                        ),
                        // ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      HomeScreen()));
                        },
                      ),
                      MaterialButton(
                        padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                        splashColor: Colors.grey,
                        child: Container(
                          width: 150,
                          height: 45,
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
                              "Play Again",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                          ),
                        ),
                        // ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      GameOption()));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      )),
    );
  }
}
