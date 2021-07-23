import 'dart:async';
import 'dart:ui';

import 'package:clash_of_cardz_flutter/main.dart';
import 'package:clash_of_cardz_flutter/ui/styles/size_config.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/no_cards_found.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:clash_of_cardz_flutter/bloc/api_bloc.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/base_application_fun.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/common_fun.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/include_screens/include_game_play_dialogs.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/include_screens/include_game_play_win_screen.dart';
import 'package:clash_of_cardz_flutter/model/state_managements/gameplay_states_model.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/loading_sports_frosted_glass.dart';
import 'package:clash_of_cardz_flutter/model/responses/cards_res_model.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/include_screens/include_game_play_cards.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/include_screens/include_gameplay.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/avatar_glow.dart';
import 'game_result.dart';

class Gameplay extends StatefulWidget {
  final String xApiKey;
  bool isPlayAsP1;
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
  final String gameRoomName;

  Gameplay ({
    Key key,
    this.xApiKey,
    this.isPlayAsP1,
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
    this.gameRoomName,
  }): super(key: key);

  @override
  _GameplayState createState() => _GameplayState();
}

class _GameplayState extends State<Gameplay> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GamePlayStatesModel statesModelGlobal = GamePlayStatesModel();

  final List<String> playerResultStatusList = [];

  List<Cards> cards = [];

  int indexOfP1Card = 0;

  int indexSelectedByP2 = 55;

  int indexOfCardDeck = 0;

  int gameTime = 5;

  String p1Points = '';

  String winBasis = '';

  String winPoints = '';

  String p1TurnStatus = 'no',
      p2TurnStatus = 'no',
      p1SelectedAttr = '',
      p1SelectedAttrValue = '0',
      p2SelectedAttr = '',
      p2SelectedAttrValue = '0',
      winner = 'p1';

  bool isYourNextTurn = false;

  bool isP1CardFlipped = false;

  bool isP1SelectedStats = false;

  //this flag use to open dialog only open one time even app is minimized
  bool isWinLossDialogOpened = false;

  String isP1Surrender = 'false';

  String haveISurrendered = 'false';

  String whoIsPlaying = 'p1';
  DatabaseReference _gamePlayRef;

  StreamSubscription<Event> gamePlaySubscription;

  final ValueNotifier<int> card1ValueNotify = ValueNotifier<int>(77);

  final ValueNotifier<int> card2ValueNotify = ValueNotifier<int>(77);

  @override
  void initState() {
    super.initState();

    apiBloc.fetchCardsRes(widget.xApiKey, widget.gameCat1, widget.gameCat2, widget.gameCat3, widget.gameCat4, widget.cardsToPlay, widget.gameRoomName, widget.playerType,);

    setScreenOrientationToLandscape();

    initFirebaseAndManageP1AndP2Data(widget.cardsToPlay);
  }


  @override
  Widget build(BuildContext context) {
    //print('----game cats: $gameCat1 , $gameCat2 , $gameCat3, $gameCat4, $gameType, $cardsToPlay, $playerType');

    return ChangeNotifierProvider(
        create: (context) => statesModelGlobal,
        child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomInset: false,
            body: StreamBuilder(
              stream: apiBloc.cardsRes,
              builder: (context, AsyncSnapshot<CardsResModel> snapshot) {
                if (snapshot.hasData && snapshot.data.status == 1 && snapshot.data.response.cards.length > 0) {
                  print('----uniqueId : ${snapshot.data.response.uniqueId}');
                  updateGamePlayStatusToFirebase();
                  listeningToFirebaseDataUpdate(widget.gameRoomName);
                  cards = snapshot.data.response.cards;
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(getRandomBgImgFromAsset(), fit: BoxFit.cover,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: BuildPlayer1Screen(cards.length, widget.p1FullName, widget.p2Name),
                          ),
                          Expanded(
                            flex: 8,
                            child: Consumer<GamePlayStatesModel>(
                              builder: (context, statesModel, child) => Container(
                                //width: getScreenWidth(context) - 400,
                                child: Column(
                                  children: [
                                    gamePlayTimerUi(context, gameTime, onTimeEnd: (bool isTimeEnded) => {
                                      showTimesUpDialog(context, statesModel)
                                    },),

                                    Container(
                                      height: getScreenHeight(context) / 1.5,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          ValueListenableBuilder(
                                            builder: (BuildContext context, int value, Widget child) {
                                              // This builder will only get called when the _counter
                                              //is updated.
                                              //print('---- 220: ${SizeConfig.widthMultiplier * 53}');
                                              //print('---- 300: ${SizeConfig.heightMultiplier * 36.5}');
                                              return Container(
                                                width: SizeConfig.widthMultiplier * 53,
                                                height: SizeConfig.heightMultiplier * 37,
                                                child: BounceInLeft(
                                                  child: buildCardAsP1(
                                                    context,
                                                    widget.isPlayAsP1,
                                                    cards,
                                                    indexOfCardDeck,
                                                    isYourNextTurn,
                                                    indexSelectedByP2,
                                                    whoIsPlaying,
                                                    onClickActionOnP1GameplayCard: (int indexOfP1Card, String attributeTitle,
                                                        String attributeValue, String winBasis, String winPoints, bool isFlipped) =>
                                                    {
                                                      //print('----p1c clicked'),
                                                      if (isFlipped && whoIsPlaying == 'p1')
                                                        {
                                                          isP1CardFlipped = isFlipped,
                                                          isP1SelectedStats = false,
                                                          //rebuild 2Card on flip
                                                          card2ValueNotify.value += 1,
                                                          //updateGamePlayStatus( statesModel, attributeTitle, attributeValue, winBasis, winPoints),
                                                        }
                                                      else
                                                        {
                                                          isP1SelectedStats = true,
                                                          this.indexOfP1Card = indexOfP1Card,
                                                          statesModelGlobal = statesModel,
                                                          if (whoIsPlaying == 'p2'){
                                                            updateGamePlayStatus( attributeTitle, attributeValue, winBasis, winPoints),
                                                          } else {
                                                            //card2ValueNotify.value += 1,
                                                            //update p2 thinking
                                                            updateGamePlayStatus(attributeTitle, attributeValue, winBasis, winPoints),
                                                          }
                                                        }
                                                    },
                                                  ),
                                                  preferences: AnimationPreferences(
                                                      duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                                                ),
                                              );
                                            },
                                            valueListenable: card1ValueNotify,
                                            // The child parameter is most helpful if the child is
                                            // expensive to build and does not depend on the value from
                                            // the notifier.
                                          ),

                                          RubberBand(
                                            child: AvatarGlow(
                                              endRadius: 30,
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
                                                duration: const Duration(milliseconds: 4000),
                                                autoPlay: AnimationPlayStates.Loop),
                                          ),

                                          ValueListenableBuilder(
                                            builder: (BuildContext context, int value, Widget child) {
                                              // This builder will only get called when the _counter
                                              // is updated.
                                              // print('---- 150: ${SizeConfig.widthMultiplier * 38.5}');
                                              // print('---- 210: ${SizeConfig.heightMultiplier * 25.5}');
                                              return Container(
                                                width: SizeConfig.widthMultiplier * 36.5,
                                                height: SizeConfig.heightMultiplier * 26.5,
                                                alignment: AlignmentDirectional.bottomCenter,
                                                child: BounceInRight(
                                                  child: buildSecondCard(
                                                    context,
                                                    indexOfP1Card,
                                                    indexOfCardDeck,
                                                    cards,
                                                    isP1CardFlipped,
                                                    p1TurnStatus,
                                                    p2TurnStatus,
                                                    widget.isPlayAsP1,
                                                  ),
                                                  preferences: AnimationPreferences(
                                                      duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                                                ),
                                              );
                                            },
                                            valueListenable: card2ValueNotify,
                                            // The child parameter is most helpful if the child is
                                            // expensive to build and does not depend on the value from
                                            // the notifier.
                                          ),
                                        ],
                                      ),
                                    ),

                                    RotateInUpLeft(
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(5, 8, 5, 0),
                                        height: 55,
                                        child: ListView.builder(
                                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: playerResultStatusList.length,
                                          itemBuilder: (context, index) {
                                            return Card(
                                              elevation: 2,
                                              shadowColor: Colors.grey,
                                              color: Colors.white.withOpacity(0.5),
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
                          ),

                          Expanded(
                            flex: 3,
                            child: BuildPlayerTwoScreen(listLength: (cards.length/2).round(),
                              p2Name: widget.p2Name, memberId: widget.p1MemberId, onPressed: (){
                                showSurrenderDialog(context, onOkTap:(){
                                  isP1Surrender = 'true';
                                  haveISurrendered = 'true';
                                  updateGamePlayStatusToFirebase();
                                });
                              },),
                          ),
                        ],
                      ),
                    ],
                  );
                } else if (!snapshot.hasData ) {
                  return frostedGlassWithProgressBarWidget(context);
                } else return NoCardFound();
              },
            ),
          ),
        ),
    );
  }

  void initFirebaseAndManageP1AndP2Data(String cardsToPlay){
    _gamePlayRef = FirebaseDatabase.instance.reference().child('gamePlay');
    //Removing gameRoom bcoz its not needed after this point
    FirebaseDatabase.instance.reference().child('gameRoom').child(widget.gameRoomName.replaceAll('gamePlay', 'gr')).remove();

    //if p1 in game room is you then adding game room p1 in your data else
    // if game room p2 is you then adding game room p2 data in your data.
    //print('-----Game play Name: $gameRoomName');
    //print('-----Game room Name: ${gameRoomName.replaceAll('gamePlay', 'gr')}');
    //print('-----pref member id: $isPlayAsP1, $p1MemberId, $p2MemberId, $p1FullName');

    if (widget.isPlayAsP1) {
      isYourNextTurn = true;
      whoIsPlaying = 'p1';
    } else if (widget.isPlayAsP1) {
      isYourNextTurn = false;
      whoIsPlaying = 'p2';
    }

    switch(cardsToPlay){
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
  }

  updateGamePlayStatus(String attrTitle, String attrValue, String winBasis, String winPoints) async{
    if (widget.isPlayAsP1) {
      p1TurnStatus = 'yes';
      p1SelectedAttr = attrTitle;
      p1SelectedAttrValue = attrValue;
    } else {
      p2TurnStatus = 'yes';
      p2SelectedAttr = attrTitle;
      p2SelectedAttrValue = attrValue;
    }

    this.winBasis = winBasis;
    this.winPoints = winPoints;

    //print('-------p1TurnStatus: $p1TurnStatus');
    //print('----p2TurnStatus: $p2TurnStatus');

    updateGamePlayStatusToFirebase();
  }

  void updateGamePlayStatusToFirebase() async{
    _gamePlayRef.child(widget.gameRoomName).set({
      'isP1TurnComplete': p1TurnStatus,
      'isP2TurnComplete': p2TurnStatus,
      'selectedArrayPos': indexOfP1Card,
      'p1SelectedAttr': p1SelectedAttr,
      'p1SelectedAttrValue': p1SelectedAttrValue,
      'p2SelectedAttr': p2SelectedAttr,
      'p2SelectedAttrValue': p2SelectedAttrValue,
      'isP1Surrender': isP1Surrender,
      'winner': winner,
    });
  }

  void listeningToFirebaseDataUpdate(String gameRoomName) async {
    gamePlaySubscription = _gamePlayRef.onChildChanged.listen((Event event){
      //print('----- ${event.snapshot.key}');
      if (event.snapshot.key == gameRoomName) {
        var changeMapData = event.snapshot.value;
        // event.snapshot.value is return map. Below line getting values from map using keys
        p1TurnStatus = changeMapData['isP1TurnComplete'];
        p2TurnStatus = changeMapData['isP2TurnComplete'];
        p1SelectedAttr = changeMapData['p1SelectedAttr'];
        p1SelectedAttrValue = changeMapData['p1SelectedAttrValue'];
        p2SelectedAttr = changeMapData['p2SelectedAttr'];
        p2SelectedAttrValue = changeMapData['p2SelectedAttrValue'];
        isP1Surrender = changeMapData['isP1Surrender'];
        winner = changeMapData['winner'];

        try {
          if (isP1Surrender  == 'false' && haveISurrendered  == 'false') {
            if (p1TurnStatus == 'yes' && p2TurnStatus == 'no') {
              if (!widget.isPlayAsP1) {
                indexSelectedByP2 = changeMapData['selectedArrayPos'];

                //print('----11 whoIsPlaying: $whoIsPlaying, isYourNextTurn: $isYourNextTurn');
                whoIsPlaying = 'p2';
                isYourNextTurn = true;
                card1ValueNotify.value +=1;
              }
              //card2ValueNotify.value +=1;

            } else if (p1TurnStatus == 'no' && p2TurnStatus == 'yes') {
              indexSelectedByP2 = changeMapData['selectedArrayPos'];

              //card2ValueNotify.value +=1;
              //print('----22 whoIsPlaying: $whoIsPlaying, isYourNextTurn: $isYourNextTurn');
              if (whoIsPlaying == 'p2' && !isYourNextTurn) {
                card1ValueNotify.value +=1;
              }

              isYourNextTurn = true;
              whoIsPlaying = 'p2';

            } else if (p1TurnStatus == 'yes' && p2TurnStatus == 'yes') {
              print('---- showWinOrLossDialog called 0');

              // winBasis and winPints will be same for both player. So I am getting those value when p1 selected first value

              double p1CardValue = double.parse(p1SelectedAttrValue);
              double p2CardValue = double.parse(p2SelectedAttrValue);

              String areYouWon = 'false';
              if (winBasis == 'Highest Value') {
                if(widget.isPlayAsP1){
                  if (p1CardValue > p2CardValue) {
                    areYouWon = 'true';
                  } else if (p1CardValue < p2CardValue) {
                    areYouWon = 'false';
                  } else if (p1CardValue == p2CardValue) {
                    areYouWon = 'draw';
                  }

                  showWinOrLossDialog(areYouWon);
                } else {
                  if (p1CardValue > p2CardValue) {
                    areYouWon = 'false';
                  } else if (p1CardValue < p2CardValue) {
                    areYouWon = 'true';
                  } else if (p1CardValue == p2CardValue) {
                    areYouWon = 'draw';
                  }

                  showWinOrLossDialog(areYouWon);
                }
              } else if (winBasis == 'Lowest Value') {
                if(widget.isPlayAsP1){
                  if (p1CardValue > p2CardValue) {
                    areYouWon = 'true';
                  } else if (p1CardValue < p2CardValue) {
                    areYouWon = 'false';
                  } else if (p1CardValue == p2CardValue) {
                    areYouWon = 'draw';
                  }
                  showWinOrLossDialog(areYouWon);
                }else {
                  if (p1CardValue > p2CardValue) {
                    areYouWon = 'false';
                  } else if (p1CardValue < p2CardValue) {
                    areYouWon = 'true';
                  } else if (p1CardValue == p2CardValue) {
                    areYouWon = 'draw';
                  }

                  showWinOrLossDialog(areYouWon);
                }
              }
            }
          }
          else if (isP1Surrender == 'true' || haveISurrendered  == 'true') {
            //print('----isP1Surrender: $isP1Surrender, haveISurrendered: $haveISurrendered');
            showToast(_scaffoldKey.currentContext, 'Surrender The Match');
            gotoResultScreen(_scaffoldKey.currentContext, statesModelGlobal);
          }
        } catch (e) {
          print(e);
        }
      }
    });
  }

  void showWinOrLossDialog(String areYouWon) async {
    isWinLossDialogOpened = false;
    print('---- showWinOrLossDialog called 1');

    if (!isWinLossDialogOpened) {
      if (areYouWon == 'true') {
        playerResultStatusList.add("won");
        showWinDialog(_scaffoldKey.currentContext, areYouWon, 'win-result.json', 'You Won', widget.p1Photo, 4000);
      } else if(areYouWon == 'false'){
        playerResultStatusList.add("sad");
        showWinDialog(_scaffoldKey.currentContext, areYouWon, 'sad-star.json', '\n\n\n\nYou Loose', '', 3500);
      }  else if(areYouWon == 'draw'){
        playerResultStatusList.add("sad");
        showWinDialog(_scaffoldKey.currentContext, areYouWon, 'sad-star.json', '\n\n\n\nDraw Match', '', 3500);
      }
    }
  }

  Widget setResultStatus(int index) {
    return playerResultStatusList[index] == 'won'
        ? SvgPicture.asset('assets/icons/svg/${playerResultStatusList[index]}.svg', height: 25, width: 25)
        : SvgPicture.asset('assets/icons/svg/${playerResultStatusList[index]}.svg', height: 25, width: 23);
  }

  void showWinDialog(BuildContext context, String isWon, String lottieFileName, String message,
      String photoUrl, int animHideTime) async {
    isWinLossDialogOpened = true;

    print('---- showWinOrLossDialog called 2');
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
                Center(
                  child:
                  Lottie.asset('assets/animations/lottiefiles/$lottieFileName', height: 290, width: 290, repeat: false, animate: true),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: FadeInImage.assetNetwork(
                          placeholder: isWon == 'true' ? 'assets/icons/png/circle-avator-default-img.png' : '',
                          image: photoUrl ?? '',
                          fit: BoxFit.fill,
                          width: 65,
                          height: 65,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          message,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                          ),
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
        bool isMatchEndedStatus = statesModelGlobal.cardCountOnDeck == 1 ? true : false;

        showBothCardsDialog(context, cards, indexOfP1Card, indexOfCardDeck, isMatchEndedStatus, widget.isPlayAsP1,
            isWon, onClickActionOnPlayAgain: (bool isMatchEnded) {
          try{
              indexOfCardDeck = indexOfCardDeck + 1;

              /*
              print('-----isWon1: $isWon ');
              print('-----winPoint: $winPoints ');
              print('-----statesModel.playerOneTrump: ${statesModelGlobal.playerOneTrump} ');
              print('-----statesModel.player1TotalPoints: ${statesModelGlobal.player1TotalPoints} ');
              print('-----statesModel.playerTwoTrump: ${statesModelGlobal.playerTwoTrump} ');
              print('-----statesModel.player2TotalPoints: ${statesModelGlobal.player2TotalPoints} ');
              */

              print('-----statesModel.cardCountOnDeck: ${statesModelGlobal.cardCountOnDeck}');

              if (isWon == 'true') {
                statesModelGlobal.playerOneTrump = statesModelGlobal.playerOneTrump + 1;
                statesModelGlobal.player1TotalPoints = statesModelGlobal.player1TotalPoints + int.parse(winPoints);
              } else if (isWon == 'false'){
                statesModelGlobal.playerTwoTrump = statesModelGlobal.playerOneTrump + 1;
                statesModelGlobal.player2TotalPoints = statesModelGlobal.player2TotalPoints + int.parse(winPoints);
              }

              if (!isMatchEnded) {
                if (isWon =='true') {
                  isYourNextTurn = true;
                  whoIsPlaying = 'p1';
                  showToast(context, "Your Turn To Play");
                } else if(isWon =='false'){
                  isYourNextTurn = false;
                  whoIsPlaying = 'p2';
                  showToast(context, '${widget.p2Name} Turn To Play');
                } else if(isWon =='draw'){
                  if (whoIsPlaying == 'p1') {
                    isYourNextTurn = true;
                    whoIsPlaying = 'p1';
                    showToast(context, "Your Turn To Play");
                  } else if (whoIsPlaying == 'p2'){
                    isYourNextTurn = true;
                    whoIsPlaying = 'p2';
                    showToast(context, '${widget.p2Name} Turn To Play');
                  }
                }

                isP1CardFlipped = false;
                indexSelectedByP2 = 55;

                p1TurnStatus = 'no';
                p2TurnStatus = 'no';
                updateGamePlayStatusToFirebase();


                _scaffoldKey.currentContext.read<GamePlayStatesModel>().updatePlayerScoreboards(
                  statesModelGlobal.playerOneTrump,
                  statesModelGlobal.playerTwoTrump,
                  statesModelGlobal.player1TotalPoints,
                  statesModelGlobal.player2TotalPoints);

              _scaffoldKey.currentContext.read<GamePlayStatesModel>().updateCardCountOnDeck(statesModelGlobal.cardCountOnDeck - 1);
              } else {
                gotoResultScreen(_scaffoldKey.currentContext, statesModelGlobal);
              }
          } catch(e){
            print(e);
          }
        });

      });
    } catch (e) {
      print(e);
    }
  }

  void showTimesUpDialog(BuildContext context, GamePlayStatesModel statesModel) {
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
      gotoResultScreen(context, statesModel);
    });
  }

  void gotoResultScreen(BuildContext context, GamePlayStatesModel statesModel) {
    bool areYouWon = true;
    String p1Points = '0';
    String p2Points = '0';
    if (isP1Surrender == 'false' && haveISurrendered == 'false') {
      //print('---- : ${1}');
      if (statesModel.player1TotalPoints > statesModel.player2TotalPoints) {
        areYouWon = true;
        p1Points = statesModel.player1TotalPoints.toString();
        p2Points = statesModel.player2TotalPoints.toString();
      } else if(statesModel.player1TotalPoints < statesModel.player2TotalPoints){
        areYouWon = false;
        p1Points = statesModel.player1TotalPoints.toString();
        p2Points = statesModel.player2TotalPoints.toString();
      } else if(statesModel.player1TotalPoints == statesModel.player2TotalPoints){
        //if both player points are same then wining both player
        areYouWon = true;
        p1Points = statesModel.player1TotalPoints.toString();
        p2Points = statesModel.player2TotalPoints.toString();
      }
    } else if (isP1Surrender == 'true' && haveISurrendered == 'true') {
      //print('---- : ${2}');
      areYouWon = false;
      p1Points = '0';
      p2Points = statesModel.player2TotalPoints.toString();

    } else if (isP1Surrender == 'true' && haveISurrendered == 'false') {
      areYouWon = true;
      p1Points = statesModel.player1TotalPoints.toString();
      p2Points = '0';
      //print('---- : ${3}');
    }

    //print('---- areYouWon: $areYouWon , isP1Surrender: $isP1Surrender, haveISurrendered: $haveISurrendered, '
    //'player1TotalPoints: ${statesModel.player1TotalPoints.toString()}, player2TotalPoints: ${statesModel.player2TotalPoints.toString()}');


    Navigator.push(
      _scaffoldKey.currentContext,
            CupertinoPageRoute(
              builder: (context) =>
                  GameResult(
                    widget.xApiKey, widget.p1FullName, widget.p1MemberId, widget.p1Photo, widget.p2Name,
                    widget.p2MemberId, widget.p2Image, widget.gameCat1, widget.gameCat2,
                    widget.gameCat3, widget.gameCat4, widget.playerType, widget.gameType,
                    widget.cardsToPlay, p1Points, p2Points, areYouWon,
                  ),
            ),
          );
  }
}
