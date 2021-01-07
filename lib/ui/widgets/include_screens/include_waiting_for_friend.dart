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
  DatabaseReference _playerDetailsRef;
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
                            children: <Widget>[
                              Lottie.asset(
                                'assets/animations/lottiefiles/sports-loading.json',
                                width: getScreenWidth(context),
                                height: getScreenHeight(context) * 0.7,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'Waiting for your friend\n to accept the request',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24, fontFamily: 'neuropol_x_rg', fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),

                              //Navigator.of(context).push(new PageRouteWithAnimation());

                              /* Center(
                                  child: Container(
                                    //padding: const EdgeInsets.only(top: 12.0),
                                    child: Text(
                                      "No Player Found! Please Try Again.",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'neuropol_x_rg',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );*/
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

    /*WidgetsFlutterBinding.ensureInitialized();
    firebaseApp = await Firebase.initializeApp(
      name: 'clash_of_cardz_db',

      */ /*options: Platform.isIOS || Platform.isMacOS
        ? FirebaseOptions(
      appId: '1:297855924061:ios:c6de2b69b03a5be8',
      apiKey: 'AIzaSyD_shO5mfO9lhy2TVWhfo1VUmARKlG4suk',
      projectId: 'flutter-firebase-plugins',
      messagingSenderId: '297855924061',
      databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
    )
        : FirebaseOptions(
      appId: '1:297855924061:android:669871c998cc21bd',
      apiKey: 'AIzaSyD_shO5mfO9lhy2TVWhfo1VUmARKlG4suk',
      messagingSenderId: '297855924061',
      projectId: 'flutter-firebase-plugins',
      databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
    ),*/ /*


      options: Platform.isIOS || Platform.isMacOS
          ? FirebaseOptions(
        appId: '1:297855924061:android:669871c998cc21bd',
        apiKey: 'AIzaSyD6zszZnzOapjcJhFKtiRsiXdgIZXHwN9U',
        messagingSenderId: '679219523500',
        projectId: 'trump-card-43a2b',
        databaseURL: 'https://trump-card-43a2b.firebaseio.com/',
      )
          : FirebaseOptions(
        appId: '1:297855924061:android:669871c998cc21bd',
        apiKey: 'AIzaSyD6zszZnzOapjcJhFKtiRsiXdgIZXHwN9U',
        messagingSenderId: '679219523500',
        projectId: 'trump-card-43a2b',
        databaseURL: 'https://trump-card-43a2b.firebaseio.com/',
      ),
    );*/
  }

  void retrieveFirebaseData() {
    // Demonstrates configuring the database directly
    final FirebaseDatabase database = FirebaseDatabase(app: firebaseApp);
    _playerDetailsRef = database.reference().child('friendDetails');

    //get child items present in fb db.
    fbJoinedPlayerList = [];
    _playerDetailsRef.once().then((onValue) {
      Map playerDetailsList = onValue.value;
      joinedPlayerSize = playerDetailsList.length;

      print('----joinedPlayerSize: $joinedPlayerSize');

      // Execute forEach()
      playerDetailsList.forEach((playerDetailsKey, playerDetailsValue) {
        print('Player Details List: { key: $playerDetailsKey, value: $playerDetailsValue}');

        Map playerDataInPlayerDetailsList = playerDetailsValue;

        if (playerDataInPlayerDetailsList.containsValue('joinedAsPlayer') || playerDataInPlayerDetailsList.containsValue('joinedAsFriend')) {

          print('---- Fb data filter list: ${widget.categoryName}, ${widget.subcategoryName}, ${widget.gameType}, ${widget.cardsToPlay}');

          FirebasePlayerDetailsModel model = FirebasePlayerDetailsModel();

          _playerDetailsRef.child('playerName').once().then((DataSnapshot snapshot) {
            model.playerName = snapshot.value;
          });


          _playerDetailsRef.child('userId').once().then((DataSnapshot snapshot) {
            model.userId = snapshot.value;
          });


          _playerDetailsRef.child('image').once().then((DataSnapshot snapshot) {
            model.photo = snapshot.value;
          });

          if(widget.joinedPlayerType == 'joinedAsFriend' && fbJoinedPlayerList.length == 0){
            showSnackBar(context, 'Your friend left the match');
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
    //if player is already looking for player then take 1 player and remove that player else join as host
    if (joinedPlayerSize < 2) {
      widget.joinedPlayerType == 'joinedAsPlayer' ?
      _playerDetailsRef.push().set(<String, String>{
        //count: ${transactionResult.dataSnapshot.value}
        'playerName': fullName,
        'image': photo,
        'userId': memberId,
        'joinedUserType': widget.joinedPlayerType,
        'category': widget.categoryName,
        'subCategory': widget.subcategoryName,
        'gameType': widget.gameType,
        'cardCount': widget.cardsToPlay,
      }) :
    _playerDetailsRef.push().set(<String, String>{
    //count: ${transactionResult.dataSnapshot.value}
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
        _playerDetailsRef.equalTo(fbJoinedPlayerList[0].playerName).once().then((DataSnapshot snapshot) {
          Map<dynamic, dynamic> children = snapshot.value;
          children.forEach((key, value) {
            _playerDetailsRef.child(key).remove();
          });
        });

        _playerDetailsRef.equalTo(fbJoinedPlayerList[1].playerName).once().then((DataSnapshot snapshot) {
          Map<dynamic, dynamic> children = snapshot.value;
          children.forEach((key, value) {
            _playerDetailsRef.child(key).remove();
          });
        });

        //start the game
        openGamePlayPage(fbJoinedPlayerList[1].playerName ,fbJoinedPlayerList[1].userId ,fbJoinedPlayerList[1].photo);
      } else {
        Timer(Duration(minutes: 1), () {
          showSnackBar(context, 'Your friend did not\n accept the invitation!');

          Navigator.push(
            context, CupertinoPageRoute(builder: (context) => HomeScreen(),
            ),
          );
        });
      }
    }
  }

  void listeningToFirebaseDataUpdate() {

    //getting joinedPlayerCount when it changed

    final FirebaseDatabase database = FirebaseDatabase(app: firebaseApp);

    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);

    playerDetailsSubscription = _playerDetailsRef.limitToFirst(1).onChildAdded.listen((Event event) {
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

  showSnackBar( BuildContext context, String message){
    final snackBar = SnackBar(
      content: Text(message),
    );

    // Find the Scaffold in the widget tree and use
    // it to show a SnackBar.
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
