import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:trump_card_game/helper/exten_fun/common_fun.dart';
import 'package:trump_card_game/helper/shared_preference_data.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_game_play_dialogs.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_game_play_win_screen.dart';
import 'package:trump_card_game/ui/widgets/libraries/animated_text_kit/wavy.dart';
import 'package:trump_card_game/model/state_managements/gameplay_states_model.dart';
import 'package:trump_card_game/ui/widgets/custom/frosted_glass.dart';
import 'package:provider/provider.dart';
import 'package:trump_card_game/model/responses/cards_res_model.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_game_play_cards.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_gameplay.dart';
import 'package:trump_card_game/ui/widgets/libraries/avatar_glow.dart';
import 'package:trump_card_game/ui/widgets/libraries/flutter_toast.dart';

import 'game_result.dart';

class Gameplay extends StatelessWidget {
  String p1FullName = '';
  String p1MemberId = '';
  String p1Photo = '';
  String p2Name = '';
  String p2MemberId = '';
  String p2Image = '';
  String categoryName = '';
  String subcategoryName = '';
  String gameType = '';
  String cardsToPlay = '';

  Gameplay({
    this.p1FullName,
    this.p1MemberId,
    this.p1Photo,
    this.p2Name,
    this.p2MemberId,
    this.p2Image,
    this.categoryName,
    this.subcategoryName,
    this.gameType,
    this.cardsToPlay,
  });

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GamePlayStatesModel statesModelGlobal = GamePlayStatesModel();
  final List<String> playerResultStatusList = [];
  List<Cards> cards = [];
  int indexOfP1Card = 0;
  int indexSelectedByP2 = 55;
  int indexOfCardDeck = 0;
  String p1MemberIdPref = '';

  String p1xApiKey = '';
  String p1Points = '';
  String winBasis = '';
  String winPoints = '';

  // game play stats attr
  String p1TurnStatus = 'no',
      p2TurnStatus = 'no',
      p1SelectedAttr = '',
      p1SelectedAttrValue = '0',
      p2SelectedAttr = '',
      p2SelectedAttrValue = '1',
      winner = 'p1';

  bool _isPlayAsP1 = false;
  bool isYourNextTurn = false;
  bool isP1CardFlipped = false;
  bool isP1SelectedStats = false;
  String whoIsPlaying = 'p1'; //Always p1 plays the first turn

  //firebase data init
  DatabaseReference _gamePlayRef;
  DatabaseReference _gameRoomRef;
  StreamSubscription<Event> gamePlaySubscription;
  DatabaseError _error;
  FirebaseApp firebaseApp;

  String _gameRoomName = 'gamePlay';

  final ValueNotifier<int> card1ValueNotify = ValueNotifier<int>(77);
  final ValueNotifier<int> card2ValueNotify = ValueNotifier<int>(77);
  final ValueNotifier<bool> gameScoreStatusValueNotify = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    setScreenOrientationToLandscape();
    getSavedUserDataFromPref();
    initFirebaseCredentials();
    manageP1AndP2Data();

    //fetchApiData();
    apiBloc.fetchCardsRes("ZGHrDz4prqsu4BcApPaQYaGgq", 'cricket', 'sports', '2', '14');
    return ChangeNotifierProvider(
      // Initialize the model in the builder. That way, Provider
      // can own GamePlayStatesModel's lifecycle, making sure to call `dispose`
      // when not needed anymore.
      create: (context) => statesModelGlobal,
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: StreamBuilder(
          stream: apiBloc.cardsRes,
          builder: (context, AsyncSnapshot<CardsResModel> snapshot) {
            if (snapshot.hasData && snapshot.data.status == 1) {
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
                          child: BuildPlayer1Screen(cards.length, p1FullName, p2Name, gameScoreStatusValueNotify),
                        ),
                        Expanded(
                          flex: 7,
                          child: Consumer<GamePlayStatesModel>(
                            builder: (context, statesModel, child) => Container(
                              //width: getScreenWidth(context) - 400,
                              child: Column(
                                children: [
                                  gamePlayTimerUi(context, onTimeEnd: (bool isTimeEnded) => {
                                      //print('Timer Ended');
                                      if (statesModel.player1TotalPoints > statesModel.player2TotalPoints) {
                                          showTimesUpDialog(context, true, statesModel),
                                      } else {
                                          showTimesUpDialog(context, false, statesModel),
                                        }
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
                                            // is updated.
                                            return Container(
                                              width: 220,
                                              height: 300,
                                              child: BounceInLeft(
                                                child: buildCardAsP1(
                                                  context,
                                                  _isPlayAsP1,
                                                  cards,
                                                  indexOfCardDeck,
                                                  isYourNextTurn,
                                                  indexSelectedByP2,
                                                  whoIsPlaying,
                                                  onClickActionOnP1GameplayCard: (int indexOfP1Card, String attributeTitle,
                                                      String attributeValue, String winBasis, String winPoints, bool isFlipped) =>
                                                  {
                                                    print('----p1c clicked'),
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
                                            endRadius: 40,
                                            glowColor: Colors.white,
                                            child: Container(
                                              width: 80,
                                              child: Center(
                                                child: Image.asset(
                                                  'assets/icons/png/img_vs.png',
                                                  color: Colors.orange[800],
                                                ),
                                              ),
                                            ),
                                          ),
                                          preferences: AnimationPreferences(
                                              duration: const Duration(milliseconds: 4000), autoPlay: AnimationPlayStates.Loop),
                                        ),

                                        ValueListenableBuilder(
                                          builder: (BuildContext context, int value, Widget child) {
                                            // This builder will only get called when the _counter
                                            // is updated.
                                            return Container(
                                              width: 150,
                                              height: 210,
                                              alignment: AlignmentDirectional.bottomCenter,
                                              child: BounceInRight(
                                                child: buildSecondCard(
                                                    context,
                                                    indexOfP1Card,
                                                    indexOfCardDeck,
                                                    cards,
                                                    isP1CardFlipped,
                                                    p1TurnStatus,
                                                    p2TurnStatus
                                                ),

                                                /*
                                                          buildPlayerTwoCardOld(
                                                        context,
                                                        indexOfP1Card,
                                                        indexOfCardDeck,
                                                        cards,
                                                        onClickActionOnP2GameplayCard: (bool isWon, int winPoint) =>
                                                        {
                                                          updateGamePlayStatusToFirebase(),

                                                          print('---- p2c data called ${statesModel.isCardOneTouched}, $isWon, $winPoint'),
                                                          if (isWon)
                                                            {
                                                              playerResultStatusList.add("won"), // "won" is lottie file name

                                                              //showing lottie anim depending on win or loose
                                                              showWinDialog(context, statesModel, isWon, 'win-result.json', 'You Won', p1Photo,
                                                                  4000, winPoint),
                                                            }
                                                          else
                                                            {
                                                              playerResultStatusList.add("sad"), // "sad" is lottie file name
                                                              //showing lottie anim depending on win or loose
                                                              showWinDialog(context, statesModel, isWon, 'sad-star.json', '\n\n\n\nYou Loose', '',
                                                                  3500, winPoint),
                                                            },
                                                        },
                                                      ),
                                                          */

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
                                  ValueListenableBuilder(
                                    builder: (BuildContext context, bool isListShow, Widget child) {
                                      return Expanded(
                                        child: Visibility(
                                            visible: isListShow,
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
                                                        child: ClipOval(
                                                          child: setResultStatus(index),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                preferences: AnimationPreferences(
                                                    duration: const Duration(milliseconds: 400), autoPlay: AnimationPlayStates.Forward),
                                              ),
                                            )),
                                      );
                                    },
                                    valueListenable: gameScoreStatusValueNotify,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: BuildPlayerTwoScreen(cards.length, p2Name),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else if (!snapshot.hasData ) {
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

  void getSavedUserDataFromPref() {
    SharedPreferenceHelper().getUserSavedData().then((sharedPrefUserProfileModel) => {
          p1xApiKey = sharedPrefUserProfileModel.xApiKey ?? 'NA',
          p1MemberIdPref = sharedPrefUserProfileModel.memberId ?? 'NA',
          /*p1FullName = sharedPrefUserProfileModel.fullName ?? 'NA',
      p1Photo = sharedPrefUserProfileModel.photo ?? 'NA',
      p1Points = sharedPrefUserProfileModel.points ?? 'NA',*/
        });
  }

  Future<void> initFirebaseCredentials() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    _gamePlayRef = FirebaseDatabase.instance.reference().child('gamePlay');
    _gameRoomRef = FirebaseDatabase.instance.reference().child('gameRoom');

    //gamePlaySubscription = _gamePlayRef.onChildChanged.listen(listeningToFirebaseDataUpdate);


    //get game room data of two players
    //retrieveFirebaseData();
  }

  void manageP1AndP2Data(){
    //if p1 in game room is you then adding game room p1 in your data else
    // if game room p2 is you then adding game room p2 data in your data.

    //After getting p1Id and p2Id creating game room name
    this._gameRoomName = 'gamePlay-$p1MemberId-$p2MemberId';
    print('-----_gameRoomName: $_gameRoomName');

    if (p1MemberIdPref == p1MemberId) {
      //you are playing as p1
      _isPlayAsP1 = true; // this is different than whoIsPlaying var
      isYourNextTurn = true;
      whoIsPlaying = 'p1';
      this.p1FullName = p1FullName;
      this.p1MemberId = p1MemberId;
      this.p1Photo = p1Photo;

      this.p2Name = p2Name;
      this.p2MemberId = p2MemberId;
      this.p2Image = p2Image;
    } else if (p1MemberIdPref == p2MemberId) {
      //you are playing as p2
      _isPlayAsP1 = false;
      isYourNextTurn = false;
      whoIsPlaying = 'p2';
      this.p1FullName = p2Name;
      this.p1MemberId = p2MemberId;
      this.p1Photo = p2Image;

      this.p2Name = p1FullName;
      this.p2MemberId = p1MemberId;
      this.p2Image = p1Photo;
    }

    listeningToFirebaseDataUpdate(_gameRoomName);
  }

  /*void retrieveFirebaseData() async {
    try {
      _gameRoomRef.once().then((onValue) {
        onValue.value.forEach((playerDetailsKey, playerDetailsValue) {
          if (playerDetailsKey.contains(p1MemberIdPref)) {
            Map playersDetailsInRoom = playerDetailsValue;
            //if p1 in game room is you then adding game room p1 in your data else
            // if game room p2 is you then adding game room p2 data in your data.

            //After getting p1Id and p2Id creating game room name
            this._gameRoomName = 'gamePlay-${playersDetailsInRoom['p1Id']}-${playersDetailsInRoom['p2Id']}';
            print('-----_gameRoomName: $_gameRoomName');

            if (p1MemberIdPref == playersDetailsInRoom['p1Id']) {
              //you are playing as p1
              _isPlayAsP1 = true; // this is different than whoIsPlaying var
              isYourNextTurn = true;
              whoIsPlaying = 'p1';
              this.p1FullName = playersDetailsInRoom['p1Name'];
              this.p1MemberId = playersDetailsInRoom['p1Id'];
              this.p1Photo = playersDetailsInRoom['p1Image'];

              this.p2Name = playersDetailsInRoom['p2Name'];
              this.p2MemberId = playersDetailsInRoom['p2Id'];
              this.p2Image = playersDetailsInRoom['p2Image'];
            } else if (p1MemberIdPref == playersDetailsInRoom['p2Id']) {
              //you are playing as p2
              _isPlayAsP1 = false;
              isYourNextTurn = false;
              whoIsPlaying = 'p2';
              this.p1FullName = playersDetailsInRoom['p2Name'];
              this.p1MemberId = playersDetailsInRoom['p2Id'];
              this.p1Photo = playersDetailsInRoom['p2Image'];

              this.p2Name = playersDetailsInRoom['p1Name'];
              this.p2MemberId = playersDetailsInRoom['p1Id'];
              this.p2Image = playersDetailsInRoom['p1Image'];
            }

            this.categoryName = playersDetailsInRoom['category'];
            this.subcategoryName = playersDetailsInRoom['subCategory'];
            this.gameType = playersDetailsInRoom['gameType'];
            this.cardsToPlay = playersDetailsInRoom['cardCount'];

            listeningToFirebaseDataUpdate(_gameRoomName);
          }
        });
      });

    } catch (e) {
      print(e);
    }
  }*/

  updateGamePlayStatus(String attrTitle, String attrValue, String winBasis, String winPoints) async{
    if (_isPlayAsP1) {
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

    print('-------p1TurnStatus: $p1TurnStatus');
    print('----p2TurnStatus: $p2TurnStatus');

    updateGamePlayStatusToFirebase();
  }

  void updateGamePlayStatusToFirebase() async{
    _gamePlayRef.child(_gameRoomName).set({
      'isP1TurnComplete': p1TurnStatus,
      'isP2TurnComplete': p2TurnStatus,
      'selectedArrayPos': indexOfP1Card,
      'p1SelectedAttr': p1SelectedAttr,
      'p1SelectedAttrValue': p1SelectedAttrValue,
      'p2SelectedAttr': p2SelectedAttr,
      'p2SelectedAttrValue': p2SelectedAttrValue,
      'winner': winner,
    }).then((_) {});
  }

  void listeningToFirebaseDataUpdate(String gameRoomName) async {
    gamePlaySubscription = _gamePlayRef.onChildChanged.listen((Event event){
      if (event.snapshot.key == gameRoomName) {
        var changeMapData = event.snapshot.value;

        print('Gp on data changed ${event.snapshot.key}');
        print('Gp isP1TurnComplete: ${changeMapData['isP1TurnComplete']}');
        print('Gp isP2TurnComplete: ${event.snapshot.value['isP2TurnComplete']}');
        print('Gp p1SelectedAttr: ${event.snapshot.value['p1SelectedAttr']}');
        print('Gp p1SelectedAttrValue: ${event.snapshot.value['p1SelectedAttrValue']}');
        print('Gp p2SelectedAttr: ${event.snapshot.value['p2SelectedAttr']}');
        print('Gp p2SelectedAttrValue: ${event.snapshot.value['p2SelectedAttrValue']}');

        // event.snapshot.value is return map. Below line getting values from map using keys
        p1TurnStatus = changeMapData['isP1TurnComplete'];
        p2TurnStatus = changeMapData['isP2TurnComplete'];
        p1SelectedAttr = changeMapData['p1SelectedAttr'];
        p1SelectedAttrValue = changeMapData['p1SelectedAttrValue'];
        p2SelectedAttr = changeMapData['p2SelectedAttr'];
        p2SelectedAttrValue = changeMapData['p2SelectedAttrValue'];
        winner = changeMapData['winner'];

        try {
          if (p1TurnStatus == 'yes' && p2TurnStatus == 'no') {
            if (!_isPlayAsP1) {
              indexSelectedByP2 = changeMapData['selectedArrayPos'];
              whoIsPlaying = 'p2';
              isYourNextTurn = true;
              card1ValueNotify.value +=1;
            }
            card2ValueNotify.value +=1;

          } else if (p1TurnStatus == 'no' && p2TurnStatus == 'yes') {
            indexSelectedByP2 = changeMapData['selectedArrayPos'];
            isYourNextTurn = true;
            whoIsPlaying = 'p2';
            card2ValueNotify.value +=1;
            card1ValueNotify.value +=1;

          } else if (p1TurnStatus == 'yes' && p2TurnStatus == 'yes') {
            //winBasis and winPints will be same for both player. So I am getting those value when p1 selected first value
            bool areYouWon = false;
            if (winBasis == 'Highest Value') {
              if(_isPlayAsP1){
                int.parse(p1SelectedAttrValue) > int.parse(p2SelectedAttrValue) ? areYouWon = true : areYouWon = false;
                showWinOrLossDialog(areYouWon);
              }else {
                int.parse(p1SelectedAttrValue) > int.parse(p2SelectedAttrValue) ? areYouWon = false : areYouWon = true;
                showWinOrLossDialog(areYouWon);
              }
            } else if (winBasis == 'Lowest Value') {
              if(_isPlayAsP1){
                int.parse(p1SelectedAttrValue) < int.parse(p2SelectedAttrValue) ? areYouWon = true : areYouWon = false;
                showWinOrLossDialog(areYouWon);
              }else {
                int.parse(p1SelectedAttrValue) < int.parse(p2SelectedAttrValue) ? areYouWon = false : areYouWon = true;
                showWinOrLossDialog(areYouWon);
              }
            }
          }
        } catch (e) {
          print(e);
        }
      }
    });
  }

  void showWinOrLossDialog(bool areYouWon) async{
    if (areYouWon) {
      showWinDialog(_scaffoldKey.currentContext, areYouWon, 'win-result.json', 'You Won', p1Photo, 4000);
    } else {
      showWinDialog(_scaffoldKey.currentContext, areYouWon, 'sad-star.json', '\n\n\n\nYou Loose', '', 3500);
    }
  }

  Widget setResultStatus(int index) {
    return playerResultStatusList[index] == 'won'
        ? SvgPicture.asset('assets/icons/svg/${playerResultStatusList[index]}.svg', height: 25, width: 25)
        : SvgPicture.asset('assets/icons/svg/${playerResultStatusList[index]}.svg', height: 25, width: 25);
  }

  void showWinDialog(BuildContext context, bool isWon, String lottieFileName, String message,
      String photoUrl, int animHideTime) async {

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
                          placeholder: isWon ? 'assets/icons/png/circle-avator-default-img.png' : '',
                          image: photoUrl ?? '',
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

        bool isMatchEndedStatus = statesModelGlobal.cardCountOnDeck == 1 ? true : false;

        showBothCardsDialog(context, cards, indexOfP1Card, indexOfCardDeck, isMatchEndedStatus, _isPlayAsP1,
            isWon, onClickActionOnPlayAgain: (bool isMatchEnded) {
          try{
            if (!isMatchEnded) {
              indexOfCardDeck = indexOfCardDeck + 1;

              /*print('-----isWon1: $isWon ');
              print('-----winPoint: $winPoints ');
              print('-----statesModel.playerOneTrump: ${statesModelGlobal.playerOneTrump} ');
              print('-----statesModel.player1TotalPoints: ${statesModelGlobal.player1TotalPoints} ');
              print('-----statesModel.playerTwoTrump: ${statesModelGlobal.playerTwoTrump} ');
              print('-----statesModel.player2TotalPoints: ${statesModelGlobal.player2TotalPoints} ');*/

              print('-----statesModel.cardCountOnDeck: ${statesModelGlobal.cardCountOnDeck}');

              if (isWon) {
                statesModelGlobal.playerOneTrump = statesModelGlobal.playerOneTrump + 1;
                statesModelGlobal.player1TotalPoints = statesModelGlobal.player1TotalPoints + int.parse(winPoints);
              } else {
                statesModelGlobal.playerTwoTrump = statesModelGlobal.playerOneTrump + 1;
                statesModelGlobal.player2TotalPoints = statesModelGlobal.player2TotalPoints + int.parse(winPoints);
              }

              showToast(context, isWon ? "Your Turn To Play" : '$p2Name Turn To Play');


              if (isWon) {
                isYourNextTurn = true;
                whoIsPlaying = 'p1';
              } else {
                isYourNextTurn = false;
                whoIsPlaying = 'p2';
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
              gotoResultScreen(context, true, statesModelGlobal);
            }

          } catch(e){

          }
        });

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
              child: Lottie.asset('assets/animations/lottiefiles/times-up.json', height: 290, width: 290, repeat: false, animate: true),
            ),
            preferences: AnimationPreferences(duration: const Duration(milliseconds: 800), autoPlay: AnimationPlayStates.Forward),
          ),
        );
      },
    );

    Timer(Duration(milliseconds: 3000), () {
      Navigator.pop(dialogContext);
      gotoResultScreen(context, isP1Won, statesModel);
    });
  }

  void gotoResultScreen(BuildContext context, bool isP1Won, GamePlayStatesModel statesModel) {
    isP1Won
        ? Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => GameResult(
                winnerName: p1FullName,
                winnerId: p1MemberId,
                winnerImage: p1Photo,
                winnerCoins: "0",
                winnerPoints: statesModel.player1TotalPoints.toString(),
                cardType: categoryName,
                clashType: '1 vs 1',
                //static
                playedCards: cardsToPlay,
                isP1Won: true,
                gamePlayType: 'vsPlayer',
              ),
            ),
          )
        : Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => GameResult(
                winnerName: p2Name,
                winnerId: p2MemberId,
                winnerImage: p2Image,
                winnerCoins: "0",
                winnerPoints: statesModel.player2TotalPoints.toString(),
                cardType: categoryName,
                clashType: '1 vs 1',
                playedCards: cardsToPlay,
                isP1Won: false,
                gamePlayType: 'vsPlayer',
              ),
            ),
          );

    //remove game when match is complete
    _gameRoomRef.child(_gameRoomName).remove();
    //dispose firebase ref subs
    gamePlaySubscription.cancel();
  }

  void fetchApiData() async {
    //apiBloc.fetchCardsRes("ZGHrDz4prqsu4BcApPaQYaGgq", subcategoryName, categoryName, '2', cardsToPlay);
    await apiBloc.fetchCardsRes("ZGHrDz4prqsu4BcApPaQYaGgq", 'cricket', 'sports', '2', '14');
  }

/*@override
  void dispose() {
    super.dispose();
    playerDetailsSubscription.cancel();
    _joinedPlayerSubscription.cancel();
  }*/
}
