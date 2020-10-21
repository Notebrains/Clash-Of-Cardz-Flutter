import 'package:flutter/material.dart';
import 'package:trump_card_game/helper/constantvalues/constansts.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flip_card/flip_card.dart';
import 'package:trump_card_game/ui/screens/home.dart';

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
              image: new AssetImage("assets/images/bg_img3.png"),
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
                          color: Colors.grey[700],
                        ),
                      ),

                      //login button
                      MaterialButton(
                        padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
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
                          child: Container(
                            width: 170,
                            height: 45,
                            padding: EdgeInsets.fromLTRB(24.0, 5.0, 24.0, 16.0),
                            child: Text(
                              "LOGIN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'neuropol_x_rg',
                                  color: Colors.black87),
                            ),
                          ),
                        ),
                        // ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
                        },
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: SvgPicture.asset(
                                'assets/icons/svg/google.svg'),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Image.asset(
                                'assets/icons/png/ic_google_play_games.png'),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: SvgPicture.asset(
                                'assets/icons/svg/facebook.svg'),
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
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700]),
                        ),
                      ),

                      Text(
                        "Play As Guest",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24.0,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'neuropol_x_rg',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
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
