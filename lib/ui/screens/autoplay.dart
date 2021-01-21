import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:trump_card_game/helper/constantvalues/constants.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:trump_card_game/helper/shared_preference_data.dart';
import 'package:trump_card_game/model/state_managements/autoplay_states_model.dart';
import 'package:trump_card_game/ui/widgets/custom/frosted_glass.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_auto_play_win_screen.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_autoplay.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_auto_play_cards.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:trump_card_game/model/responses/cards_res_model.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:trump_card_game/ui/widgets/libraries/avatar_glow.dart';
import 'package:trump_card_game/ui/widgets/libraries/flutter_toast.dart';

import 'game_result.dart';

class AutoPlay extends StatelessWidget {
  final String categoryName;
  final String subcategoryName;
  final String gameType;
  final String cardToPlay;
  AutoPlay ({ Key key, this.categoryName, this.subcategoryName, this.gameType, this.cardToPlay}): super(key: key);

  final List<String> playerResultStatusList = [];
  List<Cards> cards = [];

  int indexOfP1Card = 0;
  int indexOfCardDeck = 0;
  int indexOfCardDeckSelectForComputer = 55;
  String whoIsPlaying = 'player';

  String p1xApiKey = '';
  String p1FullName = '';
  String p1MemberId = '';
  String p1Points = '';
  String p1Photo = '';

  final ValueNotifier<bool> p1Card1ValueNotify = ValueNotifier<bool>(true);
  final ValueNotifier<int> computerCard2ValueNotify = ValueNotifier<int>(0);

  bool isP1CardFlipped = false;
  bool isP1SelectedStats = false;

  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    this._context = context;

    getSavedUserDataFromPref();
    //apiBloc.fetchCardsRes(xApiKey, subcategoryName, categoryName, '2', cardToPlay);
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
              cards = snapshot.data.response.cards;
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
                          child: BuildPlayer1Screen(cards.length),
                        ),
                        Expanded(
                          flex: 8,
                          child: Consumer<AutoPlayStatesModel>(
                            builder: (context, statesModel, child) => Container(
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
                                                //print('Timer Ended');
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
                                                        width: 55,
                                                        height: 45,
                                                        decoration: BoxDecoration(
                                                          color: Colors.black,
                                                          border: Border.all(
                                                            color: Colors.black,
                                                            width: 5,
                                                          ),
                                                          borderRadius: BorderRadius.all(Radius.circular(3)),
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
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 30,
                                                              shadows: [
                                                                Shadow(color: Colors.white),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    Container(
                                                      width: 20,
                                                      height: 45,
                                                      decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius: BorderRadius.all(Radius.circular(3)),
                                                        boxShadow: <BoxShadow>[
                                                          BoxShadow(
                                                            color: Colors.grey[500],
                                                            blurRadius: 8.0,
                                                            offset: Offset(0.0, 8.0),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Center(
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(bottom: 5),
                                                          child: Text(
                                                            ':',
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 36,
                                                              shadows: [
                                                                Shadow(color: Colors.white),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    Padding(
                                                      padding: const EdgeInsets.all(5),
                                                      child: Container(
                                                        width: 55,
                                                        height: 45,
                                                        decoration: BoxDecoration(
                                                          color: Colors.black,
                                                          border: Border.all(
                                                            color: Colors.black,
                                                            width: 5,
                                                          ),
                                                          borderRadius: BorderRadius.all(Radius.circular(3)),
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
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 30,
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
                                    height: getScreenHeight(context)/1.5,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          ValueListenableBuilder(
                                            builder: (BuildContext context, bool value, Widget child) {
                                              // This builder will only get called when the _counter
                                              // is updated.
                                              return Container(
                                                width: 215,
                                                height: 300,
                                                child: BounceInLeft(
                                                  child: buildPlayerOneCard(
                                                    context,
                                                    cards,
                                                    indexOfCardDeck,
                                                    p1Card1ValueNotify.value,
                                                    whoIsPlaying,
                                                    indexOfCardDeckSelectForComputer,
                                                    onClickActionOnP1AutoPlayCard: (int indexOfP1Card, bool isWon, int winPoint, bool isFlipped) =>
                                                    {
                                                      print('----p1c clicked'),
                                                      if (isFlipped && whoIsPlaying == 'player') {
                                                        isP1CardFlipped = isFlipped,
                                                        isP1SelectedStats = false,
                                                        computerCard2ValueNotify.value +=1,
                                                      } else{
                                                        isP1SelectedStats = true,
                                                        this.indexOfP1Card = indexOfP1Card,
                                                        if (whoIsPlaying == 'computer') {
                                                          if (isWon) {
                                                            playerResultStatusList.add("won"), // "won" is lottie file name
                                                            //showing lottie anim depending on win or loose
                                                            showWinDialog(context, statesModel, isWon, 'win-result.json', 'You Won', p1Photo,
                                                                4000, winPoint),
                                                          } else {
                                                            playerResultStatusList.add("sad"), // "sad" is lottie file name
                                                            //showing lottie anim depending on win or loose
                                                            showWinDialog(context, statesModel, isWon, 'sad-star.json', '\n\n\n\nYou Loose',
                                                                '', 3500, winPoint),
                                                          },
                                                        } else {
                                                          computerCard2ValueNotify.value +=1,
                                                        }
                                                      }
                                                    },
                                                  ),
                                                  preferences: AnimationPreferences(
                                                      duration: const Duration(milliseconds: 1500),
                                                      autoPlay: AnimationPlayStates.Forward),
                                                ),
                                              );
                                            },
                                            valueListenable: p1Card1ValueNotify,
                                            // The child parameter is most helpful if the child is
                                            // expensive to build and does not depend on the value from
                                            // the notifier.
                                          ),

                                          HeartBeat(
                                            child: AvatarGlow(
                                              endRadius: 27,
                                              glowColor: Colors.white,
                                              child: Container(
                                                width: 55,
                                                child: Center(
                                                  child: Image.asset('assets/icons/png/img_vs.png',color: Colors.black87,),
                                                ),
                                              ),
                                            ),
                                            preferences: AnimationPreferences(
                                                duration: const Duration(milliseconds: 2000),
                                                autoPlay: AnimationPlayStates.Loop),
                                          ),

                                          ValueListenableBuilder(
                                            builder: (BuildContext context, int value, Widget child) {
                                              // This builder will only get called when the _counter
                                              // is updated.
                                              return Container(
                                                width: 215,
                                                height: 301,
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
                                                    onClickActionOnP2AutoPlayCard: (bool isWon, int winPoint) =>
                                                    {
                                                      print('---- p2c data called ${statesModel.isCardOneTouched}, $isWon, $winPoint'),

                                                      if (whoIsPlaying == 'player') {
                                                        if (isWon) {
                                                          playerResultStatusList.add("won"), // "won" is lottie file name
                                                          //showing lottie anim depending on win or loose
                                                          showWinDialog(context, statesModel, isWon, 'win-result.json', 'You Won', p1Photo,
                                                              4000, winPoint),
                                                        } else {
                                                          playerResultStatusList.add("sad"), // "sad" is lottie file name
                                                          //showing lottie anim depending on win or loose
                                                          showWinDialog(context, statesModel, isWon, 'sad-star.json', '\n\n\n\nYou Loose',
                                                              '', 3500, winPoint),
                                                        },
                                                      } else{
                                                        p1Card1ValueNotify.value = true,
                                                      }
                                                    },
                                                  ),
                                                  preferences: AnimationPreferences(
                                                      duration: const Duration(milliseconds: 1500),
                                                      autoPlay: AnimationPlayStates.Forward),
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
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: BuildPlayerTwoScreen(cards.length),
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

  void showWinDialog(BuildContext context, AutoPlayStatesModel statesModel, bool isWon, String lottieFileName, String message,
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
                  onTap: () {

                  },
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: FadeInImage.assetNetwork(
                          placeholder: isWon?'assets/icons/png/circle-avator-default-img.png': '',
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

      if (isWon) {
        statesModel.playerOneTrump = statesModel.playerOneTrump + 1;
        statesModel.player1TotalPoints = statesModel.player1TotalPoints + winPoint;

      } else {
        statesModel.playerTwoTrump = statesModel.playerOneTrump + 1;
        statesModel.player2TotalPoints = statesModel.player2TotalPoints + winPoint;
      }

      if (isWon) {
        whoIsPlaying = 'player';
        isP1CardFlipped = false;
        isP1SelectedStats = false;
        p1Card1ValueNotify.value = true;
        computerCard2ValueNotify.value +=1;
      } else {
        isP1CardFlipped = false;
        isP1SelectedStats = true;
        p1Card1ValueNotify.value = false;
        computerCard2ValueNotify.value +=1;
        whoIsPlaying = 'computer';

      }

      Timer(Duration(milliseconds: animHideTime), () {
        Navigator.pop(dialogContext);
        showBothCardsDialog(context, cards,
            whoIsPlaying == 'player'? indexOfP1Card: indexOfCardDeckSelectForComputer,
            indexOfCardDeck,
            statesModel.cardCountOnDeck == 0 ? true : false,
            onClickActionOnPlayAgain :( bool isMatchEnded){

            print('-----isMatchEnded: $isMatchEnded ');

          if (!isMatchEnded) {
            indexOfCardDeck = indexOfCardDeck + 1;

            context.read<AutoPlayStatesModel>().updatePlayerScoreboards(
              statesModel.playerOneTrump,
              statesModel.playerTwoTrump,
              statesModel.player1TotalPoints,
              statesModel.player2TotalPoints,);

            context.read<AutoPlayStatesModel>().updateCardCountOnDeck(statesModel.cardCountOnDeck - 1);

            String message = '';
            whoIsPlaying == 'computer' ? message = "Computer Turn To Play" : message = 'Your Turn To Play';
            Toast.show(message, context, duration: Toast.lengthLong, gravity:  Toast.bottom,
                backgroundColor: Colors.black87.withOpacity(0.5),
                textStyle:  TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'montserrat',
                  shadows: [
                    Shadow(color: Colors.white),
                  ],
                ));

            if (whoIsPlaying == 'computer') {
              //Choosing index of player stats list for next round for computer
              indexOfCardDeckSelectForComputer = Random().nextInt(6);
              print('-----indexOfCardDeckSelectForComputer: $indexOfCardDeckSelectForComputer');
            }
          } else{
            gotoResultScreen(_context, isWon, statesModel);
          }

        });
      });
    } catch (e) {
      print(e);
    }
  }

  void showTimesUpDialog(BuildContext context, bool isP1Won, AutoPlayStatesModel statesModel) {
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

    Timer(Duration(milliseconds: 3000), () {
      Navigator.pop(dialogContext);
      gotoResultScreen(_context, isP1Won, statesModel);
    });
  }

  void gotoResultScreen(BuildContext context, bool isP1Won, AutoPlayStatesModel statesModel) {
    isP1Won ? Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) =>
            GameResult(
              winnerName: 'Ram Rakshman',
              winnerId: 'MEM000004',
              winnerImage: p1Photo,
              winnerCoins: "0",
              winnerPoints: statesModel.player1TotalPoints.toString(),
              cardType: 'Cricket',
              clashType: '1 vs 1',
              playedCards: '14',
              isP1Won: true,
              gamePlayType: 'vsComputer',
            ),
      ),
    ):
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) =>
            GameResult(
              winnerName: 'Computer',
              winnerId: 'MEM000004',
              winnerImage: Constants.imgUrlTest, //static
              winnerCoins: "0",
              winnerPoints: statesModel.player2TotalPoints.toString(),
              cardType: subcategoryName,
              clashType: '1 vs 1',
              playedCards: cardToPlay,
              isP1Won: false,
              gamePlayType: 'vsComputer',

            ),
      ),
    );
  }

  void getSavedUserDataFromPref() {
    SharedPreferenceHelper().getUserSavedData().then((sharedPrefUserProfileModel) => {
      p1xApiKey = sharedPrefUserProfileModel.xApiKey ?? 'NA',
      p1MemberId = sharedPrefUserProfileModel.memberId ?? 'NA',
      p1FullName = sharedPrefUserProfileModel.fullName ?? 'NA',
      p1Photo = sharedPrefUserProfileModel.photo ?? Constants.imgUrlNotFoundYellowAvatar,
      p1Points = sharedPrefUserProfileModel.points ?? 'NA',
    });
  }
}

