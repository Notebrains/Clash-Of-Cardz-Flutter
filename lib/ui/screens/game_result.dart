import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trump_card_game/helper/constantvalues/constants.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:trump_card_game/ui/screens/home.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'game_option.dart';

class GameResult extends StatelessWidget {
  GameResult({this.winnerName, this.winnerId, this.winnerImage, this.playedCards, this.clashType, this.winnerPoints,
    this.winnerCoins, this.cardType});
  final String winnerName;
  final String winnerId;
  final String winnerImage;
  final String playedCards;
  final String clashType;
  final String winnerPoints;
  final String winnerCoins;
  final String cardType;


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
                  child: Image.asset('assets/images/bg_victory.png', fit: BoxFit.contain)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 100),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(winnerImage),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Eliando Denrik",
                        style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.w900, fontSize: 18)),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: SvgPicture.asset('assets/icons/svg/card_count.svg'),
                        onPressed: null,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          playedCards,
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
                        icon: SvgPicture.asset('assets/icons/svg/clash_type.svg'),
                        onPressed: null,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          clashType,
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
                        winnerCoins,
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
                        padding: EdgeInsets.fromLTRB(0.0, 8.0, 10.0, 0.0),
                        splashColor: Colors.grey,
                        child: Container(
                          width: 140,
                          height: 45,
                          decoration: BoxDecoration(
                            image:
                                DecorationImage(image: AssetImage('assets/icons/png/bg_button.png'),
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
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
                        },
                      ),
                      MaterialButton(
                        padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                        splashColor: Colors.grey,
                        child: Container(
                          width: 140,
                          height: 45,
                          decoration: BoxDecoration(
                            image:
                                DecorationImage(image: AssetImage('assets/icons/png/bg_button.png'), fit: BoxFit.fill),
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
                              context, MaterialPageRoute(builder: (BuildContext context) => GameOption()));
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
