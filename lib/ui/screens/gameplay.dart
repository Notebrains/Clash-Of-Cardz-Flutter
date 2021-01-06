import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:trump_card_game/helper/constantvalues/constants.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:trump_card_game/helper/shared_preference_data.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:trump_card_game/model/state_managements/gameplay_states_model.dart';
import 'package:trump_card_game/ui/widgets/custom/frosted_glass.dart';
import 'package:provider/provider.dart';
import 'package:trump_card_game/model/responses/cards_res_model.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_game_play_cards.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_gameplay.dart';

import 'game_result.dart';

class Gameplay extends StatelessWidget {
  Gameplay({this.joinedPlayerName, this.joinedPlayerId, this.joinedPlayerImage});

  final List<String> playerResultStatusList = [];
  final String joinedPlayerName;
  final String joinedPlayerId;
  final String joinedPlayerImage;
  int indexOfP1Card = 0;
  int indexOfCardDeck = 0;

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
        // can own GamePlayStatesModel's lifecycle, making sure to call `dispose`
        // when not needed anymore.
        create: (context) => GamePlayStatesModel(),
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
                          child: Consumer<GamePlayStatesModel>(
                            builder: (context, statesModel, child) =>
                                Container(
                                  //width: getScreenWidth(context) - 400,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: getScreenHeight(context) / 6.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 0.0, top: 0),
                                              child: TweenAnimationBuilder<Duration>(
                                                  duration: Duration(minutes: 45),
                                                  tween: Tween(begin: Duration(minutes: 45), end: Duration.zero),
                                                  onEnd: () {
                                                    print('Timer Ended');
                                                    if (statesModel.player1TotalPoints > statesModel.player2TotalPoints) {
                                                      showTimesUpDialog(context, true, statesModel);
                                                    } else {
                                                      showTimesUpDialog(context, false, statesModel);
                                                    }
                                                  },
                                                  builder: (BuildContext context, Duration value, Widget child) {

                                                    //adding 0 at first if min or sec show in single digit
                                                    final minutes = (value.inMinutes).toString().padLeft(2, "0");
                                                    final seconds = (value.inSeconds % 60).toString().padLeft(2, "0");
                                                    return Row(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.all(5),
                                                          child: Container(
                                                            width: 60,
                                                            height: 50,
                                                            decoration: BoxDecoration(
                                                              color: Colors.grey[400],
                                                              border: Border.all(
                                                                color: Colors.grey[350],
                                                                width: 5,
                                                              ),
                                                              borderRadius: BorderRadius.all(Radius.circular(6)),
                                                              boxShadow: <BoxShadow>[
                                                                BoxShadow(
                                                                  color: Colors.grey[500],
                                                                  blurRadius: 8.0,
                                                                  offset: Offset(0.0, 8.0),
                                                                ),
                                                              ],
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                '$minutes',
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                  color: Colors.deepOrangeAccent[700],
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 26,
                                                                  shadows: [
                                                                    Shadow(color: Colors.white),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        Padding(
                                                          padding: const EdgeInsets.only(bottom:8.0),
                                                          child: Text(
                                                            ':',
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              color: Colors.deepOrangeAccent[700],
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 46,
                                                              shadows: [
                                                                Shadow(color: Colors.white),
                                                              ],
                                                            ),
                                                          ),
                                                        ),

                                                        Padding(
                                                          padding: const EdgeInsets.all(5),
                                                          child: Container(
                                                            width: 60,
                                                            height: 50,
                                                            decoration: BoxDecoration(
                                                              color: Colors.grey[400],
                                                              border: Border.all(
                                                                color: Colors.grey[350],
                                                                width: 5,
                                                              ),
                                                              borderRadius: BorderRadius.all(Radius.circular(8)),
                                                              boxShadow: <BoxShadow>[
                                                                BoxShadow(
                                                                  color: Colors.grey[500],
                                                                  blurRadius: 8.0,
                                                                  offset: Offset(0.0, 8.0),
                                                                ),
                                                              ],
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                '$seconds',
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                  color: Colors.deepOrangeAccent[700],
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 26,
                                                                  shadows: [
                                                                    Shadow(color: Colors.white),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: getScreenHeight(context) / 1.5,
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
                                                    indexOfCardDeck,
                                                    onClickActionOnP1GameplayCard:
                                                        (int indexOfP1Card, String attributeTitle, String attributeValue) =>
                                                    {
                                                      //print('----p1c clicked'),
                                                      this.indexOfP1Card = indexOfP1Card,
                                                    },
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
                                                    indexOfCardDeck,
                                                    snapshot.data.response.cards,
                                                    onClickActionOnP2GameplayCard: (bool isWon, int winPoint) =>
                                                    {
                                                      print('---- p2c data called ${statesModel.isCardOneTouched}, $isWon, $winPoint'),
                                                      if (isWon)
                                                        {
                                                          playerResultStatusList.add("won"), // "won" is lottie file name

                                                          //showing lottie anim depending on win or loose
                                                          SharedPreferenceHelper().getUserImage().then(
                                                                (photoUrl) =>
                                                                showWinDialog(
                                                                    context,
                                                                    statesModel,
                                                                    isWon,
                                                                    'win-result.json',
                                                                    'You Won',
                                                                    photoUrl,
                                                                    4000,
                                                                    winPoint),
                                                          ),
                                                        }
                                                      else
                                                        {
                                                          playerResultStatusList.add("sad"), // "sad" is lottie file name
                                                          //showing lottie anim depending on win or loose
                                                          showWinDialog(
                                                              context,
                                                              statesModel,
                                                              isWon,
                                                              'sad-star.json',
                                                              '\n\n\n\nYou Loose',
                                                              '',
                                                              3500,
                                                              winPoint),
                                                        },
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
                                                      physics: const BouncingScrollPhysics(
                                                          parent: AlwaysScrollableScrollPhysics()),
                                                      scrollDirection: Axis.horizontal,
                                                      itemCount: playerResultStatusList.length,
                                                      itemBuilder: (context, index) {
                                                        return Card(
                                                          elevation: 5,
                                                          shadowColor: Colors.lightBlueAccent,
                                                          color: Colors.white60,
                                                          child: ClipOval(
                                                            child: setResultStatus(index),
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

  void showWinDialog(BuildContext context, GamePlayStatesModel statesModel, bool isWon, String lottieFileName, String message,
      String photoUrl, int animHideTime, int winPoint) {
    BuildContext dialogContext;
    showDialog(
      context: context,
      barrierDismissible: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        dialogContext = context;
        return Dialog(
          backgroundColor: Colors.transparent,
          child: FadeInUp(
            child: Stack(
              children: <Widget>[
                Center(
                  child: Lottie.asset('assets/animations/lottiefiles/$lottieFileName',
                      height: 290, width: 290, repeat: false, animate: true),
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
              ],
            ),
            preferences: AnimationPreferences(duration: const Duration(milliseconds: 800), autoPlay: AnimationPlayStates.Forward),
          ),
        );
      },
    );
    try {
      //adding data in match result status list and
      //updating card index and scoreboard values
      indexOfCardDeck = indexOfCardDeck + 1;

      if (isWon) {
        statesModel.playerOneTrump = statesModel.playerOneTrump + 1;
        statesModel.player1TotalPoints = statesModel.player1TotalPoints + winPoint;
      } else {
        statesModel.playerTwoTrump = statesModel.playerOneTrump + 1;
        statesModel.player2TotalPoints = statesModel.player2TotalPoints + winPoint;
      }

      statesModel.cardsDeckIndex = statesModel.cardsDeckIndex + 1;

      Timer(Duration(milliseconds: animHideTime), () {
        Navigator.pop(dialogContext);

        context.read<GamePlayStatesModel>().updatePlayerScoreboards(
            statesModel.playerOneTrump,
            statesModel.playerTwoTrump,
            statesModel.player1TotalPoints,
            statesModel.player2TotalPoints,
            statesModel.cardsDeckIndex,
            false,
            false);

        context.read<GamePlayStatesModel>().updateCardCountOnDeck(statesModel.cardCountOnDeck - 1);

        print('------statesModel.cardCountOnDeck: ${statesModel.cardCountOnDeck}');
        if (statesModel.cardCountOnDeck == 0) {
          gotoResultScreen(context, true, statesModel);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void showTimesUpDialog(BuildContext context, bool isP1Won, GamePlayStatesModel statesModel) {
    BuildContext dialogContext;
    showDialog(
      context: context,
      barrierDismissible: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        dialogContext = context;
        return Dialog(
          backgroundColor: Colors.transparent,
          child: FadeInUp(
            child: Center(
              child: Lottie.asset('assets/animations/lottiefiles/times-up.json',
                  height: 290, width: 290, repeat: false, animate: true),
            ),
            preferences: AnimationPreferences(duration: const Duration(milliseconds: 800), autoPlay: AnimationPlayStates.Forward),
          ),
        );
      },
    );

    String winnerUrl = "";

    Timer(Duration(milliseconds: 3000), () {
      SharedPreferenceHelper().getUserImage().then(
            (photoUrl) => winnerUrl = photoUrl,
      );

      Navigator.pop(dialogContext);
      gotoResultScreen(context, isP1Won, statesModel);
    });
  }

  void gotoResultScreen(BuildContext context, bool isP1Won, GamePlayStatesModel statesModel) {
    String winnerUrl = "";

    SharedPreferenceHelper().getUserImage().then(
          (photoUrl) => winnerUrl = photoUrl,
    );

    isP1Won ? Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) =>
            GameResult(
              winnerName: 'Ram Rakshman',
              winnerId: 'MEM000004',
              winnerImage: winnerUrl,
              winnerCoins: "0",
              winnerPoints: statesModel.player1TotalPoints.toString(),
              cardType: 'Cricket',
              clashType: '1 vs 1',
              playedCards: '14',
              isP1Won: true,
            ),
      ),
    ) :
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) =>
            GameResult(
              winnerName: 'Raj Malhotra',
              winnerId: 'MEM000004',
              winnerImage: Constants.imgUrlTest,
              winnerCoins: "0",
              winnerPoints: statesModel.player2TotalPoints.toString(),
              cardType: 'Cricket',
              clashType: '1 vs 1',
              playedCards: '14',
              isP1Won: false,
            ),
      ),
    );
  }
}
