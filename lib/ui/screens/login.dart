import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trump_card_game/helper/constantvalues/constansts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trump_card_game/ui/screens/home.dart';
import 'package:trump_card_game/ui/widgets/custom/carousel_auto_slider.dart';
import 'package:trump_card_game/ui/widgets/libraries/animated_text_kit/animated_text_kit.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

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
        child: Center(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ColorizeAnimatedTextKit(
                      onTap: () {
                        //print("Tap Event");
                      },
                      text: [
                        "CLASH OF CARDZ"
                      ],
                      textStyle: TextStyle(
                        fontSize: 55.0,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Rapier'
                      ),
                      colors: [
                        Colors.grey[700],
                        Colors.deepOrange,
                        Colors.grey[700],
                      ],
                      textAlign: TextAlign.center,
                      alignment: AlignmentDirectional.center,
                      // or Alignment.topLeft
                      isRepeatingAnimation: true,
                      repeatForever: true,
                      speed: Duration(milliseconds: 1000),
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
                      onPressed: () {Navigator.of(context).push(new PageRouteWithAnimation());
                      //onPressed: () {Navigator.push(context, _pageRouteBuilder());
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
                          fontSize: 22.0,
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
                child: Container(
                  margin: EdgeInsets.fromLTRB(80, 0, 80, 0),
                  child: CarouselAutoSlider(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PageRouteWithAnimation extends CupertinoPageRoute {
  PageRouteWithAnimation()
      : super(builder: (BuildContext context) => new HomeScreen());

  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new ScaleTransition(
      scale: animation,
      child: new FadeTransition(
        opacity: animation,
        child: new HomeScreen(),
      ),
    );
  }
}