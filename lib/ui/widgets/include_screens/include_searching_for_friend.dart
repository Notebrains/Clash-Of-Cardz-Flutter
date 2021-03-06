import 'dart:async';
import 'dart:ui';
import 'package:clash_of_cardz_flutter/ui/styles/size_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:clash_of_cardz_flutter/helper/constantvalues/constants.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/base_application_fun.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/common_fun.dart';
import 'package:clash_of_cardz_flutter/helper/shared_preference_data.dart';
import 'package:clash_of_cardz_flutter/model/arguments/firebase_player_details_model.dart';
import 'package:clash_of_cardz_flutter/ui/screens/gameplay.dart';
import 'package:clash_of_cardz_flutter/ui/screens/home.dart';
import 'package:clash_of_cardz_flutter/ui/screens/pvp.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/loading_sports_frosted_glass.dart';
import 'dart:io' show Platform;

import 'package:clash_of_cardz_flutter/ui/widgets/libraries/flutter_toast.dart';

class IncludeSearchingForFriend extends StatefulWidget {
  final String gameCat1;
  final String gameCat2;
  final String gameCat3;
  final String gameCat4;
  final String playerType;
  final String gameType;
  final String cardsToPlay;
  final String xApiKey;
  final String p1FullName;
  final String p1MemberId;
  final String p1Photo;

  const IncludeSearchingForFriend({Key key,
    this.gameCat1,
    this.gameCat2,
    this.gameCat3,
    this.gameCat4,
    this.playerType,
    this.gameType,
    this.cardsToPlay,
    this.xApiKey,
    this.p1FullName,
    this.p1MemberId,
    this.p1Photo}) : super(key: key);

  @override
  State<StatefulWidget> createState() => IncludeSearchingForPlayerState();
}

class IncludeSearchingForPlayerState extends State<IncludeSearchingForFriend> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  List <FirebasePlayerDetailsModel> fbJoinedPlayerList = [];

  DatabaseReference _playerDetailsRef;
  DatabaseReference _gameRoom;
  StreamSubscription<Event> _gameRoomSubscription;
  StreamSubscription<Event> playerDetailsSubscription;
  DatabaseError _error;
  FirebaseApp firebaseApp;

  bool isHost = false;
  String _gameRoomName = 'gr';

  @override
  void initState() {
    super.initState();

    initFirebaseCredentials();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();

    //retrieveFirebaseData();

    updateFirebaseJoinedPlayerDetails();

    listeningToFirebaseDataUpdate();

    listeningToGameRoomUpdateInFirebase();
  }

  @override
  Widget build(BuildContext context) {
    //print('----game cats searching player 1: ${widget.gameCat1} , ${widget.gameCat2} , ${widget.gameCat3}, ${widget.gameCat4},'
        //' ${widget.gameType}, ${widget.playerType}, ${widget.cardsToPlay}');
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg_img3.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              ConstrainedBox(
                constraints: const BoxConstraints.expand(),
              ),
              Center(
                child: new ClipRect(
                  child: new BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      color: Colors.black45,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: 30,
                              height: 30,
                              margin: EdgeInsets.only(top: 12, right: 12),
                              child: FloatingActionButton(
                                mini: true,
                                tooltip: 'close',
                                elevation: 0,
                                backgroundColor: Colors.transparent,
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  funAfterNoPlayerFound();
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),

                          Lottie.asset(
                            'assets/animations/lottiefiles/sports-loading.json',
                            height: SizeConfig.heightMultiplier * 25,
                            width: SizeConfig.heightMultiplier * 25,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TweenAnimationBuilder<Duration>(
                                  duration: Duration(minutes: 10),
                                  tween: Tween(begin: Duration.zero, end: Duration(minutes: 10), ),
                                  onEnd: () {
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

                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Text(
                                'Waiting for your friend to accept the challenge',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24, fontFamily: 'montserrat', fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
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

  void initFirebaseCredentials() async{

    // Demonstrates configuring the database directly
    //var firebaseInstance = FirebaseDatabase.instance;
    final FirebaseDatabase database = FirebaseDatabase(app: firebaseApp);
    _playerDetailsRef = database.reference().child('friendDetails');
    _gameRoom = database.reference().child('gameRoom');
  }

  void retrieveFirebaseData() {
    // Demonstrates configuring the database directly
    //var firebaseInstance = FirebaseDatabase.instance;
    final FirebaseDatabase database = FirebaseDatabase(app: firebaseApp);
    _playerDetailsRef = database.reference().child('friendDetails');
    _gameRoom = database.reference().child('gameRoom');


    //get child items present in fb db.
    fbJoinedPlayerList.clear();
    _playerDetailsRef.once().then((onValue) {
      try{
        Map playerDetailsList = onValue.value;
        // Execute forEach()
        playerDetailsList.forEach((playerDetailsKey, playerDetailsValue) {
          //print('Player Details List: { key: $playerDetailsKey, value: $playerDetailsValue}');
          //print('Fb ***: ${playerDetailsValue['userId']}');

          if (playerDetailsValue.containsValue(widget.gameCat1) &&
              playerDetailsValue.containsValue(widget.gameCat2) &&
              playerDetailsValue.containsValue(widget.gameCat3) &&
              playerDetailsValue.containsValue(widget.gameCat4) &&
              playerDetailsValue.containsValue(widget.playerType) &&
              playerDetailsValue.containsValue(widget.gameType) &&
              playerDetailsValue.containsValue(widget.cardsToPlay) &&
              !fbJoinedPlayerList.contains(playerDetailsValue['userId'])) {
            //print('---- Fb data filter list: ${widget.categoryName}, ${widget.subcategoryName}, ${widget.gameType}, ${widget.cardsToPlay}');

            fbJoinedPlayerList.add(FirebasePlayerDetailsModel(playerDetailsValue['playerName'], playerDetailsValue['userId'], playerDetailsValue['image'], playerDetailsKey));
          }
        });
        // After getting player list from fb, updating fb and start playing
        updateFirebaseJoinedPlayerDetails();

      } catch(e){
        //Caught exception At first when there is no player present. Then adding new player as host
        updateFirebaseJoinedPlayerDetails();
      }
    });
  }

  void updateFirebaseJoinedPlayerDetails() {
    //below method is called only for testing
    //createGameRoom('MEM000001', 'Sam', Constants.imgUrlTest);

    //print('Fb fb Joined Player List size: ${fbJoinedPlayerList.length}');
    if(fbJoinedPlayerList.length == 0){
      _playerDetailsRef.push().set(<String, String>{
        //count: ${transactionResult.dataSnapshot.value}
        'playerName': widget.p1FullName,
        'image': widget.p1Photo,
        'userId': widget.p1MemberId,
        'joinedUserType': 'host',
        'gameCat1': widget.gameCat1,
        'gameCat2': widget.gameCat2,
        'gameCat3': widget.gameCat3,
        'gameCat4': widget.gameCat4,
        'playerType': widget.playerType,
        'gameType': widget.gameType,
        'cardCount': widget.cardsToPlay,
      });
    } else if (fbJoinedPlayerList.length > 1) {
      //if no player then joined as host and wait for player to join the match. Else take first player and start the match

      //checking if user is same or different. Because both member id will be same if the user req for match for 2 times
      // create if p1 is first to join else wait for the second player
      if (widget.p1MemberId == fbJoinedPlayerList[0].userId) {
        //createGameRoom(String p1Id, String p1Name, String p1Image, String p2Id, String p2Name, String p2Image)
        createGameRoom(fbJoinedPlayerList[1].userId, fbJoinedPlayerList[1].playerName, fbJoinedPlayerList[1].photo);

        //removing both players when they matched and start the match
        _playerDetailsRef.child(fbJoinedPlayerList[0].firebasePlayerKey).remove();
        _playerDetailsRef.child(fbJoinedPlayerList[1].firebasePlayerKey).remove();
      }
    }
  }

  void listeningToFirebaseDataUpdate() {
    playerDetailsSubscription = _playerDetailsRef.limitToFirst(1).onChildAdded.listen((Event event) {
      //print('--------- joinedUserType ${event.snapshot.value['joinedUserType']}');
      //print('-----onChildAdded:  ${event.snapshot.key}');

      String playerDetailsKey = event.snapshot.key;
      String gameCat1 = event.snapshot.value['gameCat1'];
      String gameCat2 = event.snapshot.value['gameCat2'];
      String gameCat3 = event.snapshot.value['gameCat3'];
      String gameCat4 = event.snapshot.value['gameCat4'];
      String playerType = event.snapshot.value['playerType'];
      String cardCount = event.snapshot.value['cardCount'];
      String gameType = event.snapshot.value['gameType'];
      String firebasePlayerName = event.snapshot.value['playerName'];
      String firebasePlayerId = event.snapshot.value['userId'];
      String firebasePlayerImage = event.snapshot.value['image'];
      String joinedUserType = event.snapshot.value['joinedUserType'];

      if (gameCat1 == widget.gameCat1 &&
          gameCat2 == widget.gameCat2 &&
          gameCat3 == widget.gameCat3 &&
          gameCat4 == widget.gameCat4 &&
          playerType == widget.playerType &&
          gameType == widget.gameType &&
          cardCount == widget.cardsToPlay &&
          !fbJoinedPlayerList.contains(firebasePlayerId)
      ) {
        //print('-----new player added $firebasePlayerId');
        if (fbJoinedPlayerList.length == 0) {
          fbJoinedPlayerList.add(FirebasePlayerDetailsModel(firebasePlayerName, firebasePlayerId, firebasePlayerImage, playerDetailsKey));
        } else if(firebasePlayerId != widget.p1MemberId){
          fbJoinedPlayerList.add(FirebasePlayerDetailsModel(firebasePlayerName, firebasePlayerId, firebasePlayerImage, playerDetailsKey));
        }

        //getting updated firebase list when new player added.
        updateFirebaseJoinedPlayerDetails();
      }
    }, onError: (Object o) {
      final DatabaseError error = o;
      print('Error: ${error.code} ${error.message}');
    });
  }

  void createGameRoom(String p2Id, String p2Name, String p2Image) async{
    //print('-----p2id: $p2Id');
    if (p2Id.isNotEmpty) {
      _gameRoomName = 'gr-${widget.p1MemberId}-$p2Id';

      _gameRoom.child(_gameRoomName).set({
        'p1Id': widget.p1MemberId,
        'p1Name': widget.p1FullName,
        'p1Image': widget.p1Photo,
        'p2Id': p2Id,
        'p2Name': p2Name,
        'p2Image': p2Image,
        'gameCat1': widget.gameCat1,
        'gameCat2': widget.gameCat2,
        'gameCat3': widget.gameCat3,
        'gameCat4': widget.gameCat4,
        'playerType': widget.playerType,
        'gameType': widget.gameType,
        'cardCount': widget.cardsToPlay,
      }).then((_) {
      });
    } else {
      funAfterNoPlayerFound();
    }
  }

  void listeningToGameRoomUpdateInFirebase() {
    _gameRoomSubscription = _gameRoom.limitToFirst(10).onChildAdded.listen((Event event) {
      //print('--------- joinedUserType ${event.snapshot.value['joinedUserType']}');
      //print('-----game room added:  ${event.snapshot.key}');
      String gameRoomKey = event.snapshot.key;
      if (gameRoomKey.contains(widget.p1MemberId)) {
        openGamePlayPage(
          event.snapshot.value['p1Name'],
          event.snapshot.value['p1Id'],
          event.snapshot.value['p1Image'],
          event.snapshot.value['p2Name'],
          event.snapshot.value['p2Id'],
          event.snapshot.value['p2Image'],
          event.snapshot.value['gameCat1'],
          event.snapshot.value['gameCat2'],
          event.snapshot.value['gameCat3'],
          event.snapshot.value['gameCat4'],
          event.snapshot.value['playerType'],
          event.snapshot.value['gameType'],
          event.snapshot.value['cardCount'],
        );

        print('--------- joinedUserType ${event.snapshot.value['p1Id']}');
      }
    }, onError: (Object o) {
      final DatabaseError error = o;
      //print('Error: ${error.code} ${error.message}');
    });
  }


  void funAfterNoPlayerFound() async{
    if (context != null) {
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => Home(xApiKey: widget.xApiKey, memberId: widget.p1MemberId,),),
      ).then((value) => {
        showToast(context, 'Player not found! Please try again.'),
        //remove first user from firebase if requested player has not joined.
        _playerDetailsRef.child(fbJoinedPlayerList[0].firebasePlayerKey).remove(),
        Navigator.of(context).pop(),
      });
    }
  }

  void openGamePlayPage(String p1Name, String p1Id, String p1Img, String p2Name, String p2Id, String p2Img, String gameCat1, String gameCat2,
      String gameCat3, String gameCat4, String playerType, String gameType, String cardsToPlay) {
    //print('----game cats searching player 2: ${widget.gameCat1} , ${widget.gameCat2} , ${widget.gameCat3}, ${widget.gameCat4}');

    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => Pvp(xApiKey: widget.xApiKey, p1Name: p1Name, p1Id: p1Id, p1Image: p1Img, p2Name: p2Name, p2Id: p2Id, p2Image: p2Img,
        gameCat1: gameCat1, gameCat2: gameCat2, gameCat3: gameCat3, gameCat4: gameCat4, playerType: playerType, gameType: gameType, cardsToPlay: cardsToPlay,),),
    ).then((value) => Navigator.of(context, rootNavigator: true).pop());
  }

  @override
  void dispose() {
    super.dispose();
    playerDetailsSubscription.cancel();
    _gameRoomSubscription.cancel();
  }

}
