import 'dart:async';
import 'dart:io';

import 'package:clash_of_cardz_flutter/ui/styles/size_config.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/gapless_audio_loop.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/base_application_fun.dart';
import 'package:clash_of_cardz_flutter/helper/globals.dart';
import 'package:clash_of_cardz_flutter/helper/shared_preference_data.dart';
import 'package:clash_of_cardz_flutter/ui/screens/login.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/horizontal_progress_indicator.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/animated_text_kit/animated_text_kit.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'home.dart';


class SplashScreen extends StatefulWidget {
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black,
  );

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver{
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

      if(xApiKey != 'NA' && memberId != 'NA'){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) =>
            Home(xApiKey: xApiKey, memberId: memberId,),),);
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LogIn()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/bg_img3.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            child: ColorizeAnimatedTextKit(
                              onTap: () {
                                //print("Tap Event");
                              },
                              text: [
                                "\nCLASH OF CARDZ",
                                //"LET'S PLAY",
                                //"CLASH OF CARDZ",
                                //"ROCK & ROLL",
                              ],
                              textStyle: TextStyle(
                                  fontSize: 60.0,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Rapier'),
                              colors: [
                                Color(0xFF364B5A),
                                Colors.blueAccent,
                                Colors.cyanAccent[400],
                              ],
                              textAlign: TextAlign.center,
                              alignment: AlignmentDirectional.center,
                              // or Alignment.topLeft
                              isRepeatingAnimation: true,
                              repeatForever: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      width: SizeConfig.widthMultiplier * 180,
                      height: 20,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        child: HorizontalProgressIndicator(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
    var androidInit = AndroidInitializationSettings('ic_launcher');
    var iosInit = IOSInitializationSettings();
    var initSetting = InitializationSettings(android: androidInit, iOS: iosInit);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'tlt_channel_id', // id
      'The laundry time', // title
      'This notification is from  TLT.', // description
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
            payload: message.data['notification_data']??'');

        fltNotification.initialize(initSetting,
            onSelectNotification: onSelectNotification);
      }
    });
  }

  Future onSelectNotification(String payload) async {
    if (payload != null && payload.isNotEmpty) {
      print('----payload: $payload');
      try {
        // get data from payload and navigate to screen
      } catch (e) {
        print(e);
      }
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

    if (initialMessage != null && initialMessage.data['notification_data'] != null) {
      print('----Firebase notification data onClicked 1: ${initialMessage.data}');
      try {
        /*final responseJson = json.decode(initialMessage.data['notification_data']);
        var model = BulkOrderNotificationModel.fromJson(responseJson);
        print('----Fb noti orderId 1: ${model.orderId}');

        SharedPreferenceHelper().getUserCustomerId().then((customerId) => {
          if (customerId.isNotEmpty)
            {
              Future.delayed(const Duration(milliseconds: 2000), () =>
                  MyRootApp.navigatorKey.currentState.push(MaterialPageRoute(builder: (context) => BulkOrderPreview(
                    customerId: customerId,
                    orderId: model.orderId,
                  )))),
            }
          else
            {
              Future.delayed(const Duration(milliseconds: 2000), () =>
                  MyRootApp.navigatorKey.currentState.pushReplacement(MaterialPageRoute(builder: (context) => Intro()))),
            }
        });*/
      } catch (e) {
        print(e);
      }
    } else {
      /*SharedPreferenceHelper().getUserCustomerId().then((customerId) => {
        //print('-----2 $customerId'),
        if (customerId.isNotEmpty)
          {
            SharedPreferenceHelper().getCartCount().then((value) => {
              Future.delayed(const Duration(milliseconds: 2000), () =>
                  MyRootApp.navigatorKey.currentState.pushReplacement(MaterialPageRoute(builder: (context) => Home(
                    cartCount: value,
                  )))),
            })
          }
        else
          {
            Future.delayed(const Duration(milliseconds: 2000), () =>
                MyRootApp.navigatorKey.currentState.pushReplacement(MaterialPageRoute(builder: (context) => Intro()))),
          }
      });*/
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message != null && message.data['notification_data'] != null) {
        print('----Firebase notification data onClicked 2: ${message.data}');
        try {
          /*final responseJson = json.decode(message.data['notification_data']);
          var model = BulkOrderNotificationModel.fromJson(responseJson);
          print('----Fb background notification orderId 2: ${model.orderId}');

          SharedPreferenceHelper().getUserCustomerId().then((customerId) => {
            if (customerId.isNotEmpty)
              {
                Future.delayed(const Duration(milliseconds: 2000), () =>
                    MyRootApp.navigatorKey.currentState.pushReplacement(MaterialPageRoute(builder: (context) => BulkOrderPreview(
                      customerId: customerId,
                      orderId: model.orderId,
                    )))),
              }
            else
              {
                Future.delayed(const Duration(milliseconds: 2000), () =>
                    MyRootApp.navigatorKey.currentState.pushReplacement(MaterialPageRoute(builder: (context) => Intro()))),
              }
          });
          */
        } catch (e) {
          print(e);
        }
      } else {
        /*SharedPreferenceHelper().getUserCustomerId().then((customerId) => {
          //print('-----2 $customerId'),
          if (customerId.isNotEmpty)
            {
              SharedPreferenceHelper().getCartCount().then((value) => {
                Future.delayed(const Duration(milliseconds: 2000), () =>
                    MyRootApp.navigatorKey.currentState.pushReplacement(MaterialPageRoute(builder: (context) => Home(
                      cartCount: value,
                    )))),
              })
            }
          else
            {
              Future.delayed(const Duration(milliseconds: 2000), () =>
                  MyRootApp.navigatorKey.currentState.pushReplacement(MaterialPageRoute(builder: (context) => Intro()))),
            }
        });*/
      }
    });
  }
}
