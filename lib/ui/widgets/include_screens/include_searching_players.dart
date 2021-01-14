import 'dart:async';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:trump_card_game/helper/constantvalues/constants.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:trump_card_game/helper/shared_preference_data.dart';
import 'package:trump_card_game/model/arguments/firebase_player_details_model.dart';
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

  DatabaseReference _playerDetailsRef;
  DatabaseReference _gameRoom;
  StreamSubscription<Event> _joinedPlayerSubscription;
  StreamSubscription<Event> playerDetailsSubscription;
  DatabaseError _error;

  FirebaseApp firebaseApp;

  var xApiKey = '';
  var p1FullName = '';
  var p1MemberId = '';
  var points = '';
  var p1Photo = '';

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
      p1FullName = sharedPrefUserProfileModel.fullName ?? 'NA',
      p1MemberId = sharedPrefUserProfileModel.memberId ?? 'NA',
      p1Photo = sharedPrefUserProfileModel.photo ?? 'NA',
      points = sharedPrefUserProfileModel.points ?? 'NA',
    });

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();

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
                                          funAfterNoPlayerFound();
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
                                                fontSize: 30,
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
    print('Fb retrieveFirebaseData method called 1');

    // Demonstrates configuring the database directly
    //var firebaseInstance = FirebaseDatabase.instance;
    final FirebaseDatabase database = FirebaseDatabase(app: firebaseApp);
    _playerDetailsRef = database.reference().child('playerDetails');
    _gameRoom = database.reference().child('gameRoom');


    //get child items present in fb db.
    fbJoinedPlayerList.clear();
    _playerDetailsRef.once().then((onValue) {
      try{
        Map playerDetailsList = onValue.value;

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
              print('Fb firebasePlayerId: $firebasePlayerId');
              firebasePlayerId = snapshot.value;
            });

            _playerDetailsRef.child(playerDetailsKey).child('image').once().then((DataSnapshot snapshot) {
              print('Fb firebasePlayerImage: $firebasePlayerImage');
              firebasePlayerImage = snapshot.value;
            });

            fbJoinedPlayerList.add(FirebasePlayerDetailsModel(firebasePlayerName, firebasePlayerId, firebasePlayerImage, playerDetailsKey));
          }

        });
        // After getting player list from fb, updating fb and start playing
        updateFirebaseJoinedPlayerDetails();

      } catch(e){
        // After getting player list from fb, updating fb and start playing
        updateFirebaseJoinedPlayerDetails();
      }
    });
  }

  void updateFirebaseJoinedPlayerDetails() {
    //this method is called only for testing
    createGameRoom('MEM000001', 'Sam', Constants.imgUrlTest);

    print('Fb fb Joined Player List size: ${fbJoinedPlayerList.length}');
    if(fbJoinedPlayerList.length == 0){
      _playerDetailsRef.push().set(<String, String>{
        //count: ${transactionResult.dataSnapshot.value}
        'playerName': p1FullName,
        'image': p1Photo,
        'userId': p1MemberId,
        'joinedUserType': 'host',
        'category': widget.categoryName,
        'subCategory': widget.subcategoryName,
        'gameType': widget.gameType,
        'cardCount': widget.cardsToPlay,
      });
    } else if(fbJoinedPlayerList.length == 1){

      //removing joined players when start the match
      _playerDetailsRef.child(fbJoinedPlayerList[0].firebasePlayerKey).remove();

      //createGameRoom(String p1Id, String p1Name, String p1Image, String p2Id, String p2Name, String p2Image)
      createGameRoom(fbJoinedPlayerList[0].userId, fbJoinedPlayerList[0].playerName, fbJoinedPlayerList[0].photo);

    } else if (fbJoinedPlayerList.length > 1) {
      //if no player then joined as host and wait for player to join the match. Else take first player and start the match

      //checking if user is same or different. both member id will be same if the user req for match for 2 times
      if (p1MemberId != fbJoinedPlayerList[0].userId) {
        //removing both players when they matched and start the match
        _playerDetailsRef.child(fbJoinedPlayerList[0].firebasePlayerKey).remove();
        _playerDetailsRef.child(fbJoinedPlayerList[1].firebasePlayerKey).remove();

        //createGameRoom(String p1Id, String p1Name, String p1Image, String p2Id, String p2Name, String p2Image)
        createGameRoom(fbJoinedPlayerList[1].userId, fbJoinedPlayerList[1].playerName, fbJoinedPlayerList[1].photo);
      }
    }
  }

  void listeningToFirebaseDataUpdate() {
    playerDetailsSubscription = _playerDetailsRef.limitToFirst(1).onChildAdded.listen((Event event) {
      //print('--------- joinedUserType ${event.snapshot.value['joinedUserType']}');
      //print('--------- ${event.snapshot.key}');

      String playerDetailsKey = event.snapshot.key;
      String category = event.snapshot.value['category'];
      String subCategory = event.snapshot.value['subCategory'];
      String cardCount = event.snapshot.value['cardCount'];
      String gameType = event.snapshot.value['gameType'];
      String firebasePlayerName = event.snapshot.value['playerName'];
      String firebasePlayerId = event.snapshot.value['userId'];
      String firebasePlayerImage = event.snapshot.value['image'];
      String joinedUserType = event.snapshot.value['joinedUserType'];

      if (joinedUserType != 'host' &&
          category == widget.categoryName &&
          subCategory == widget.subcategoryName &&
          gameType == widget.gameType &&
          cardCount == widget.cardsToPlay &&
          !fbJoinedPlayerList.contains(playerDetailsKey)
      ) {
        fbJoinedPlayerList.add(FirebasePlayerDetailsModel(firebasePlayerName, firebasePlayerId, firebasePlayerImage, playerDetailsKey));

        //getting updated firebase list when new player added.
        updateFirebaseJoinedPlayerDetails();
      }
    }, onError: (Object o) {
      final DatabaseError error = o;
      print('Error: ${error.code} ${error.message}');
    });
  }

  void createGameRoom(String p2Id, String p2Name, String p2Image) async{
    if (p2Id.isNotEmpty) {
      String _gameRoomName = 'gr-$p1MemberId-$p2Id';

      _gameRoom.child(_gameRoomName).set({
        'p1Id': p1MemberId,
        'p1Name': p1FullName,
        'p1Image': p1Photo,
        'p2Id': p2Id,
        'p2Name': p2Name,
        'p2Image': p2Image,
        'category': widget.categoryName,
        'subCategory': widget.subcategoryName,
        'gameType': widget.gameType,
        'cardCount': widget.cardsToPlay,
      }).then((_) {
        openGamePlayPage();
      });
    } else {
      funAfterNoPlayerFound();
    }
  }

  void funAfterNoPlayerFound() async{
    Toast.show('Player not found! Please try again.', context, duration: Toast.lengthLong, gravity:  Toast.bottom,
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
      context, CupertinoPageRoute(builder: (context) => HomeScreen(xApiKey: xApiKey, memberId: p1MemberId,),
    ),
    );
  }

  void openGamePlayPage() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) =>
            Gameplay(),
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
