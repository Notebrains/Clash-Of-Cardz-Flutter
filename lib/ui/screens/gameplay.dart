import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:trump_card_game/helper/shared_preference_data.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animator/flutter_animator.dart';
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
  BuildContext _context;
  GamePlayStatesModel statesModel;
  final List<String> playerResultStatusList = [];
  List<Cards> cards = [];
  int indexOfP1Card = 0;
  int indexOfCardDeck = 0;
  String p1MemberIdPref = '';
  bool _isPlayAsP1 = false;

  String p2Name = '';
  String p2MemberId = '';
  String p2Image = '';
  String categoryName = '';
  String subcategoryName = '';
  String gameType = '';
  String cardsToPlay = '';
  String p1xApiKey = '';
  String p1FullName = '';
  String p1MemberId = '';
  String p1Points = '';
  String p1Photo = '';
  String winBasis = '';
  String winPoints = '';

  // gameplay stats attr
  String p1TurnStatus = 'no',  p2TurnStatus = 'no', p1SelectedAttr = '', p1SelectedAttrValue = '', p2SelectedAttr = '', p2SelectedAttrValue = '', winner = 'p1';

  bool isYourNextTurn = false;

  //firebase data init
  DatabaseReference _gamePlayRef;
  DatabaseReference _gameRoomRef;
  StreamSubscription<Event> gamePlaySubscription;
  DatabaseError _error;

  FirebaseApp firebaseApp;

  String _gameRoomName = 'gamePlay';

  @override
  Widget build(BuildContext context) {

    this._context = context;

    getSavedUserDataFromPref();

    initFirebaseCredentials();

    //apiBloc.fetchCardsRes("ZGHrDz4prqsu4BcApPaQYaGgq", subcategoryName, categoryName, '2', cardsToPlay);
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
            cards = snapshot.data.response.cards;
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
                          child: BuildPlayer1Screen(cards.length, p1FullName, p2Name),
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
                                        height: getScreenHeight(context) / 1.5,
                                        child:  Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 220,
                                              height: 300,
                                              child: BounceInLeft(
                                                child: buildCardAsP1(
                                                  context,
                                                  _isPlayAsP1,
                                                  cards,
                                                  indexOfCardDeck,
                                                  isYourNextTurn,
                                                  onClickActionOnP1GameplayCard:
                                                      (int indexOfP1Card, String attributeTitle, String attributeValue, String winBasis, String winPoints) =>
                                                  {
                                                    //print('----p1c clicked'),
                                                    this.indexOfP1Card = indexOfP1Card,

                                                    updateGamePlayStatus( statesModel, attributeTitle, attributeValue, winBasis, winPoints),
                                                  },
                                                ),
                                                preferences: AnimationPreferences(
                                                    duration: const Duration(milliseconds: 1500),
                                                    autoPlay: AnimationPlayStates.Forward),
                                              ),
                                            ),

                                            HeartBeat(
                                              child: AvatarGlow(
                                                endRadius: 27,
                                                glowColor: Colors.orangeAccent,
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


                                            Container(
                                              width: 150,
                                              height: 210,
                                              alignment: AlignmentDirectional.bottomCenter,
                                              child: BounceInRight(
                                                child: buildSecondCard(
                                                  context,
                                                  indexOfP1Card,
                                                  indexOfCardDeck,
                                                  cards),

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
                                                    duration: const Duration(milliseconds: 1500),
                                                    autoPlay: AnimationPlayStates.Forward),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Expanded(
                                        child: Container(
                                          //height: getScreenHeight(context) / 6.5,
                                          child: Visibility(
                                              //visible: statesModel.isShowPlayerMatchStatus,
                                              visible: true,
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
                          child: BuildPlayerTwoScreen(cards.length, p2Name),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else if (!snapshot.hasData) {
              return frostedGlassWithProgressBarWidget(context);
            } else return Center(
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

    _gamePlayRef = FirebaseDatabase.instance.reference().child('gamePlay');
    _gameRoomRef = FirebaseDatabase.instance.reference().child('gameRoom');

    gamePlaySubscription = _gamePlayRef.onChildChanged.listen(listeningToFirebaseDataUpdate);

    //get game room data of two players
    retrieveFirebaseData();
  }

  void retrieveFirebaseData() async{
    
    try{
      _gameRoomRef.once().then((onValue) {
        onValue.value.forEach((playerDetailsKey, playerDetailsValue) {
          if (playerDetailsKey.contains(p1MemberIdPref)) {
            Map playersDetailsInRoom = playerDetailsValue;
            //if p1 in game room is you then adding game room p1 in your data else 
            // if game room p2 is you then adding game room p2 data in your data.

            if(p1MemberIdPref == playersDetailsInRoom['p1Id']){
              //you are playing as p1
              _isPlayAsP1 =true;
              this.p1FullName = playersDetailsInRoom['p1Name'];
              this.p1MemberId = playersDetailsInRoom['p1Id'];
              this.p1Photo = playersDetailsInRoom['p1Image'];

              this.p2Name = playersDetailsInRoom['p2Name'];
              this.p2MemberId = playersDetailsInRoom['p2Id'];
              this.p2Image = playersDetailsInRoom['p2Image'];
            } else if(p1MemberIdPref == playersDetailsInRoom['p2Id']){
              //you are playing as p2
              _isPlayAsP1 = false;
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

            //After getting p1Id and p2Id creating game room name
            this._gameRoomName = 'gamePlay-$p1MemberId-$p2MemberId';
            //print('----- gamePlay-$p1MemberId-$p2MemberId');
          }
        });
      });
    } catch(e){
      print(e);
    }
  }

  //no need to use this method
  Future<void> pushGamePlayStatus() async {
    _gamePlayRef.push().set(<String, String>{
      'isP1TurnComplete': 'no',
      'isP2TurnComplete': 'no',
    });
  }

  updateGamePlayStatus(GamePlayStatesModel statesModel, String attrTitle, String attrValue, String winBasis, String winPoints) {
    if (_isPlayAsP1) {
      p1TurnStatus = 'yes';
      p1SelectedAttr = attrTitle;
      p1SelectedAttrValue = attrValue;
      //p2SelectedAttr = '';
      //p2SelectedAttrValue = '';
    } else {
      p2TurnStatus  = 'yes';
      //p1SelectedAttr = '';
      //p1SelectedAttrValue = '';
      p2SelectedAttr = attrTitle;
      p2SelectedAttrValue = attrValue;
    }

    isYourNextTurn = false;

    this.winBasis = winBasis;
    this.winPoints = winPoints;
    this.statesModel = statesModel;

    updateGamePlayStatusToFirebase();
  }

  void updateGamePlayStatusToFirebase() {
    _gamePlayRef.child(_gameRoomName).set({
      'isP1TurnComplete': p1TurnStatus,
      'isP2TurnComplete': p2TurnStatus,
      'selectedArrayPos': indexOfP1Card,
      'p1SelectedAttr': p1SelectedAttr,
      'p1SelectedAttrValue': p1SelectedAttrValue,
      'p2SelectedAttr': p2SelectedAttr,
      'p2SelectedAttrValue': p2SelectedAttrValue,
      'winner': winner,

    }).then((_) {
      // ...
    });
  }

  void listeningToFirebaseDataUpdate(Event event) {
    var changeMapData = event.snapshot.value;
    print('Gp on data changed ${event.snapshot.value}');
    print('Gp isP1TurnComplete: ${changeMapData['isP1TurnComplete']}');
    //print('Gp isP2TurnComplete: ${event.snapshot.value['isP2TurnComplete']}');

    // event.snapshot.value is return map. Below line getting values from map using keys
    p1TurnStatus =        changeMapData['isP1TurnComplete'];
    p2TurnStatus =        changeMapData['isP2TurnComplete'];
    p1SelectedAttr =      changeMapData['p1SelectedAttr'];
    p1SelectedAttrValue = changeMapData['p1SelectedAttrValue'];
    p2SelectedAttr =      changeMapData['p2SelectedAttr'];
    p2SelectedAttrValue = changeMapData['p2SelectedAttrValue'];
    winner =              changeMapData['winner'];

    if (p1TurnStatus == 'no' && p2TurnStatus == 'no'){
      //buildSecondCard(false);
      isYourNextTurn = false;
      buildCardAsP1(
        _context,
        _isPlayAsP1,
        cards,
        indexOfCardDeck,
        isYourNextTurn,
        onClickActionOnP1GameplayCard:
            (int indexOfP1Card, String attributeTitle, String attributeValue, String winBasis, String winPoints) =>
        {
          //print('----p1c clicked'),
          this.indexOfP1Card = indexOfP1Card,

          updateGamePlayStatus( statesModel, attributeTitle, attributeValue, winBasis, winPoints),
        },
      );

    } else if (p1TurnStatus == 'yes' && p2TurnStatus == 'no'){
      //buildSecondCard(true);
      isYourNextTurn = true;

      buildCardAsP1(
        _context,
        _isPlayAsP1,
        cards,
        indexOfCardDeck,
        isYourNextTurn,
        onClickActionOnP1GameplayCard:
            (int indexOfP1Card, String attributeTitle, String attributeValue, String winBasis, String winPoints) =>
        {
          //print('----p1c clicked'),
          this.indexOfP1Card = indexOfP1Card,

          updateGamePlayStatus( statesModel, attributeTitle, attributeValue, winBasis, winPoints),
        },
      );
    } else if (p1TurnStatus == 'yes' && p2TurnStatus == 'yes'){

      bool areYouWon = false;
      if(winBasis == 'Highest Value'){
        int.parse(p1SelectedAttrValue) > int.parse(p2SelectedAttrValue) ? areYouWon = true : areYouWon = false;
      } else if (winBasis == 'Lowest Value'){
        int.parse(p1SelectedAttrValue) < int.parse(p2SelectedAttrValue) ? areYouWon = true : areYouWon = false;
      }

      if (int.parse(p1SelectedAttrValue) > int.parse(p1SelectedAttrValue) ) {
        showWinDialog(_context, statesModel, areYouWon, 'win-result.json', 'You Won', p1Photo, 4000, 0);
      } else {
        //showing lottie anim depending on win or loose
        showWinDialog(_context, statesModel, areYouWon, 'sad-star.json', '\n\n\n\nYou Loose', '', 3500, 0);
      }
    }

    //winBasis and winPints will be same for both player. So I am getting those value when p1 selected first value
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
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/icons/png/circle-avator-default-img.png',
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
        isYourNextTurn = true;
      } else {
        statesModel.playerTwoTrump = statesModel.playerOneTrump + 1;
        statesModel.player2TotalPoints = statesModel.player2TotalPoints + winPoint;
        isYourNextTurn = false;
      }

      p1TurnStatus = 'no';
      p2TurnStatus = 'no';

      _gamePlayRef.child(_gameRoomName).set({
        'isP1TurnComplete': p1TurnStatus,
        'isP2TurnComplete': p2TurnStatus,
      });

      Timer(Duration(milliseconds: animHideTime), () {
        Navigator.pop(dialogContext);

        showBothCardsDialog(context, cards, indexOfP1Card, indexOfCardDeck, statesModel.cardCountOnDeck == 0 ? true : false, _isPlayAsP1,onClickActionOnPlayAgain :( bool isMatchEnded){
          if (!isMatchEnded) {
            indexOfCardDeck = indexOfCardDeck + 1;

            context.read<GamePlayStatesModel>().updatePlayerScoreboards(
                statesModel.playerOneTrump,
                statesModel.playerTwoTrump,
                statesModel.player1TotalPoints,
                statesModel.player2TotalPoints);

            context.read<GamePlayStatesModel>().updateCardCountOnDeck(statesModel.cardCountOnDeck - 1);

            String message = '';
            isYourNextTurn ? message = "Your Turn To Play" : message = 'P-2 Turn To Play';

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
          } else{
            gotoResultScreen(context, true, statesModel);
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
      gotoResultScreen(context, isP1Won, statesModel);
    });
  }

  void gotoResultScreen(BuildContext context, bool isP1Won, GamePlayStatesModel statesModel) {

    isP1Won ? Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) =>
            GameResult(
              winnerName: p1FullName,
              winnerId: p1MemberId,
              winnerImage: p1Photo,
              winnerCoins: "0",
              winnerPoints: statesModel.player1TotalPoints.toString(),
              cardType: categoryName,
              clashType: '1 vs 1', //static
              playedCards: cardsToPlay,
              isP1Won: true,
              gamePlayType: 'vsPlayer',
            ),
      ),
    ) :
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) =>
            GameResult(
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


/*@override
  void dispose() {
    super.dispose();
    playerDetailsSubscription.cancel();
    _joinedPlayerSubscription.cancel();
  }*/
}
