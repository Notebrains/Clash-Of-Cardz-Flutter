import 'dart:async';
import 'dart:math';
import 'package:clash_of_cardz_flutter/ui/styles/size_config.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/no_cards_found.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/include_screens/include_game_play_dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:clash_of_cardz_flutter/bloc/api_bloc.dart';
import 'package:clash_of_cardz_flutter/helper/constantvalues/constants.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/base_application_fun.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/common_fun.dart';
import 'package:clash_of_cardz_flutter/helper/shared_preference_data.dart';
import 'package:clash_of_cardz_flutter/model/state_managements/autoplay_states_model.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/loading_sports_frosted_glass.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/include_screens/include_auto_play_win_screen.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/include_screens/include_autoplay.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/include_screens/include_auto_play_cards.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:clash_of_cardz_flutter/model/responses/cards_res_model.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/avatar_glow.dart';
import 'game_result.dart';


class AutoPlay extends StatelessWidget {
  final String xApiKey;
  final String gameCat1;
  final String gameCat2;
  final String gameCat3;
  final String gameCat4;
  final String playerType;
  final String gameType;
  final String cardToPlay;

  AutoPlay(
      {Key key, this.xApiKey, this.gameCat1, this.gameCat2, this.gameCat3, this.gameCat4, this.playerType, this.gameType, this.cardToPlay})
      : super(key: key);

  final List<String> playerResultStatusList = [];
  List<Cards> cards = [];

  int indexOfP1Card = 0;
  int indexOfCardDeck = 0;
  int indexOfCardDeckSelectForComputer = 55;
  String whoIsPlaying = 'player';
  bool isP1CardFlipped = false;
  bool isP1SelectedStats = false;

  String p1xApiKey = '';
  String p1FullName = '';
  String p1MemberId = '';
  String p1Points = '';
  String p1Photo = '';
  int gameTime = 5;

  final ValueNotifier<bool> p1Card1ValueNotify = ValueNotifier<bool>(true);
  final ValueNotifier<int> computerCard2ValueNotify = ValueNotifier<int>(0);


  @override
  Widget build(BuildContext context) {
    //print('----game cats autoplay: $gameCat1 , $gameCat2 , $gameCat3, $gameCat4, $cardToPlay, $playerType, $gameType, ');
    setScreenOrientationToLandscape();
    getSavedUserDataFromPref(cardToPlay);
    String gameId = 'computer';

    apiBloc.fetchCardsRes(
      xApiKey,
      gameCat1,
      gameCat2,
      gameCat3,
      gameCat4,
      cardToPlay,
      gameId,
      playerType,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: ChangeNotifierProvider(
            create: (context) => AutoPlayStatesModel(),
            child: StreamBuilder(
              stream: apiBloc.cardsRes,
              builder: (context, AsyncSnapshot<CardsResModel> snapshot) {
                if (snapshot.hasData && snapshot.data.status == 1 && snapshot.data.response.cards.length > 0) {
                  print('----uniqueId : ${snapshot.data.response.uniqueId}');
                  cards = snapshot.data.response.cards;
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        getRandomBgImgFromAsset(),
                      fit: BoxFit.cover,
                      ),

                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: BuildPlayer1Screen(cards.length, p1FullName),
                          ),

                          Expanded(
                            flex: 13,
                            child: Consumer<AutoPlayStatesModel>(
                              builder: (context, statesModel, child) => Column(
                                children: [
                                  gamePlayTimerUi(
                                    context,
                                    gameTime,
                                    onTimeEnd: (bool isTimeEnded) => {
                                      //print('Timer Ended');
                                      showTimesUpDialog(context, statesModel),
                                    },
                                  ),

                                  Container(
                                    height: getScreenHeight(context) / 1.5,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          ValueListenableBuilder(
                                            builder: (BuildContext context, bool value, Widget child) {
                                              // This builder will only get called when the _counter
                                              // is updated.
                                              //print('---- 215: ${SizeConfig.widthMultiplier * 54.8}');
                                              //print('---- 301: ${SizeConfig.heightMultiplier * 36.7}');
                                              return Container(
                                                width: SizeConfig.widthMultiplier * 54.8,
                                                height: SizeConfig.heightMultiplier * 36.7,
                                                child: BounceInLeft(
                                                  child: buildPlayerOneCard(
                                                    context,
                                                    cards,
                                                    indexOfCardDeck,
                                                    p1Card1ValueNotify.value,
                                                    whoIsPlaying,
                                                    indexOfCardDeckSelectForComputer,
                                                    onClickActionOnP1AutoPlayCard:
                                                        (int indexOfP1Card, String isWon, int winPoint, bool isFlipped) => {
                                                      print('----p1c clicked'),
                                                      if (isFlipped && whoIsPlaying == 'player')
                                                        {
                                                          isP1CardFlipped = isFlipped,
                                                          isP1SelectedStats = false,
                                                          computerCard2ValueNotify.value += 1,
                                                        }
                                                      else
                                                        {
                                                          isP1SelectedStats = true,
                                                          this.indexOfP1Card = indexOfP1Card,
                                                          if (whoIsPlaying == 'computer')
                                                            {
                                                              if (isWon == 'true')
                                                                {
                                                                  onTapAudio('match_win'),
                                                                  playerResultStatusList.add("won"), // "won" is lottie file name
                                                                  //showing lottie anim depending on win or loose
                                                                  showWinDialog(context, statesModel, 'true', 'win-result.json', 'You Won',
                                                                      p1Photo, 4000, winPoint),
                                                                }
                                                              else if(isWon == 'false') {
                                                                onTapAudio('match_lost'),
                                                                playerResultStatusList.add("sad"), // "sad" is lottie file name
                                                                //showing lottie anim depending on win or loose
                                                                showWinDialog(context, statesModel, 'false', 'sad-star.json',
                                                                    '\n\n\n\nYou Loose', '', 3500, winPoint),
                                                              } else if(isWon == 'draw'){

                                                                onTapAudio('match_draw'),
                                                                playerResultStatusList.add("sad"), // "sad" is lottie file name
                                                                //showing lottie anim depending on win or loose
                                                                showWinDialog(context, statesModel, 'draw', 'sad-star.json',
                                                                    '\n\n\n\nDraw Match', '', 3500, winPoint),
                                                              },
                                                            }
                                                          else
                                                            {
                                                              computerCard2ValueNotify.value += 1,
                                                            }
                                                        }
                                                    },
                                                  ),
                                                  preferences: AnimationPreferences(
                                                      duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                                                ),
                                              );
                                            },
                                            valueListenable: p1Card1ValueNotify,
                                          ),

                                          HeartBeat(
                                            child: AvatarGlow(
                                              endRadius: 25,
                                              glowColor: Colors.white,
                                              child: Container(
                                                width: 50,
                                                child: Center(
                                                  child: Image.asset(
                                                    'assets/icons/png/img_vs.png',
                                                    color: Colors.blueGrey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            preferences: AnimationPreferences(
                                                duration: const Duration(milliseconds: 2000), autoPlay: AnimationPlayStates.Loop),
                                          ),

                                          ValueListenableBuilder(
                                            builder: (BuildContext context, int value, Widget child) {
                                              // This builder will only get called when the _counter
                                              // is updated.
                                              return Container(
                                                width: SizeConfig.widthMultiplier * 54.8,
                                                height: SizeConfig.heightMultiplier * 36.8,
                                                child: BounceInRight(
                                                  child: buildPlayerTwoCard(
                                                    context,
                                                    indexOfP1Card,
                                                    indexOfCardDeck,
                                                    cards,
                                                    isP1SelectedStats,
                                                    whoIsPlaying,
                                                    indexOfCardDeckSelectForComputer,
                                                    isP1CardFlipped,
                                                    isP1SelectedStats,
                                                    onClickActionOnP2AutoPlayCard: (String isWon, int winPoint) => {
                                                      print('---- p2c data called ${statesModel.isCardOneTouched}, $isWon, $winPoint'),
                                                      if (whoIsPlaying == 'player')
                                                        {
                                                          if (isWon == 'true')
                                                            {
                                                              onTapAudio('match_win'),
                                                              playerResultStatusList.add("won"), // "won" is lottie file name
                                                              //showing lottie anim depending on win or loose
                                                              showWinDialog(context, statesModel, 'true', 'win-result.json', 'You Won',
                                                                  p1Photo, 4000, winPoint),
                                                            } else if(isWon == 'false')
                                                            {
                                                              onTapAudio('match_lost'),
                                                              playerResultStatusList.add("sad"), // "sad" is lottie file name
                                                              //showing lottie anim depending on win or loose
                                                              showWinDialog(context, statesModel, 'false', 'sad-star.json',
                                                                  '\n\n\n\nYou Loose', '', 3500, winPoint),
                                                            }else if(isWon == 'draw')
                                                              {
                                                                onTapAudio('match_draw'),
                                                                playerResultStatusList.add("sad"), // "sad" is lottie file name
                                                                //showing lottie anim depending on win or loose
                                                                showWinDialog(context, statesModel, 'isWon', 'sad-star.json',
                                                                    '\n\n\n\nDraw Match', '', 3500, winPoint),
                                                              },
                                                        }
                                                      else
                                                        {
                                                          p1Card1ValueNotify.value = true,
                                                        }
                                                    },
                                                  ),
                                                  preferences: AnimationPreferences(
                                                      duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                                                ),
                                              );
                                            },
                                            valueListenable: computerCard2ValueNotify,
                                            // The child parameter is most helpful if the child is
                                            // expensive to build and does not depend on the value from
                                            // the notifier.
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  RotateInUpLeft(
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                                      height: 55,
                                      child: ListView.builder(
                                        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: playerResultStatusList.length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                            elevation: 5,
                                            shadowColor: Colors.lightBlueAccent,
                                            color: Colors.blueGrey,
                                            child: Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: setResultStatus(index),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    preferences: AnimationPreferences(
                                        duration: const Duration(milliseconds: 400), autoPlay: AnimationPlayStates.Forward),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Expanded(
                            flex: 4,
                            child: Consumer<AutoPlayStatesModel>(
                              builder: (context, statesModel, child) => BuildPlayerTwoScreen(
                                  listLength: (cards.length / 2).round(),
                                  memberId: p1MemberId,
                                  onPressed: () async {
                                    showSurrenderDialog(context, onOkTap:(){
                                      gotoResultScreen(context, statesModel, true);
                                    });
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else if (!snapshot.hasData) {
                  return frostedGlassWithProgressBarWidget(context);
                } else return NoCardFound();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget setResultStatus(int index) {
    return playerResultStatusList[index] == 'won'
        ? SvgPicture.asset('assets/icons/svg/${playerResultStatusList[index]}.svg', height: 25, width: 25)
        : SvgPicture.asset('assets/icons/svg/${playerResultStatusList[index]}.svg', height: 25, width: 25);
  }

  void showWinDialog(BuildContext context, AutoPlayStatesModel statesModel, String isWon, String lottieFileName, String message,
      String photoUrl, int animHideTime, int winPoint) async {
    BuildContext dialogContext;
    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (BuildContext context) {
        dialogContext = context;
        return Dialog(
          backgroundColor: Colors.transparent,
          child: FadeInUp(
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  child: Center(
                    child: Lottie.asset('assets/animations/lottiefiles/$lottieFileName',
                        height: 290, width: 290, repeat: false, animate: true),
                  ),
                  onTap: () {},
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: FadeInImage.assetNetwork(
                          placeholder: isWon == 'true' ? 'assets/icons/png/circle-avator-default-img.png' : '',
                          image: photoUrl,
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

      Timer(Duration(milliseconds: animHideTime), () {
        Navigator.pop(dialogContext);

        showBothCardsDialog(context, cards, whoIsPlaying == 'player' ? indexOfP1Card : indexOfCardDeckSelectForComputer, indexOfCardDeck,
            statesModel.cardCountOnDeck == 1 ? true : false, isWon, onClickActionOnPlayAgain: (bool isMatchEnded) {
          //print('-----isMatchEnded: $isMatchEnded ');

          if (!isMatchEnded) {
            indexOfCardDeck = indexOfCardDeck + 1;

            /*
            print('-----isWon1: $isWon ');
            print('-----winPoint: $winPoint ');
            print('-----statesModel.playerOneTrump: ${statesModel.playerOneTrump} ');
            print('-----statesModel.player1TotalPoints: ${statesModel.player1TotalPoints} ');
            print('-----statesModel.playerTwoTrump: ${statesModel.playerTwoTrump} ');
            print('-----statesModel.player2TotalPoints: ${statesModel.player2TotalPoints} ');
            */

            if (isWon == 'true') {
              statesModel.playerOneTrump = statesModel.playerOneTrump + 1;
              statesModel.player1TotalPoints = statesModel.player1TotalPoints + winPoint;
            } else if(isWon == 'false'){
              statesModel.playerTwoTrump = statesModel.playerOneTrump + 1;
              statesModel.player2TotalPoints = statesModel.player2TotalPoints + winPoint;
            }

            context.read<AutoPlayStatesModel>().updatePlayerScoreboards(
                statesModel.playerOneTrump, statesModel.playerTwoTrump, statesModel.player1TotalPoints, statesModel.player2TotalPoints);

            context.read<AutoPlayStatesModel>().updateCardCountOnDeck(statesModel.cardCountOnDeck - 1);

            String message = '';
            whoIsPlaying == 'computer' ? message = "Computer Turn To Play" : message = 'Your Turn To Play';
            showToast(context, message);

            if (whoIsPlaying == 'computer') {
              //Choosing index of player stats list for next round for computer
              indexOfCardDeckSelectForComputer = Random().nextInt(6);
              //print('-----indexOfCardDeckSelectForComputer: $indexOfCardDeckSelectForComputer');
            } else {
              indexOfCardDeckSelectForComputer = 55;
            }
          } else {
            gotoResultScreen(context, statesModel, false);
          }
        });

        if (isWon == 'true' || isWon == 'draw') {
          whoIsPlaying = 'player';
          isP1CardFlipped = false;
          isP1SelectedStats = false;
          p1Card1ValueNotify.value = true;
          computerCard2ValueNotify.value += 1;
        } else {
          whoIsPlaying = 'computer';
          isP1CardFlipped = false;
          isP1SelectedStats = true;
          p1Card1ValueNotify.value = false;
          computerCard2ValueNotify.value += 1;
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void showTimesUpDialog(BuildContext context, AutoPlayStatesModel statesModel) {
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
              child: Lottie.asset('assets/animations/lottiefiles/times-up.json', height: 290, width: 290, repeat: false, animate: true),
            ),
            preferences: AnimationPreferences(duration: const Duration(milliseconds: 800), autoPlay: AnimationPlayStates.Forward),
          ),
        );
      },
    );

    Timer(Duration(milliseconds: 3000), () {
      Navigator.pop(dialogContext);
      gotoResultScreen(context, statesModel, false);
    });
  }

  void gotoResultScreen(BuildContext context, AutoPlayStatesModel statesModel, bool isSurrender) {
    bool areYouWon = true;
    if (statesModel.player1TotalPoints > statesModel.player2TotalPoints) {
      areYouWon = true;
    } else if (statesModel.player1TotalPoints < statesModel.player2TotalPoints) {
      areYouWon = false;
    }
    print('-----gotoResultScreen: $areYouWon');

    Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (context) => GameResult(
                xApiKey,
                p1FullName,
                p1MemberId,
                p1Photo,
                "Computer",
                'computer',
                Constants.imgUrlComputer,
                gameCat1,
                gameCat2,
                gameCat3,
                gameCat4,
                playerType,
                gameType,
                cardToPlay,
                isSurrender? '0' : statesModel.player1TotalPoints.toString(),
                statesModel.player2TotalPoints.toString(), //change here
                areYouWon,
              ),
      ),
    );
  }

  void getSavedUserDataFromPref(String cardToPlay) {
    switch(cardToPlay){
      case '14':
        gameTime = 5;
        break;

      case '22':
        gameTime = 10;
        break;

      case '30':
        gameTime = 15;
        break;

      default :
        gameTime = 5;
    }


    SharedPreferenceHelper().getUserSavedData().then((sharedPrefUserProfileModel) => {
          p1xApiKey = sharedPrefUserProfileModel.xApiKey ?? 'NA',
          p1MemberId = sharedPrefUserProfileModel.memberId ?? 'NA',
          p1FullName = sharedPrefUserProfileModel.fullName ?? 'NA',
          p1Photo = sharedPrefUserProfileModel.photo ?? Constants.imgUrlNotFoundYellowAvatar,
          p1Points = sharedPrefUserProfileModel.points ?? 'NA',
        });
  }
}
