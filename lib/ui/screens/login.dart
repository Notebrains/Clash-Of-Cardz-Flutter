import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:trump_card_game/helper/exten_fun/common_fun.dart';
import 'package:trump_card_game/helper/shared_preference_data.dart';
import 'package:trump_card_game/model/responses/login_res_model.dart';
import 'package:trump_card_game/ui/screens/home.dart';
import 'package:trump_card_game/ui/screens/pvp.dart';
import 'package:trump_card_game/ui/widgets/animations/spring_button.dart';
import 'package:trump_card_game/ui/widgets/custom/carousel_auto_slider.dart';
import 'package:trump_card_game/ui/widgets/custom/frosted_glass.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_waiting_for_friend.dart';
import 'package:trump_card_game/ui/widgets/libraries/animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'dart:async';

import 'package:lottie/lottie.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:bot_toast/bot_toast.dart';


class LogIn extends StatefulWidget {
  const LogIn({Key key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  var loggedIn = false;
  var context;
  String firebaseToken = '';


  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _register() {
    _firebaseMessaging.getToken().then((token) {
      this.firebaseToken = token;
      print('----Firebase Token: $token');
    });
  }

  //////local notification
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();


  @override
  void initState() {
    super.initState();
    _register();
    getMessage();

    //local notification
    var initializationSettingsAndroid =
    AndroidInitializationSettings('notification_big_img');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
  }

  void getMessage(){
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('firebase noti: on message $message');
          //setState(() => _message = message["notification"]["title"]);

          SharedPreferenceHelper().getNotificationOnOffState().then((isNotificationOn) => {
            if (isNotificationOn) {
              showBigPictureNotification(),
            }
          });

        }, onResume: (Map<String, dynamic> message) async {
      print('firebase noti: on resume $message');
      //setState(() => _message = message["notification"]["title"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('firebase noti: on launch $message');
      //setState(() => _message = message["notification"]["title"]);
    });
  }

  ///////local notification
  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) => IncludeWaitingForFriend(
        categoryName: 'Sports',
        subcategoryName: 'Cricket',
        gameType: 'play with friends',
        cardsToPlay: '14',
        friendId: 'MEM00001',
        friendName: 'Rex',
        friendImage: 'https://predictfox.com/trumpcard/assets/uploads/carddetails/16086354135.png',
        joinedPlayerType: 'joinedAsFriend',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    this.context = context;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/bg_img3.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeInDownBig(
                        child: ColorizeAnimatedTextKit(
                          onTap: () {
                            //print("Tap Event");
                          },
                          text: [
                            "CLASH OF CARDZ"
                          ],
                          textStyle: TextStyle(
                              fontSize: 55.0,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Rapier'
                          ),
                          colors: [
                            Colors.grey[700],
                            Colors.deepOrange,
                            Colors.grey[700],
                          ],
                          textAlign: TextAlign.center,
                          alignment: AlignmentDirectional.center,
                          // or Alignment.topLeft
                          isRepeatingAnimation: true,
                          repeatForever: true,
                          speed: Duration(milliseconds: 1000),
                        ),
                        preferences:
                        AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BounceInLeft(
                            child:  Container(
                              margin: EdgeInsets.only(top: 26),
                              child: SpringButton(
                                SpringButtonType.WithOpacity,
                                Material(
                                  borderRadius: BorderRadius.circular(25.0),
                                  elevation: 16,
                                  shadowColor: Colors.deepOrange,
                                  child: InkWell(
                                    child: Container(
                                      width: 150,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.red,
                                            Colors.red,
                                            Colors.red,
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(5.0),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          Padding(
                                            padding: const EdgeInsets.only(right: 12),
                                            child: Text(
                                              'Google     ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontStyle: FontStyle.normal,
                                                fontFamily: 'montserrat',
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),

                                          IconButton(
                                            icon: SvgPicture.asset('assets/icons/svg/google-plus.svg',
                                              color: Colors.white),
                                            onPressed: () {
                                              onTapAudio('button');},
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: (){
                                      initiateSignIn("G");
                                    },
                                  ),
                                ),
                              ),
                            ),
                            preferences:
                            AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                          ),

                          BounceInRight(
                            child:  Container(
                              margin: EdgeInsets.only(top: 16, bottom:  16),
                              child: SpringButton(
                                SpringButtonType.WithOpacity,
                                InkWell(
                                  child: Material(
                                    borderRadius: BorderRadius.circular(25.0),
                                    elevation: 22,
                                    shadowColor: Colors.blue,
                                    child: Container(
                                      width: 180,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.blue[700],
                                            Colors.blue[700],
                                            Colors.blue[700],
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(5.0),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          Padding(
                                            padding: const EdgeInsets.only(right: 12),
                                            child: Text(
                                              'Facebook',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontStyle: FontStyle.normal,
                                                fontFamily: 'montserrat',
                                                color: Colors.white,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),

                                          IconButton(
                                            highlightColor: Colors.blue[200],
                                            icon: SvgPicture.asset(
                                                'assets/icons/svg/facebook.svg'),
                                            onPressed: () {

                                              onTapAudio('button');
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  onTap: (){
                                    initiateSignIn("FB");
                                  },
                                ),
                              ),
                            ),
                            preferences:
                            AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                          ),

                          BounceInDown(
                            child:  SpringButton(
                              SpringButtonType.WithOpacity,
                              Material(
                                borderRadius: BorderRadius.circular(25.0),
                                elevation: 16,
                                shadowColor: Colors.green,
                                child: GestureDetector(
                                  child: Container(
                                    width: 220,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.green[700],
                                          Colors.green[700],
                                          Colors.green[700],
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        Padding(
                                          padding: const EdgeInsets.only(right: 6),
                                          child: Text(
                                            'Play Games',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontStyle: FontStyle.normal,
                                                fontFamily: 'montserrat',
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),

                                        IconButton(
                                          icon: SvgPicture.asset('assets/icons/svg/games.svg',
                                              color: Colors.white),
                                          onPressed: () {
                                            onTapAudio('button');},
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: (){
                                    Navigator.push(context, CupertinoPageRoute(builder: (context) => Pvp()),);
                                  },
                                ),
                              ),
                            ),
                            preferences:
                            AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: FadeInRightBig(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(80, 0, 80, 0),
                      child: CarouselAutoSlider(),
                    ),
                    preferences:
                    AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void initiateSignIn(String type) {
    _handleSignIn(type).then((result) {
      if (result == 1) {
        setState(() {
          loggedIn = true;
        });
      } else {

      }
    });
  }

  Future<int> _handleSignIn(String type) async {
    switch (type) {
      case "FB":
        FacebookLoginResult facebookLoginResult = await _handleFBSignIn();
        final accessToken = facebookLoginResult.accessToken.token;
        print("----Fb accessToken : " + accessToken);
        if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
          final facebookAuthCred = FacebookAuthProvider.getCredential(accessToken: accessToken);
          final user = await FirebaseAuth.instance.signInWithCredential(facebookAuthCred);
          //var user = (await firebaseAuth.signInWithCredential(facebookAuthCred)).user;
          try {
            print("----F User : " + user.displayName);
            print("----F uid : " + user.uid);
            print("----F email : " + user.email);
            print("----F phoneNumber : " + user.phoneNumber);
            print("----F photoUrl : " + user.photoUrl);
            print("----F providerId : " + user.providerId);

            //loginByServer(user.displayName, user.email, user.uid, user.photoUrl, "deviceToken", "memberId");
            loginByServer(context, user.displayName, user.email, user.uid, user.photoUrl, '');
          } catch (e) {
            print(e);
          }
          return 1;
        } else
          print("--------");
          return 0;
        break;
      case "G":
        try {
          GoogleSignInAccount googleSignInAccount = await _handleGoogleSignIn();
          final googleAuth = await googleSignInAccount.authentication;
          print("----G accessToken : " + googleAuth.accessToken);
          final googleAuthCred = GoogleAuthProvider.getCredential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
          final user = await FirebaseAuth.instance.signInWithCredential(googleAuthCred);

          try {
            print("----G User : " + user.displayName);
            print("----G uid : " + user.uid);
            print("----G email : " + user.email);
            //print("----F phoneNumber : " + user.phoneNumber);
            print("----G photoUrl : " + user.photoUrl);
            print("----G providerId : " + user.providerId);

            loginByServer(context, user.displayName, user.email, user.uid, user.photoUrl, '');
          } catch (e) {
            print(e);
            print('e-----------------');
          }

          return 1;
        } catch (error) {
          print('ee----');
          return 0;
        }
    }
    return 0;
  }

  Future<FacebookLoginResult> _handleFBSignIn() async {
    FacebookLogin facebookLogin = FacebookLogin();
    FacebookLoginResult facebookLoginResult =
    await facebookLogin.logInWithReadPermissions(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.cancelledByUser:
        print("Cancelled");
        break;
      case FacebookLoginStatus.error:
        print("error");
        break;
      case FacebookLoginStatus.loggedIn:
        print("Logged In");
        break;
    }
    return facebookLoginResult;
  }

  Future<GoogleSignInAccount> _handleGoogleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly']);
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    return googleSignInAccount;
  }

  void loginByServer(BuildContext context, String name, String email, String socialId, String image, String memberId){
    
    apiBloc.fetchLoginRes(name, email, socialId, image, firebaseToken, memberId);

    loginUserByDialog(context);
  }


  Future<void> showBigPictureNotification() async {
    var bigPictureStyleInformation = BigPictureStyleInformation(
        DrawableResourceAndroidBitmap("notification_big_img"),
        largeIcon: DrawableResourceAndroidBitmap("notification_big_img"),
        contentTitle: 'Clash Of Cardz',
        htmlFormatContentTitle: true,
        summaryText: 'Your friend request to play match. Play Now',
        htmlFormatSummaryText: true);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'big text channel id',
        'big text channel name',
        'big text channel description',
        styleInformation: bigPictureStyleInformation);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        'big text title',
        'silent body',
        platformChannelSpecifics,
        payload: 'Default_Sound');
  }


  void loginUserByDialog(BuildContext context) async{
    showDialog(
      context: context,
      barrierDismissible: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              ZoomIn(
                child: Center(
                  child: Lottie.asset('assets/animations/lottiefiles/sports-loading.json',
                      height: 350, width: 350, repeat: true, animate: true),
                ),
                preferences: AnimationPreferences(duration: const Duration(milliseconds: 800), autoPlay: AnimationPlayStates.Forward),
              ),

              StreamBuilder(
                  stream: apiBloc.loginRes,
                  builder: (context, AsyncSnapshot<LoginResModel> snapshot) {
                    if (snapshot.hasData) {
                      if(snapshot.data.status == 1){
                        SharedPreferenceHelper().saveUserApiKey(snapshot.data.responce.xApiKey);
                        SharedPreferenceHelper().saveUserMemberId(snapshot.data.responce.memberid);

                        Timer(Duration(milliseconds: 2000), () {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen(xApiKey: snapshot.data.responce.xApiKey, memberId: snapshot.data.responce.memberid,)));
                          });
                        });
                      }

                      return Container();
                    } else if (!snapshot.hasData) {
                      return Container();
                    } else return Center(
                        child: Text("No Data Found", style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 30)),);
                  }),
            ],
          ),
        );
      },
    );
  }
}



class PageRouteWithAnimation extends CupertinoPageRoute {
  PageRouteWithAnimation()
      : super(builder: (BuildContext context) => new HomeScreen());

  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new ScaleTransition(
      scale: animation,
      child: new FadeTransition(
        opacity: animation,
        child: new HomeScreen(),
      ),
    );
  }
}