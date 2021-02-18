import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clash_of_cardz_flutter/bloc/api_bloc.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/base_application_fun.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/common_fun.dart';
import 'package:clash_of_cardz_flutter/helper/shared_preference_data.dart';
import 'package:clash_of_cardz_flutter/ui/screens/home.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:clash_of_cardz_flutter/model/responses/save_game_result_res_model.dart';

import 'game_option.dart';

class GameResult extends StatelessWidget {
  GameResult(
      {this.winnerName,
      this.winnerId,
      this.winnerImage,
      this.playedCards,
      this.clashType,
      this.winnerPoints,
      this.winnerCoins,
      this.cardType,
      this.isP1Won,
      this.gamePlayType});

  final String winnerName;
  final String winnerId;
  final String winnerImage;
  final String playedCards;
  final String clashType;
  final String winnerPoints;
  final String winnerCoins;
  final String cardType;
  final bool isP1Won;
  final String gamePlayType;

  @override
  Widget build(BuildContext context) {
    setScreenOrientationToLandscape();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
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
                    FadeInDownBig(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                        child: Pulse(
                          child: Image.asset('assets/images/bg_victory.png', fit: BoxFit.contain),
                          preferences:
                          AnimationPreferences(duration: const Duration(milliseconds: 5500), autoPlay: AnimationPlayStates.Loop),
                        ),
                      ),
                      preferences:
                      AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                    ),

                    //Lottie.asset('assets/animations/lottiefiles/confetti-on-transparent-background.json',
                        //width: double.infinity, height: double.infinity, repeat: true, animate: true, fit: BoxFit.contain),

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
                                  image: winnerImage??'',
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
                            child: Text(winnerName,
                                style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.w900, fontSize: 18)),
                          ),
                          preferences:
                              AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HeartBeat(
                              child: IconButton(
                                iconSize: 20,
                                icon: SvgPicture.asset('assets/icons/svg/card_count.svg',
                                color: Colors.yellow[600],),
                                onPressed: null,
                              ),
                              preferences: AnimationPreferences(
                                  duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Loop),
                            ),
                            FadeInLeftBig(
                              child: Padding(
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
                              preferences: AnimationPreferences(
                                  duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                            ),
                            RubberBand(
                              child: IconButton(
                                iconSize: 45,
                                icon: SvgPicture.asset('assets/icons/svg/competition.svg'),
                                onPressed: null,
                              ),
                              preferences: AnimationPreferences(
                                  duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Loop),
                            ),
                            Flip(
                              child: Padding(
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
                              preferences: AnimationPreferences(
                                  duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                            ),
                            Swing(
                              child: IconButton(
                                iconSize: 35,
                                icon: SvgPicture.asset('assets/icons/svg/coin.svg'),
                                onPressed: null,
                              ),
                              preferences: AnimationPreferences(
                                  duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Loop),
                            ),
                            FadeInRightBig(
                              child: Text(
                                winnerPoints,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[400]),
                              ),
                              preferences: AnimationPreferences(
                                  duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                            ),
                          ],
                        ),
                        FadeInUpBig(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Pulse(
                                child: MaterialButton(
                                  padding: EdgeInsets.fromLTRB(0.0, 8.0, 10.0, 0.0),
                                  splashColor: Colors.grey,
                                  child: Container(
                                    width: 140,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage('assets/icons/png/bg_button.png'), fit: BoxFit.fill),
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
                                  onPressed: () {
                                    onTapAudio('button');
                                    SharedPreferenceHelper().getUserSavedData().then((sharedPrefModel) {
                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen(xApiKey: sharedPrefModel.xApiKey, memberId: sharedPrefModel.memberId,)));
                                    });
                                  },
                                ),
                                preferences: AnimationPreferences(
                                    duration: const Duration(milliseconds: 2500), autoPlay: AnimationPlayStates.Loop),
                              ),

                              Pulse(
                                child: MaterialButton(
                                  padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                                  splashColor: Colors.grey,
                                  child: Container(
                                    width: 140,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage('assets/icons/png/bg_button.png'), fit: BoxFit.fill),
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
                                    onTapAudio('button');
                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => GameOption()));
                                  },
                                ),
                                preferences: AnimationPreferences(
                                    duration: const Duration(milliseconds: 2500), autoPlay: AnimationPlayStates.Loop),
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

                saveGameResultToServer(),
          ],
        )),
      ),
    );
  }

   Widget saveGameResultToServer() {
    if (gamePlayType == 'vsPlayer') {
      //save game result
    }

     var requestBody = {
       'match_result': [{
         "member_id": "MEM000004",
         "win": "1",
         "loss": "0",
         "points": "550"
       },
         { "member_id": "MEM000002",
           "win": "0",
           "loss": "1",
           "points": "0"
         }],
       'match_id': '2'
     };

    /*GameResultApiBody(
      memberId: '',
      win: isP1Won? '1':'0',
      loss: isP1Won? '0':'1',
      points: winnerPoints,
    );*/

     apiBloc.fetchSaveGameResultRes('ZGHrDz4prqsu4BcApPaQYaGgq', requestBody);

    if('' == ''){
      return StreamBuilder(
        stream: apiBloc.saveGameResultRes,
        builder: (context, AsyncSnapshot<SaveGameResultResModel> snapshot) {
          if (snapshot.hasData) {
            return Container();
          } else if (snapshot.hasError) {
            return showSnackBar('Could not save game result', context);
          }
          return Container();
        },
      );
    } else{
      return Container();
    }
  }

  showSnackBar(String message, BuildContext context){
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Retry',
        onPressed: () {
          onTapAudio('button');
          saveGameResultToServer();
        },
      ),
    );

    // Find the Scaffold in the widget tree and use
    // it to show a SnackBar.
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
