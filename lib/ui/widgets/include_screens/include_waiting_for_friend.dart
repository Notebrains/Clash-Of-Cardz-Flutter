import 'dart:async';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/base_application_fun.dart';
import 'package:clash_of_cardz_flutter/helper/shared_preference_data.dart';
import 'package:clash_of_cardz_flutter/model/arguments/firebase_player_details_model.dart';
import 'package:clash_of_cardz_flutter/ui/screens/pvp.dart';
import 'package:clash_of_cardz_flutter/ui/screens/home.dart';
import 'dart:io' show Platform;

import 'package:clash_of_cardz_flutter/ui/widgets/libraries/flutter_toast.dart';

class IncludeWaitingForFriend extends StatefulWidget {
  final String gameCat1;
  final String gameCat2;
  final String gameCat3;
  final String gameCat4;
  final String gameType;
  final String playerType;
  final String cardsToPlay;
  final String friendId;
  final String friendName;
  final String friendImage;
  final String joinedPlayerType;

  const IncludeWaitingForFriend(
      {Key key,
    this.gameCat1,
    this.gameCat2,
    this.gameCat3,
    this.gameCat4,
    this.gameType,
    this.playerType,
    this.cardsToPlay,
    this.friendId,
    this.friendName,
    this.friendImage,
    this.joinedPlayerType}) : super(key: key);

  @override
  State<StatefulWidget> createState() => IncludeWaitingForFriendState();
}

class IncludeWaitingForFriendState extends State<IncludeWaitingForFriend> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  List <FirebasePlayerDetailsModel> fbJoinedPlayerList = [];

  DatabaseReference _friendDetailsRef;
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

 /* updateState(){
    setState(() {
      retrieveFirebaseData();
    });
  }*/

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
                                        duration: Duration(minutes: 3),
                                        tween: Tween(begin: Duration(minutes: 3), end: Duration.zero),
                                        onEnd: () {
                                          //print('Timer Ended');

                                          //remove first user from firebase if requested player has not joined.
                                          _friendDetailsRef.child(fbJoinedPlayerList[0].firebasePlayerKey).remove();


                                          Toast.show("Player has not joined the match", context, duration: Toast.lengthLong, gravity:  Toast.bottom,
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
    //print('Fb retrieveFirebaseData method called');

    // Demonstrates configuring the database directly
    final FirebaseDatabase database = FirebaseDatabase(app: firebaseApp);
    _friendDetailsRef = database.reference().child('friendDetails');

    //get child items present in fb db.
    fbJoinedPlayerList = [];
    _friendDetailsRef.once().then((onValue) {
      Map playerDetailsList = onValue.value;

      try{
        int joinedPlayerSize = playerDetailsList.length;
        //print('Fb joinedPlayerSize: $joinedPlayerSize');

        // Execute forEach()
        playerDetailsList.forEach((playerDetailsKey, playerDetailsValue) {
          print('Player Details List: { key: $playerDetailsKey, value: $playerDetailsValue}');

          if (playerDetailsValue.containsValue(memberId) || playerDetailsValue.containsValue(widget.friendId)) {

            //print('Fb  Fb data filter list: ');

            fbJoinedPlayerList.add(FirebasePlayerDetailsModel(playerDetailsValue['playerName'], playerDetailsValue['userId'], playerDetailsValue['image'], playerDetailsKey));

            print('Fb fbJoinedPlayerList size 1: ${fbJoinedPlayerList.length}');
            if(widget.joinedPlayerType == 'joinedAsFriend' && fbJoinedPlayerList.length == 0){
              Toast.show('Your friend left the match', context, duration: Toast.lengthLong, gravity:  Toast.bottom, backgroundColor: Colors.white);

              Navigator.of(context).pop();
            }
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


  Future<void> updateFirebaseJoinedPlayerDetails() async {
    print('Fb fbJoinedPlayerList size 2: ${fbJoinedPlayerList.length} join type: ${widget.joinedPlayerType}');
    //if player is already looking for player then take 1 player and remove that player else join as host
    if (fbJoinedPlayerList.length == 0 && widget.joinedPlayerType == 'joinedAsPlayer') {
      print('Fb push player called');

      _friendDetailsRef.push().set(<String, String>{
        //count: ${transactionResult.dataSnapshot.value}
        'playerName': fullName,
        'image': photo,
        'userId': memberId,
        'joinedUserType': widget.joinedPlayerType,
        'gameCat1': widget.gameCat1,
        'gameCat2': widget.gameCat2,
        'gameCat3': widget.gameCat3,
        'gameCat4': widget.gameCat4,
        'playerType': widget.playerType,
        'gameType': widget.gameType,
        'cardCount': widget.cardsToPlay,
      });

    } else if(fbJoinedPlayerList.length == 1 && widget.joinedPlayerType == 'joinedAsFriend'){

      print('Fb push friend called');
      _friendDetailsRef.push().set(<String, String>{
        'playerName': widget.friendName,
        'image': widget.friendImage,
        'userId': widget.friendId,
        'joinedUserType': widget.joinedPlayerType,
        'gameCat1': widget.gameCat1,
        'gameCat2': widget.gameCat2,
        'gameCat3': widget.gameCat3,
        'gameCat4': widget.gameCat4,
        'playerType': widget.playerType,
        'gameType': widget.gameType,
        'cardCount': widget.cardsToPlay,
      });

    } else if(fbJoinedPlayerList.length == 2) {
      //removing both players when they matched and start the match
      _friendDetailsRef.child(fbJoinedPlayerList[0].firebasePlayerKey).remove();
      _friendDetailsRef.child(fbJoinedPlayerList[1].firebasePlayerKey).remove();

      //start the game
      openGamePlayPage(fbJoinedPlayerList[1].playerName ,fbJoinedPlayerList[1].userId ,fbJoinedPlayerList[1].photo);
    }
  }

  void listeningToFirebaseDataUpdate() {
    //getting joinedPlayerCount when it changed
    final FirebaseDatabase database = FirebaseDatabase(app: firebaseApp);

    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);

    playerDetailsSubscription = _friendDetailsRef.limitToFirst(1).onChildAdded.listen((Event event) {
      print('Fb Child added: ${event.snapshot.value}');

      //getting updated firebase list when new player added.
      retrieveFirebaseData();

    }, onError: (Object o) {
      final DatabaseError error = o;
      print('Error: ${error.code} ${error.message}');
    });
  }

  void openGamePlayPage(String player2Name, player2Id, player2Image) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) =>
            Pvp(xApiKey: xApiKey, p1Name: fullName, p1Id: memberId, p1Image: photo, p2Name: player2Name, p2Id: player2Id, p2Image: player2Image,
              gameCat1: widget.gameCat1,
              gameCat2: widget.gameCat2,
              gameCat3: widget.gameCat3,
              gameCat4: widget.gameCat4,
              playerType: widget.playerType,
              gameType: widget.gameType,
              cardsToPlay: widget.cardsToPlay,)
      ),
    ).then((value) => Navigator.of(context).pop());
  }

  @override
  void dispose() {
    super.dispose();
    playerDetailsSubscription.cancel();
  }

}
