import 'dart:async';
import 'dart:convert';
import 'package:clash_of_cardz_flutter/ui/styles/size_config.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/include_screens/include_searching_for_friend.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/gapless_audio_loop.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/shimmer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/base_application_fun.dart';
import 'package:clash_of_cardz_flutter/helper/globals.dart';
import 'package:clash_of_cardz_flutter/helper/shared_preference_data.dart';
import 'package:clash_of_cardz_flutter/ui/screens/login.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/horizontal_progress_indicator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../main.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver {
  final splashDelay = 6;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin fltNotification;

  @override
  void initState() {
    super.initState();
    notificationPermission();
    initMessaging();
    setScreenOrientationToLandscape();
    _loadWidget();

    initUserInteractionOnNotification();

    SharedPreferenceHelper().getMusicOnOffState().then((isMusicOn) {
      if (isMusicOn) {
        playMusic();
      }
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void getToken() async {
    print(await messaging.getToken());
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    SharedPreferenceHelper().getUserSavedData().then((sharedPrefUserProfileModel) {
      String xApiKey = sharedPrefUserProfileModel.xApiKey ?? 'NA';
      String memberId = sharedPrefUserProfileModel.memberId ?? 'NA';

      if (xApiKey != 'NA' && memberId != 'NA') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>Home(
              xApiKey: xApiKey,
              memberId: memberId,
            ),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => LogIn(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/bg_img3.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Shimmer.fromColors(
                baseColor: Color(0xFF364B5A),
                highlightColor: Colors.cyanAccent[400],
                child: Text(
                  'CLASH OF CARDZ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 60.0,
                    fontFamily: 'Rapier',
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ),
            ),
            Container(
              width: SizeConfig.widthMultiplier * 180,
              height: 20,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                child: HorizontalProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void playMusic() async {
    try {
      final playerInstance = GaplessAudioLoop();
      await playerInstance.loadAsset('audios/Sorry.mp3');
      await playerInstance.play();

      Globals.setAudioPlayerInstance(playerInstance);
    } catch (e) {
      print(e);
    }
  }

  void initMessaging() async {
    var androidInit = AndroidInitializationSettings('ic_notification');
    var iosInit = IOSInitializationSettings();
    var initSetting = InitializationSettings(android: androidInit, iOS: iosInit);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'coc_channel_id', // id
      'Clash Of Cardz', // title
      'This notification is from  Clash Of Cardz', // description
      importance: Importance.max,
    );

    fltNotification = FlutterLocalNotificationsPlugin();
    await fltNotification
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    fltNotification.initialize(initSetting);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      //Show local notification when app in foreground and message is received.
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        print('Message also contained a notification: ${message.data}');
        fltNotification.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: android?.smallIcon,
                // other properties...
              ),
              iOS: IOSNotificationDetails(),
            ),
            payload: message.data['game_data'] ?? '');

        fltNotification.initialize(initSetting, onSelectNotification: onSelectNotification);
      }
    });
  }

  Future onSelectNotification(String payload) async {
    if (payload != null && payload.isNotEmpty) {
      print('----payload: $payload');
      openPageWithData(payload);
    }
  }

  void notificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await messaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  void initUserInteractionOnNotification() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen

    //print('----Firebase notification data onClicked 1: ${initialMessage.data}');
    //print('----Firebase notification contentAvailable onClicked 1: ${initialMessage.contentAvailable}');

    if (initialMessage != null && initialMessage.data['game_data'] != null) {
      print('----Firebase notification data onClicked 1: ${initialMessage.data}');
      openPageWithData(initialMessage.data['game_data']);
    } else {
      _loadWidget();
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('----Firebase notification data onClicked 2: ${message.data}');
      if (message != null && message.data['game_data'] != null) {
        openPageWithData(message.data['game_data']);
      } else {
        _loadWidget();
      }
    });
  }

  void openPageWithData(String payload) {
    try {
      // get data from payload and navigate to screen
      var gameNotiData = json.decode(payload);
      print('-----openPageWithData: $gameNotiData');
      /*
      output
      {gameType: test, friendName: Imdadul, gameCat4: 1991-2000, friendId: MEM000033, playerType: bowler, friendImage:
      https://lh3.googleusercontent.com/a-/AOh14GhhY4WoN2ln1gzcQE_QSQ3tOtyjWCk3oHEniCp4=s96-c, gameCat1: sports, gameCat2: cricket,
       gameCat3: IPL, cardsToPlay: 120}
       */

      print('----- ${gameNotiData['gameCat1']}');
      //output  ----- sports
      MyRootApp.navigatorKey.currentState.push(
          MaterialPageRoute(builder: (_) => IncludeSearchingForFriend(
            gameCat1: gameNotiData['gameCat1'],
            gameCat2: gameNotiData['gameCat2'],
            gameCat3: gameNotiData['gameCat3'],
            gameCat4: gameNotiData['gameCat4'],
            gameType: 'vs Friends',
            playerType: gameNotiData['playerType'],
            cardsToPlay: gameNotiData['cardsToPlay'],
            xApiKey: '56005600',
            p1FullName: gameNotiData['friendName'],
            p1MemberId: gameNotiData['friendId'],
            p1Photo: gameNotiData['friendImage'],
          ),),
      );
    } catch (e) {
      print(e);
    }
  }
}

/*
Message data: {game_data: {"gameType":"test","friendName":"Imdadul","gameCat4":"1991-2000","friendId":"MEM000033",
"playerType":"bowler","friendImage":"https:\/\/lh3.googleusercontent.com\/a-\/AOh14GhhY4WoN2ln1gzcQE_QSQ3tOtyjWCk3oHEniCp4=s96-c",
"gameCat1":"sports","gameCat2":"cricket","gameCat3":"IPL","cardsToPlay":"120"}, click_action: FLUTTER_NOTIFICATION_CLICK}
*/
