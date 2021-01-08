import 'dart:async';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:trump_card_game/helper/shared_preference_data.dart';
import 'package:trump_card_game/model/arguments/firebase_player_details_model.dart';
import 'package:trump_card_game/ui/screens/gameplay.dart';
import 'package:trump_card_game/ui/screens/home.dart';
import 'dart:io' show Platform;

import 'package:trump_card_game/ui/widgets/libraries/flutter_toast.dart';

class IncludeWaitingForFriend extends StatefulWidget {
  final String categoryName;
  final String subcategoryName;
  final String gameType;
  final String cardsToPlay;
  final String friendId;
  final String friendName;
  final String friendImage;
  final String joinedPlayerType;

  const IncludeWaitingForFriend({Key key, this.categoryName, this.subcategoryName, this.gameType, this.cardsToPlay, this.friendId, this.friendName, this.friendImage, this.joinedPlayerType}) : super(key: key);

  @override
  State<StatefulWidget> createState() => IncludeWaitingForFriendState();
}

class IncludeWaitingForFriendState extends State<IncludeWaitingForFriend> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  List <FirebasePlayerDetailsModel> fbJoinedPlayerList = [];

  int joinedPlayerCount;
  int joinedPlayerSize = 0;
  DatabaseReference _friendDetailsRef;
  StreamSubscription<Event> _joinedPlayerSubscription;
  StreamSubscription<Event> playerDetailsSubscription;

  FirebaseApp firebaseApp;

  var xApiKey = '';
  var fullName = '';
  var memberId = '';
  var points = '';
  var photo = '';

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    SharedPreferenceHelper().getUserSavedData().then((sharedPrefUserProfileModel) => {
      print('----pref ${sharedPrefUserProfileModel.memberId}'),

      xApiKey = sharedPrefUserProfileModel.xApiKey ?? 'NA',
      fullName = sharedPrefUserProfileModel.fullName ?? 'NA',
      memberId = sharedPrefUserProfileModel.memberId ?? 'NA',
      photo = sharedPrefUserProfileModel.photo ?? 'NA',
      points = sharedPrefUserProfileModel.points ?? 'NA',
    });

    controller.forward();

    initFirebaseCredentials();

    retrieveFirebaseData();

    listeningToFirebaseDataUpdate();
  }

  void updateState() {
    setState(() {
      retrieveFirebaseData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Stack(
            children: <Widget>[
              new ConstrainedBox(
                constraints: const BoxConstraints.expand(),
              ),
              new Center(
                child: new ClipRect(
                  child: new BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: new Container(
                      decoration: new BoxDecoration(color: Colors.grey.shade50.withOpacity(0.1)),
                      child: new Center(
                        child: Container(
                          margin: EdgeInsets.all(5.0),
                          padding: EdgeInsets.all(5.0),
                          height: MediaQuery.of(context).size.height,
                          decoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Lottie.asset(
                                'assets/animations/lottiefiles/sports-loading.json',
                                width: getScreenWidth(context),
                                height: getScreenHeight(context) * 0.6,
                              ),

                              Container(
                                height: getScreenHeight(context) / 6.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TweenAnimationBuilder<Duration>(
                                        duration: Duration(minutes: 1),
                                        tween: Tween(begin: Duration(minutes: 1), end: Duration.zero),
                                        onEnd: () {
                                          //print('Timer Ended');

                                          //remove first user from firebase if requested player has not joined.
                                          _friendDetailsRef.equalTo(fbJoinedPlayerList[0].playerName).once().then((DataSnapshot snapshot) {
                                            Map<dynamic, dynamic> children = snapshot.value;
                                            children.forEach((key, value) {
                                              _friendDetailsRef.child(key).remove();
                                            });
                                          });

                                          Toast.show("Player has not joined the match", context, duration: Toast.lengthLong, gravity:  Toast.bottom);

                                          Navigator.push(
                                              context, CupertinoPageRoute(builder: (context) => HomeScreen(),
                                          ),
                                          );
                                        },
                                        builder: (BuildContext context, Duration value, Widget child) {
                                          //adding 0 at first if min or sec show in single digit
                                          final minutes = (value.inMinutes).toString().padLeft(2, "0");
                                          final seconds = (value.inSeconds % 60).toString().padLeft(2, "0");
                                          return Center(
                                            child: Text(
                                              '$minutes : $seconds',
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
                                          );
                                        }),
                                  ],
                                ),
                              ),

                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'Waiting for your friend to accept the request',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24, fontFamily: 'neuropol_x_rg', fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> initFirebaseCredentials() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  void retrieveFirebaseData() {
    // Demonstrates configuring the database directly
    final FirebaseDatabase database = FirebaseDatabase(app: firebaseApp);
    _friendDetailsRef = database.reference().child('friendDetails');

    //get child items present in fb db.
    fbJoinedPlayerList = [];
    _friendDetailsRef.once().then((onValue) {
      Map playerDetailsList = onValue.value;
      joinedPlayerSize = playerDetailsList.length;

      print('----joinedPlayerSize: $joinedPlayerSize');

      // Execute forEach()
      playerDetailsList.forEach((playerDetailsKey, playerDetailsValue) {
        print('Player Details List: { key: $playerDetailsKey, value: $playerDetailsValue}');

        Map playerDataInPlayerDetailsList = playerDetailsValue;

        if (playerDataInPlayerDetailsList.containsValue(memberId) || playerDataInPlayerDetailsList.containsValue(widget.friendId)) {

          print('---- Fb data filter list: ${widget.categoryName}, ${widget.subcategoryName}, ${widget.gameType}, ${widget.cardsToPlay}');

          FirebasePlayerDetailsModel model = FirebasePlayerDetailsModel();

          _friendDetailsRef.child('playerName').once().then((DataSnapshot snapshot) {
            model.playerName = snapshot.value;
          });


          _friendDetailsRef.child('userId').once().then((DataSnapshot snapshot) {
            model.userId = snapshot.value;
          });


          _friendDetailsRef.child('image').once().then((DataSnapshot snapshot) {
            model.photo = snapshot.value;
          });

          if(widget.joinedPlayerType == 'joinedAsFriend' && fbJoinedPlayerList.length == 0){
            Toast.show('Your friend left the match', context, duration: Toast.lengthLong, gravity:  Toast.bottom);
          } else{
            fbJoinedPlayerList.add(model);
          }

        }

        playerDataInPlayerDetailsList.forEach((playerDataKey, playerDataValue) {
          print('player Data In Player Details List: { inner key: $playerDataKey, inner value: $playerDataValue}');
        });

      });
    });

    // After getting player list from fb, updating fb and start playing
    updateFirebaseJoinedPlayerDetails();
  }

  @override
  void dispose() {
    super.dispose();
    playerDetailsSubscription.cancel();
    _joinedPlayerSubscription.cancel();
  }

  Future<void> updateFirebaseJoinedPlayerDetails() async {
    print('Fb ${fbJoinedPlayerList.length} join type: ${widget.joinedPlayerType}');

    //if player is already looking for player then take 1 player and remove that player else join as host
    if (fbJoinedPlayerList.length == 0 && widget.joinedPlayerType == 'joinedAsPlayer') {
      _friendDetailsRef.push().set(<String, String>{
        //count: ${transactionResult.dataSnapshot.value}
        'playerName': fullName,
        'image': photo,
        'userId': memberId,
        'joinedUserType': widget.joinedPlayerType,
        'category': widget.categoryName,
        'subCategory': widget.subcategoryName,
        'gameType': widget.gameType,
        'cardCount': widget.cardsToPlay,
      });

    } else if(fbJoinedPlayerList.length == 1 && widget.joinedPlayerType == 'joinedAsFriend'){

      _friendDetailsRef.push().set(<String, String>{
        'playerName': widget.friendName,
        'image': widget.friendImage,
        'userId': widget.friendId,
        'joinedUserType': widget.joinedPlayerType,
        'category': widget.categoryName,
        'subCategory': widget.subcategoryName,
        'gameType': widget.gameType,
        'cardCount': widget.cardsToPlay,
      });

    } else {
      if (fbJoinedPlayerList.length == 2) {
        _friendDetailsRef.equalTo(fbJoinedPlayerList[0].playerName).once().then((DataSnapshot snapshot) {
          Map<dynamic, dynamic> children = snapshot.value;
          children.forEach((key, value) {
            _friendDetailsRef.child(key).remove();
          });
        });

        _friendDetailsRef.equalTo(fbJoinedPlayerList[1].playerName).once().then((DataSnapshot snapshot) {
          Map<dynamic, dynamic> children = snapshot.value;
          children.forEach((key, value) {
            _friendDetailsRef.child(key).remove();
          });
        });

        //start the game
        openGamePlayPage(fbJoinedPlayerList[1].playerName ,fbJoinedPlayerList[1].userId ,fbJoinedPlayerList[1].photo);
      } else {

      }
    }
  }

  void listeningToFirebaseDataUpdate() {

    //getting joinedPlayerCount when it changed

    final FirebaseDatabase database = FirebaseDatabase(app: firebaseApp);

    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);

    playerDetailsSubscription = _friendDetailsRef.limitToFirst(1).onChildAdded.listen((Event event) {
      print('Child added: ${event.snapshot.value}');

      //getting updated firebase list when new player added.
      updateState();

    }, onError: (Object o) {
      final DatabaseError error = o;
      print('Error: ${error.code} ${error.message}');
    });
  }

  void openGamePlayPage(String playerName, playerId, playerImage) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) =>
            Gameplay(
              joinedPlayerName: playerName,
              joinedPlayerId: playerId,
              joinedPlayerImage: playerImage,
            ),
      ),
    );
  }
}
