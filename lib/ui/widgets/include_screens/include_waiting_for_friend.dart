import 'dart:async';
import 'dart:ui';
import 'package:clash_of_cardz_flutter/bloc/api_bloc.dart';
import 'package:clash_of_cardz_flutter/model/responses/send_notification_to_friend_res_model.dart';
import 'package:clash_of_cardz_flutter/ui/styles/size_config.dart';
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

  List <FirebasePlayerDetailsModel> fbJoinedPlayerList = [];
  DatabaseReference _dbRefFriendDetails;
  StreamSubscription <Event> firebaseFriendDetailsUpdate;

  var xApiKey = '';
  var fullName = '';
  var memberId = '';
  var points = '';
  var photo = '';
  bool isGamePlayPageOpened = false;

  @override
  void initState() {
    super.initState();

    // Demonstrates configuring the database directly
    final databaseReference = FirebaseDatabase.instance.reference();
    _dbRefFriendDetails = databaseReference.child('friendDetails');

    firebaseFriendDetailsUpdate = _dbRefFriendDetails.limitToLast(1).onChildAdded.listen((data) {
      //print('----Fb new child added key: ${data.snapshot.key}');
      //print('----Fb new child added value: ${data.snapshot.value}');
      print('----Fb new child added value playerName: ${data.snapshot.value['playerName']}');

      retrieveFirebaseData();
    } );

    SharedPreferenceHelper().getUserSavedData().then((sharedPrefUserProfileModel) => {
      print('Pref member id: ${sharedPrefUserProfileModel.memberId}'),
      xApiKey = sharedPrefUserProfileModel.xApiKey ?? '',
      fullName = sharedPrefUserProfileModel.fullName ?? '',
      memberId = sharedPrefUserProfileModel.memberId ?? '',
      photo = sharedPrefUserProfileModel.photo ?? '',
      points = sharedPrefUserProfileModel.points ?? '0',
    });

    print('Fb retrieveFirebaseData method called 1');
    retrieveFirebaseData();
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
        child: Stack(
          children: <Widget>[
            Container(
              decoration:  BoxDecoration(
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
              child:  ClipRect(
                child:  BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black45),
                    child:  Center(
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        padding: EdgeInsets.all(5.0),
                        height: MediaQuery.of(context).size.height,
                        decoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))),
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

                            TweenAnimationBuilder<Duration>(
                                duration: Duration(minutes: 3),
                                tween: Tween(end: Duration(minutes: 3), begin: Duration.zero),
                                onEnd: () {
                                  Toast.show("Player has not accepted the challenge", context, duration: Toast.lengthLong,
                                      gravity:  Toast.bottom,
                                      backgroundColor: Colors.black26,
                                      textStyle:  TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20,
                                        shadows: [
                                          Shadow(color: Colors.white),
                                        ],
                                      ));

                                  //remove first user from firebase if requested player has not joined.
                                  _dbRefFriendDetails.child(fbJoinedPlayerList[0].firebasePlayerKey).remove();

                                  Navigator.pop(context);
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
                                        fontSize: 33,
                                        shadows: [
                                          Shadow(color: Colors.white),
                                        ],
                                      ),
                                    ),
                                  );
                                }),

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: Text(
                                  'Waiting for your friend to accept the challenge',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24, fontFamily: 'montserrat', fontWeight: FontWeight.normal),
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
    );
  }

  void retrieveFirebaseData() {
    print('Fb retrieveFirebaseData method called 2');

    //get child items present in fb db.
    fbJoinedPlayerList = [];
    _dbRefFriendDetails.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
      Map playerDetailsList = snapshot.value;
      try{
        //int joinedPlayerSize = playerDetailsList.length;
        //print('Fb joinedPlayerSize: $joinedPlayerSize');

        if ( playerDetailsList != null) {
          // Execute forEach()
          playerDetailsList.forEach((playerDetailsKey, playerDetailsValue) {
            print('----Player Details List: { key: $playerDetailsKey, value: $playerDetailsValue}');

            if (playerDetailsValue.containsValue(memberId) || playerDetailsValue.containsValue(widget.friendId)) {
              print('----playerDetailsValue: ${playerDetailsValue['playerName']}');
              fbJoinedPlayerList.add(
                FirebasePlayerDetailsModel(
                  playerDetailsValue['playerName'],
                  playerDetailsValue['userId'],
                  playerDetailsValue['image'],
                  playerDetailsKey,
                ),
              );

              print('Fb fbJoinedPlayerList size 1: ${fbJoinedPlayerList.length}');
              if(widget.joinedPlayerType == 'joinedAsFriend' && fbJoinedPlayerList.length == 0){
                Toast.show('Your friend left the match',
                    context, duration: Toast.lengthLong, gravity:
                    Toast.bottom, backgroundColor: Colors.white);

                Navigator.of(context).pop();
              }
            }
          });
        }

        // After getting player list from fb, updating fb and start playing
        updateFirebaseJoinedPlayerDetails();

      } catch(e){
        print(e);
        // After getting player list from fb, updating fb and start playing
        updateFirebaseJoinedPlayerDetails();
      }
    });
  }


  void updateFirebaseJoinedPlayerDetails()  {
    print('Fb updateFirebaseJoinedPlayerDetails method called');
    print('Fb fbJoinedPlayerList size 2: ${fbJoinedPlayerList.length} join type: ${widget.joinedPlayerType}');
    //if player is already looking for player then take 1 player and remove that player else join as host
    if (fbJoinedPlayerList.length == 0 && widget.joinedPlayerType == 'joinedAsPlayer') {
      print('Fb push player called 1 ');

      _dbRefFriendDetails.push().set(<String, String>{
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
      print('Fb push friend called 2 : ${widget.friendId}');
      _dbRefFriendDetails.push().set(<String, String>{
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

    } else if(fbJoinedPlayerList.length == 2) {
      print('Fb push friend called 3');

      //removing both players when they matched and start the match
      print('-----fbJoinedPlayerList[0].playerName: ${fbJoinedPlayerList[0].firebasePlayerKey}');
      print('-----fbJoinedPlayerList[1].playerName: ${fbJoinedPlayerList[1].firebasePlayerKey}');

      _dbRefFriendDetails.child(fbJoinedPlayerList[0].firebasePlayerKey).remove();
      _dbRefFriendDetails.child(fbJoinedPlayerList[1].firebasePlayerKey).remove();

      // start the game
      openGamePlayPage(fbJoinedPlayerList[0].playerName ,fbJoinedPlayerList[0].userId ,fbJoinedPlayerList[0].photo,
          fbJoinedPlayerList[1].playerName ,fbJoinedPlayerList[1].userId ,fbJoinedPlayerList[1].photo);
    }
  }

  void openGamePlayPage(String player1Name, player1Id, player1Image, String player2Name, player2Id, player2Image,) {
    print('Fb openGamePlayPage method called');
    print('Fb p1 name 1: $player1Name');
    print('Fb p2 name 1: $player2Name');

    if (!isGamePlayPageOpened && player1Id != player2Id) {
      isGamePlayPageOpened = true;
      print('Fb isGamePlayPageOpened called: $isGamePlayPageOpened');
      print('Fb p1 name 2: $player1Name - $player1Id');
      print('Fb p2 name 2: $player2Name - $player2Id');
      Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) =>
                Pvp(xApiKey: xApiKey,
                  p1Name: player1Name,
                  p1Id: player1Id,
                  p1Image: player1Image,
                  p2Name: player2Name,
                  p2Id: player2Id,
                  p2Image: player2Image,
                  gameCat1: widget.gameCat1,
                  gameCat2: widget.gameCat2,
                  gameCat3: widget.gameCat3,
                  gameCat4: widget.gameCat4,
                  playerType: widget.playerType,
                  gameType: widget.gameType,
                  cardsToPlay: widget.cardsToPlay,
                )
        ),
      );
    } else if (player1Id == player2Id) {
      Toast.show("Player not found. Please try again.", context, duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.black26,
          textStyle:  TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 18,
            shadows: [Shadow(color: Colors.white),],
          ));
    }
  }

  @override
  void dispose() {
    firebaseFriendDetailsUpdate.cancel();
    super.dispose();
  }
}
