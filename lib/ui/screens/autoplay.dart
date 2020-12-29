import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:trump_card_game/helper/constantvalues/constants.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:trump_card_game/helper/shared_preference_data.dart';
import 'package:trump_card_game/model/state_managements/autoplay_states_model.dart';
import 'package:trump_card_game/ui/widgets/custom/frosted_glass.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_autoplay.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_auto_play_cards.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:trump_card_game/model/responses/cards_res_model.dart';
import 'package:flutter_animator/flutter_animator.dart';

import 'game_result.dart';

class AutoPlay extends StatelessWidget {
  AutoPlay({this.name, this.friendId});

  final List<String> playerResultStatusList = [];
  final String name;
  final String friendId;

  int indexOfP1Card = 0;

  @override
  Widget build(BuildContext context) {
    apiBloc.fetchCardsRes("ZGHrDz4prqsu4BcApPaQYaGgq", 'cricket', 'sports', '2', '14');

    return Scaffold(
      // Provide the model to all widgets within the app. We're using
      // ChangeNotifierProvider because that's a simple way to rebuild
      // widgets when a model changes. We could also just use
      // Provider, but then we would have to listen to Counter ourselves.
      // Read Provider's docs to learn about all the available providers.
      body: ChangeNotifierProvider(
        // Initialize the model in the builder. That way, Provider
        // can own AutoPlayStatesModel's lifecycle, making sure to call `dispose`
        // when not needed anymore.
        create: (context) => AutoPlayStatesModel(),
        child: StreamBuilder(
          stream: apiBloc.cardsRes,
          builder: (context, AsyncSnapshot<CardsResModel> snapshot) {
            if (snapshot.hasData) {
              return Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/bg_img11.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: BuildPlayer1Screen(snapshot.data.response.cards.length),
                        ),
                        Expanded(
                          flex: 7,
                          child: Consumer<AutoPlayStatesModel>(
                            builder: (context, statesModel, child) => statesModel.isCardDeckClickedToBuildNewCard ? Container(
                              //width: getScreenWidth(context) - 400,
                              child: Column(
                                children: [
                                  Container(
                                    height: getScreenHeight(context)/6.0,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Lottie.asset('assets/animations/lottiefiles/timer-moving.json', height: 50, width: 50),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0, top: 6),
                                          child: TweenAnimationBuilder<Duration>(
                                              duration: Duration(minutes: 3),
                                              tween: Tween(begin: Duration(minutes: 3), end: Duration.zero),
                                              onEnd: () {
                                                print('Timer Ended');
                                                /*Navigator.push(context,
                                                  CupertinoPageRoute(
                                                    builder: (context) => new GameResult(winnerName: 'Rex Scout', winnerId:'MEM00003', winnerImage: Constants.imgUrlTest, winnerCoins: '200',
                                                        winnerPoints: '12', cardType: 'Cricket', clashType: '1 vs 1', playedCards: '16'),
                                                  ),
                                                );*/
                                              },

                                              builder: (BuildContext context, Duration value, Widget child) {
                                                final minutes = value.inMinutes;
                                                final seconds = value.inSeconds % 60;
                                                return Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                                  child: Text(
                                                    '$minutes:$seconds min',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 26,
                                                      shadows: [
                                                        Shadow(color: Colors.white),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: getScreenHeight(context)/1.5,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 200,
                                            height: 250,
                                            child: BounceInLeft(
                                              child: buildPlayerOneCard(
                                                context,
                                                snapshot.data.response.cards,
                                                onClickAction: (int indexOfP1Card, String attributeTitle,
                                                    String attributeValue, String cardId) =>
                                                {
                                                  //print('----p1c clicked'),
                                                  this.indexOfP1Card = indexOfP1Card,
                                                  context.read<AutoPlayStatesModel>().updateAutoPlayStates(
                                                      indexOfP1Card, attributeTitle, attributeValue, cardId, true, false),
                                                },

                                                  // context.read<AutoPlayStatesModel>().updateCardCountOnDeck(statesModel.cardCountOnDeck - 1 , false);
                                              ),
                                              preferences: AnimationPreferences(
                                                  duration: const Duration(milliseconds: 1500),
                                                  autoPlay: AnimationPlayStates.Forward),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Container(
                                            width: 200,
                                            height: 250,
                                            child: BounceInRight(
                                              child: buildPlayerTwoCard(
                                                context,
                                                indexOfP1Card,
                                                snapshot.data.response.cards,
                                                onClickActionP2: (int indexOfP2Card, bool isWon, int winPoint) => {
                                                  //print('---- p2c data called ${statesModel.isCardOneTouched}'),

                                                  //context.read<AutoPlayStatesModel>().updateAutoPlayStates(
                                                  //indexOfP2Card, 'attributeTitle', 'attributeValue', 'cardId', false, true),

                                                  //adding data in match result status list and
                                                  //updating card index and scoreboard values

                                                  context.read<AutoPlayStatesModel>().updateRebuildDeck(false),

                                                  if (isWon){
                                                    playerResultStatusList.add("won"),

                                                    statesModel.playerOneTrump = statesModel.playerOneTrump + 1,
                                                    statesModel.player1TotalPoints = statesModel.player1TotalPoints + winPoint,

                                                    //showing lottie anim depending on win or loose
                                                    /*SharedPreferenceHelper().getUserImage().then((photoUrl) =>
                                                        showWinDialog(context, isWon, 'win-result.json', 'You Won', photoUrl),
                                                    ),*/

                                                  } else {
                                                    playerResultStatusList.add("sad"),
                                                    statesModel.playerTwoTrump = statesModel.playerOneTrump + 1,
                                                    statesModel.player2TotalPoints = statesModel.player2TotalPoints + winPoint,
                                                    //showing lottie anim depending on win or loose
                                                    // showWinDialog(context, isWon, 'sad-star.json', '\n\n\n\nYou Loose', ''),
                                                  },

                                                  statesModel.playerOneLeft = statesModel.playerOneLeft - 1,
                                                  statesModel.playerTwoLeft = statesModel.playerTwoLeft - 1,
                                                  statesModel.cardsDeckIndex = statesModel.cardsDeckIndex + 1,
                                                  statesModel.cardsDeckSize = (snapshot.data.response.cards.length/2).round(),

                                                  context.read<AutoPlayStatesModel>().updatePlayerScoreboards(
                                                      statesModel.playerOneTrump,
                                                      statesModel.playerTwoTrump,
                                                      statesModel.player1TotalPoints,
                                                      statesModel.player2TotalPoints,
                                                      statesModel.cardsDeckIndex,
                                                      false,
                                                      true
                                                  ),

                                                },
                                              ),
                                              preferences: AnimationPreferences(
                                                  duration: const Duration(milliseconds: 1500),
                                                  autoPlay: AnimationPlayStates.Forward),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      //height: getScreenHeight(context) / 6.5,
                                      child: Visibility(
                                          visible: statesModel.isShowPlayerMatchStatus,
                                          child: Container(
                                            child: RotateInUpLeft(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
                                                height: 30,
                                                child: ListView.builder(
                                                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount: playerResultStatusList.length,
                                                  itemBuilder: (context, index) {
                                                    return Card(
                                                      elevation: 5,
                                                      shadowColor: Colors.lightBlueAccent,
                                                      color: Colors.white60,
                                                      child: Consumer<AutoPlayStatesModel>(
                                                        builder: (context, statesModel, child) => ClipOval(
                                                          child: setResultStatus(index),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              preferences: AnimationPreferences(
                                                  duration: const Duration(milliseconds: 400),
                                                  autoPlay: AnimationPlayStates.Forward),
                                            ),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ) : GestureDetector(
                              child: Container(
                                color: Colors.transparent,
                                child: Center(
                                  child: Lottie.asset(
                                      'assets/animations/lottiefiles/flip-card-orange.json', height: 500, width:400,
                                      repeat: true,
                                      animate: true
                                  ),
                                ),
                              ),

                              onTap: (){
                                context.read<AutoPlayStatesModel>().updateRebuildDeck(true);
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: BuildPlayerTwoScreen(snapshot.data.response.cards.length),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else if (!snapshot.hasData) {
              return frostedGlassWithProgressBarWidget(context);
            } else
              return Center(
                child: Text("No Data Found", style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 30)),
              );
          },
        ),
      ),
    );
  }

  Widget setResultStatus(int index) {
    return playerResultStatusList[index] == 'won'
        ? SvgPicture.asset('assets/icons/svg/${playerResultStatusList[index]}.svg', height: 25, width: 25)
        : SvgPicture.asset('assets/icons/svg/${playerResultStatusList[index]}.svg', height: 25, width: 25);
  }

  void showWinDialog(BuildContext context, bool isWon, String lottieFileName, String message, String photoUrl) {
    BuildContext dialogContext;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        dialogContext = context;
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(children: <Widget>[
            GestureDetector(
              child: Center(
                child: Lottie.asset('assets/animations/lottiefiles/$lottieFileName',
                    height: 290, width: 290, repeat: false, animate: true),
              ),

              onTap: (){

              },
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.network(
                      photoUrl,
                      fit: BoxFit.fill,
                      width: 65,
                      height: 65,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      message,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'neuropol_x_rg',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        );
      },
    );
    Timer(Duration(milliseconds: 30000), () {
      Navigator.pop(dialogContext);
    });
  }
}

/*
Consumer<AutoPlayStatesModel>(
                            builder: (context, statesModel, child) => statesModel.isCardDeckClickedToBuildNewCard ?  : GestureDetector(
                              child: Container(
                                color: Colors.transparent,
                                child: Center(
                                  child: Lottie.asset(
                                      'assets/animations/lottiefiles/flip-card-orange.json',
                                      repeat: true,
                                      animate: true
                                  ),
                                ),
                              ),

                              onTap: (){
                                context.read<AutoPlayStatesModel>().updateCardCountOnDeck(statesModel.cardCountOnDeck, true);
                              },
                            ),
* */
