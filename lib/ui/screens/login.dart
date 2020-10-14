import 'package:flutter/material.dart';
import 'package:trump_card_game/helper/constantvalues/constansts.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setScreenOrientationToLandscape();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/bg_blur_3.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Constants.appName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 55.0,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Rapier',
                          color: Colors.white,
                        ),
                      ),

                      //login button
                      MaterialButton(
                        padding: EdgeInsets.all(8.0),
                        textColor: Colors.white70,
                        splashColor: Colors.greenAccent,
                        elevation: 4.0,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/icons/png/bg_button.png'),
                                fit: BoxFit.cover),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'neuropol_x_rg',
                                  color: Colors.black87),
                            ),
                          ),
                        ),
                        // ),
                        onPressed: () {
                          print('Tapped');
                        },
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: SvgPicture.asset(
                                'assets/icons/svg/google.svg',
                                semanticsLabel: ''),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Image.asset(
                                'assets/icons/png/ic_google_play_games.png'),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: SvgPicture.asset(
                                'assets/icons/svg/facebook.svg',
                                semanticsLabel: ''),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Or",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'neuropol_x_rg',
                              color: Colors.white),
                        ),
                      ),

                      Text(
                        "Play As Guest",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24.0,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: SizedBox(
                      width: 170,
                      height: 300,
                      child: Image.asset('assets/images/img_card_demo.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginStateFull extends StatefulWidget {
  const LoginStateFull({Key key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LoginStateFull> {
  @override
  Widget build(BuildContext context) {
    return Container(color: const Color(0xFFFFE306));
  }
}
