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
import 'package:trump_card_game/ui/screens/autoplay.dart';
import 'package:trump_card_game/ui/screens/gameplay.dart';
import 'package:trump_card_game/ui/screens/home.dart';
import 'package:trump_card_game/ui/widgets/custom/frosted_glass.dart';
import 'dart:io' show Platform;

import 'package:trump_card_game/ui/widgets/libraries/flutter_toast.dart';

class IncludeSearchingForPlayer extends StatefulWidget {
  final String categoryName;
  final String subcategoryName;
  final String gameType;
  final String cardsToPlay;

  const IncludeSearchingForPlayer({Key key, this.categoryName, this.subcategoryName, this.gameType, this.cardsToPlay}) : super(key: key);

  @override
  State<StatefulWidget> createState() => IncludeSearchingForPlayerState();
}

class IncludeSearchingForPlayerState extends State<IncludeSearchingForPlayer> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  List <FirebasePlayerDetailsModel> fbJoinedPlayerList = [];

  int joinedPlayerCount;
  int joinedPlayerSize = 0;
  DatabaseReference _joinedPlayerCountRef;
  DatabaseReference _playerDetailsRef;
  StreamSubscription<Event> _joinedPlayerSubscription;
  StreamSubscription<Event> playerDetailsSubscription;
  DatabaseError _error;

  FirebaseApp firebaseApp;

  var xApiKey = '';
  var fullName = '';
  var memberId = '';
  var points = '';
  var photo = '';

  bool isHost = false;

  @override
  void initState() {
    super.initState();

    initFirebaseCredentials();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    SharedPreferenceHelper().getUserSavedData().then((sharedPrefUserProfileModel) => {
      print('Fb pref ${sharedPrefUserProfileModel.memberId}'),

      xApiKey = sharedPrefUserProfileModel.xApiKey ?? 'NA',
      fullName = sharedPrefUserProfileModel.fullName ?? 'NA',
      memberId = sharedPrefUserProfileModel.memberId ?? 'NA',
      photo = sharedPrefUserProfileModel.photo ?? 'NA',
      points = sharedPrefUserProfileModel.points ?? 'NA',
    });

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();


    print('Fb retrieveFirebaseData method called 1');
    retrieveFirebaseData();

    listeningToFirebaseDataUpdate();
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
              Center(
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
                                        duration: Duration(minutes: 2),
                                        tween: Tween(begin: Duration(minutes: 2), end: Duration.zero),
                                        onEnd: () {
                                          //print('Timer Ended');

                                          //remove first user from firebase if requested player has not joined.
                                          _playerDetailsRef.child(fbJoinedPlayerList[0].firebasePlayerKey).remove();

                                          Toast.show('Player not found!', context, duration: Toast.lengthLong, gravity:  Toast.bottom,
                                              backgroundColor: Colors.deepOrange,
                                              textStyle:  TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                shadows: [
                                                  Shadow(color: Colors.white),
                                                ],
                                              ));

                                          Navigator.push(
                                            context, CupertinoPageRoute(builder: (context) => HomeScreen(xApiKey: xApiKey, memberId: memberId,),
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
                                    'Searching for player',
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
    _playerDetailsRef = database.reference().child('playerDetails');

    // Demonstrates configuring to the database using a file
    _joinedPlayerCountRef = FirebaseDatabase.instance.reference().child('joinedPlayerCount');

    //get child items present in fb db.
    fbJoinedPlayerList = [];
    _playerDetailsRef.once().then((onValue) {
      Map playerDetailsList = onValue.value;

      try{
        int joinedPlayerSize = playerDetailsList.length;

        print('Fb joinedPlayerSize: $joinedPlayerSize');

        // Execute forEach()
        playerDetailsList.forEach((playerDetailsKey, playerDetailsValue) {
          print('Player Details List: { key: $playerDetailsKey, value: $playerDetailsValue}');

          Map playerDataInPlayerDetailsList = playerDetailsValue;

          if (playerDataInPlayerDetailsList.containsValue(widget.categoryName) &&
              playerDataInPlayerDetailsList.containsValue(widget.subcategoryName) &&
              playerDataInPlayerDetailsList.containsValue(widget.gameType) &&
              playerDataInPlayerDetailsList.containsValue(widget.cardsToPlay)) {
            print('---- Fb data filter list: ${widget.categoryName}, ${widget.subcategoryName}, ${widget.gameType}, ${widget.cardsToPlay}');

            String firebasePlayerName = '';
            String firebasePlayerId = '';
            String firebasePlayerImage = '';

            _playerDetailsRef.child(playerDetailsKey).child('playerName').once().then((DataSnapshot snapshot) {
              print('Fb firebasePlayerName: $firebasePlayerName');
              firebasePlayerName = snapshot.value;
            });

            _playerDetailsRef.child(playerDetailsKey).child('userId').once().then((DataSnapshot snapshot) {
              print('Fb firebasePlayerName: $firebasePlayerName');
              firebasePlayerName = snapshot.value;
            });

            _playerDetailsRef.child(playerDetailsKey).child('image').once().then((DataSnapshot snapshot) {
              print('Fb firebasePlayerName: $firebasePlayerName');
              firebasePlayerName = snapshot.value;
            });

            fbJoinedPlayerList.add(FirebasePlayerDetailsModel(firebasePlayerName, firebasePlayerId, firebasePlayerImage, playerDetailsKey));
          }

          playerDataInPlayerDetailsList.forEach((playerDataKey, playerDataValue) {
            print('player Data In Player Details List: { inner key: $playerDataKey, inner value: $playerDataValue}');
          });

        });

        // After getting player list from fb, updating fb and start playing
        updateFirebaseJoinedPlayerDetails();

      } catch(e){
        // After getting player list from fb, updating fb and start playing
        updateFirebaseJoinedPlayerDetails();
      }
    });
  }

  Future<void> updateFirebaseJoinedPlayerDetails() async {

    print('Fb fb Joined Player List size: ${fbJoinedPlayerList.length}');

    if(fbJoinedPlayerList.length == 0){
      isHost = true;
      _playerDetailsRef.push().set(<String, String>{
        //count: ${transactionResult.dataSnapshot.value}
        'playerName': fullName,
        'image': photo,
        'userId': memberId,
        'joinedUserType': 'host',
        'category': widget.categoryName,
        'subCategory': widget.subcategoryName,
        'gameType': widget.gameType,
        'cardCount': widget.cardsToPlay,
      });
    } else if(fbJoinedPlayerList.length == 1){
      isHost = false;
    } else if (fbJoinedPlayerList.length > 1) {
      isHost = false;
      //if no player then joined as host and wait for player to join the match. Else take first player and start the match
      if (isHost) {
        //removing both players when they matched and start the match
        _playerDetailsRef.child(fbJoinedPlayerList[0].firebasePlayerKey).remove();
        _playerDetailsRef.child(fbJoinedPlayerList[1].firebasePlayerKey).remove();

        //start the game
        openGamePlayPage(fbJoinedPlayerList[1].playerName, fbJoinedPlayerList[1].userId, fbJoinedPlayerList[1].photo);

      } else{
        //removing joined players when start the match
        _playerDetailsRef.child(fbJoinedPlayerList[0].firebasePlayerKey).remove();

        //start the game
        openGamePlayPage(fbJoinedPlayerList[0].playerName ,fbJoinedPlayerList[0].userId ,fbJoinedPlayerList[0].photo);
      }
    }
  }

  void listeningToFirebaseDataUpdate() {

    //getting joinedPlayerCount when it changed

    final FirebaseDatabase database = FirebaseDatabase(app: firebaseApp);

    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    _joinedPlayerCountRef.keepSynced(true);
    _joinedPlayerSubscription = _joinedPlayerCountRef.onValue.listen((Event event) {
      setState(() {
        _error = null;
        //joinedPlayerCount = event.snapshot.value ?? 0;
        joinedPlayerCount = joinedPlayerSize ?? 0;
      });
    }, onError: (Object o) {
      final DatabaseError error = o;
      setState(() {
        _error = error;
      });
    });

    playerDetailsSubscription = _playerDetailsRef.limitToFirst(1).onChildAdded.listen((Event event) {
      print('Child added: ${event.snapshot.value}');

      //getting updated firebase list when new player added.
      retrieveFirebaseData();

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
              p2Name: playerName,
              p2MemberId: playerId,
              p2Image: playerImage,
              categoryName: widget.categoryName,
              subcategoryName: widget.subcategoryName,
              gameType: widget.gameType,
              cardsToPlay: widget.cardsToPlay,
            ),
      ),
    ).then((value) => Navigator.of(context).pop());
  }

  @override
  void dispose() {
    super.dispose();
    playerDetailsSubscription.cancel();
    _joinedPlayerSubscription.cancel();
  }

}
