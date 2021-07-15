import 'package:clash_of_cardz_flutter/ui/screens/home.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/outlined_btn_gradient_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clash_of_cardz_flutter/bloc/api_bloc.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/base_application_fun.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/common_fun.dart';
import 'package:clash_of_cardz_flutter/helper/shared_preference_data.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'game_option.dart';

class GameResult extends StatelessWidget {
  final String xApiKey;
  final String p1FullName;
  final String p1MemberId;
  final String p1Photo;
  final String p2Name;
  final String p2MemberId;
  final String p2Image;
  final String gameCat1;
  final String gameCat2;
  final String gameCat3;
  final String gameCat4;
  final String playerType;
  final String gameType;
  final String cardsToPlay;
  final String p1Point;
  final String p2Point;
  final bool areYouWon;

  GameResult(
      this.xApiKey,
      this.p1FullName,
      this.p1MemberId,
      this.p1Photo,
      this.p2Name,
      this.p2MemberId,
      this.p2Image,
      this.gameCat1,
      this.gameCat2,
      this.gameCat3,
      this.gameCat4,
      this.playerType,
      this.gameType,
      this.cardsToPlay,
      this.p1Point,
      this.p2Point,
      this.areYouWon);

  @override
  Widget build(BuildContext context) {
    setScreenOrientationToLandscape();
    saveGameResultToServer(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xFF2C3F4B),
          body: Stack(
            alignment: Alignment.center,
            children: [
              FadeInDownBig(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: Pulse(
                    child: Image.asset('assets/images/bg_victory.png', fit: BoxFit.contain),
                    preferences: AnimationPreferences(duration: const Duration(milliseconds: 5500), autoPlay: AnimationPlayStates.Loop),
                  ),
                ),
                preferences: AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
              ),

              Lottie.asset('assets/animations/lottiefiles/confetti-on-transparent-background.json',
                  width: double.infinity, height: double.infinity, repeat: true, animate: true, fit: BoxFit.fitWidth, reverse: true),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ZoomIn(
                    child: Container(
                      margin: EdgeInsets.only(top: 100),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: CircleAvatar(
                          radius: 30,
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/icons/png/circle-avator-default-img.png',
                            image: areYouWon ? p1Photo : p2Image,
                            fit: BoxFit.fill,
                            width: 65,
                            height: 65,
                          ),
                        ),
                      ),
                    ),
                    preferences:
                    AnimationPreferences(duration: const Duration(milliseconds: 3000), autoPlay: AnimationPlayStates.Forward),
                  ),
                  FadeInDownBig(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        areYouWon ? p1FullName.toUpperCase() : p2Name.toUpperCase(),
                        style: TextStyle(
                          color: Colors.blue[100],
                          fontFamily: 'montserrat',
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    preferences:
                    AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HeartBeat(
                        child: SvgPicture.asset(
                          'assets/icons/svg/card_count.svg',
                          color: Colors.yellow[700],
                          width: 25,
                          height: 25,
                        ),
                        preferences:
                        AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Loop),
                      ),
                      FadeInLeftBig(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0, left: 6),
                          child: Text(
                            cardsToPlay,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[100]),
                          ),
                        ),
                        preferences:
                        AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                      ),
                      RubberBand(
                        child: SvgPicture.asset(
                          'assets/icons/svg/competition.svg',
                          width: 35,
                          height: 35,
                        ),
                        preferences:
                        AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Loop),
                      ),
                      Flip(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0, left: 8),
                          child: Text(
                            '1v1',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[100]),
                          ),
                        ),
                        preferences:
                        AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                      ),
                      HeartBeat(
                        child: IconButton(
                          iconSize: 45,
                          icon: Image.asset('assets/icons/png/coins.png'),
                          onPressed: null,
                        ),
                        preferences:
                        AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Loop),
                      ),
                      FadeInRightBig(
                        child: Text(
                          areYouWon ? p1Point : p2Point,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[100]),
                        ),
                        preferences:
                        AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                      ),
                    ],
                  ),
                  FadeInUpBig(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Pulse(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8, top: 5),
                            child: OutlinedBtnGradientBorder(
                              onPressed: () {
                                onTapAudio('button');
                                SharedPreferenceHelper().getUserSavedData().then((sharedPrefModel) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => Home(
                                        xApiKey: sharedPrefModel.xApiKey,
                                        memberId: sharedPrefModel.memberId,
                                      ),
                                    ),
                                  ).then((value) => Navigator.of(context, rootNavigator: true).pop());
                                });
                              },
                              height: 30,
                              width: 120,
                              child: Text(
                                "Home",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade100),
                              ),
                            ),
                          ),
                          preferences:
                          AnimationPreferences(duration: const Duration(milliseconds: 2500), autoPlay: AnimationPlayStates.Loop),
                        ),
                        Pulse(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, top: 5),
                            child: OutlinedBtnGradientBorder(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => GameOption()));
                              },
                              height: 30,
                              width: 120,
                              child: Text(
                                "Play Again",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade100),
                              ),
                            ),
                          ),
                          preferences:
                          AnimationPreferences(duration: const Duration(milliseconds: 2500), autoPlay: AnimationPlayStates.Loop),
                        ),
                      ],
                    ),
                    preferences:
                    AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                  ),
                ],
              ),
            ],
          ),
      ),
    );
  }

  void saveGameResultToServer(BuildContext context) async {
    if (gameType != 'vs Computer') {
      var matchDetails = [
        {"member_id": p1MemberId, "win": areYouWon ? "1" : '0', "loss": areYouWon ? "0" : '1', "points": p1Point},
        {"member_id": p2MemberId, "win": areYouWon ? "0" : '1', "loss": areYouWon ? "1" : '0', "points": p2Point}
      ];

      /* // sample of matchDetails body
    [{     "member_id": "MEM000004",
            "win": "1",
            "loss": "0",
            "points": "550",

        },{     "member_id": "MEM000002",
            "win": "0",
            "loss": "1",
            "points": "0"
        }]
    */

      apiBloc.fetchSaveGameResultRes(xApiKey, matchDetails, gameCat2);
    }
  }
}
