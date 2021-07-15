import 'package:clash_of_cardz_flutter/ui/styles/size_config.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/no_data_found.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/shimmer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:clash_of_cardz_flutter/bloc/api_bloc.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/common_fun.dart';
import 'package:clash_of_cardz_flutter/helper/shared_preference_data.dart';
import 'package:clash_of_cardz_flutter/model/responses/login_res_model.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/animations/spring_button.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/carousel_auto_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';
import 'home.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
NotificationAppLaunchDetails notificationAppLaunchDetails;

class LogIn extends StatefulWidget {
  const LogIn({Key key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  var loggedIn = false;
  var context;

  String firebaseToken = '';

  _register() async {
    firebaseToken = await FirebaseMessaging.instance.getToken();
    print('----Firebase Token: $firebaseToken');
  }

  @override
  void initState() {
    super.initState();
    _register();
    //getMessage();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF2A3C49),
      body: Column(
        children: [
          Container(
            height: 70,
            width: double.maxFinite,
            color: Color(0xFF1A2D3B),
            alignment: Alignment.center,
            child: SlideInDown(
              child: Shimmer.fromColors(
                baseColor: Colors.white54,
                highlightColor: Colors.lightBlueAccent,
                child: Text(
                  'CLASH OF CARDZ',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40, fontFamily: 'Rapier', color: Colors.white, fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(45, 40, 45, 40),
                margin: EdgeInsets.only(left: 40, right: 16),
                alignment: Alignment.center,
                color: Color(0xFF1D3342),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BounceInLeft(
                      child: Container(
                        child: SpringButton(
                          SpringButtonType.WithOpacity,
                          Material(
                            borderRadius: BorderRadius.circular(25.0),
                            elevation: 16,
                            shadowColor: Colors.deepOrange,
                            child: InkWell(
                              child: Container(
                                width: 180,
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
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    IconButton(
                                      icon: SvgPicture.asset('assets/icons/svg/google-plus.svg', color: Colors.white),
                                      onPressed: () {
                                        onTapAudio('button');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
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
                      child: Container(
                        margin: EdgeInsets.only(top: 16, bottom: 16),
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
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    IconButton(
                                      highlightColor: Colors.blue[200],
                                      icon: SvgPicture.asset('assets/icons/svg/facebook.svg'),
                                      onPressed: () {
                                        onTapAudio('button');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              initiateSignIn("FB");
                            },
                          ),
                        ),
                      ),
                      preferences:
                          AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                    ),
                    BounceInDown(
                      child: SpringButton(
                        SpringButtonType.WithOpacity,
                        Material(
                          borderRadius: BorderRadius.circular(25.0),
                          elevation: 16,
                          shadowColor: Colors.green,
                          child: GestureDetector(
                            child: Container(
                              width: 180,
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
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  IconButton(
                                    icon: SvgPicture.asset('assets/icons/svg/games.svg', color: Colors.white),
                                    onPressed: () {
                                      onTapAudio('button');
                                    },
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              //Navigator.push(context, CupertinoPageRoute(builder: (context) => Pvp()),);
                              showToast(context, 'Not yet possible to login by Google Play Games');
                            },
                          ),
                        ),
                      ),
                      preferences:
                          AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FadeInRightBig(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(36, 8, 50, 0),
                    child: CarouselAutoSlider(
                      xApiKey: '56005600',
                    ),
                  ),
                  preferences: AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void initiateSignIn(String type) {
    _handleSignIn(type).then((result) {
      if (result == 1) {
        setState(() {
          loggedIn = true;
        });
      } else {}
    });
  }

  Future<int> _handleSignIn(String type) async {
    switch (type) {
      case "FB":
        FacebookLoginResult facebookLoginResult = await _handleFBSignIn();
        final accessToken = facebookLoginResult.accessToken.token;
        print("----Fb accessToken : " + accessToken);
        if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
          final facebookAuthCred = FacebookAuthProvider.credential(accessToken);
          UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCred);
          //var user = (await firebaseAuth.signInWithCredential(facebookAuthCred)).user;
          print("----F User : " + userCredential.user.displayName);
          print("----F uid : " + userCredential.user.uid);
          print("----F email : " + userCredential.user.email);
          print("----F phoneNumber : " + userCredential.user.phoneNumber);
          print("----F photoUrl : " + userCredential.user.photoURL);
          print("----F providerId : " + userCredential.user.tenantId);

          //loginByServer(user.displayName, user.email, user.uid, user.photoUrl, "deviceToken", "memberId");
          loginByServer(context, userCredential.user.displayName, userCredential.user.email, userCredential.user.uid,
              userCredential.user.photoURL, '');

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
          final googleAuthCred = GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
          UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(googleAuthCred);

          print("----G User : " + userCredential.user.displayName);
          print("----G uid : " + userCredential.user.uid);
          print("----G email : " + userCredential.user.email);
          //print("----F phoneNumber : " + userCredential.phoneNumber);
          print("----G photoUrl : " + userCredential.user.photoURL);
          //print("----G providerId : " + userCredential.user.tenantId);

          loginByServer(context, userCredential.user.displayName, userCredential.user.email, userCredential.user.uid,
              userCredential.user.photoURL, '');

          return 1;
        } catch (error) {
          print(error.toString());
          return 0;
        }
    }
    return 0;
  }

  Future<FacebookLoginResult> _handleFBSignIn() async {
    FacebookLogin facebookLogin = FacebookLogin();
    FacebookLoginResult facebookLoginResult = await facebookLogin.logIn(['email']);
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
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ]);
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    return googleSignInAccount;
  }

  void loginByServer(BuildContext context, String name, String email, String socialId, String image, String memberId) async {
    apiBloc.fetchLoginRes(name, email, socialId, image, firebaseToken, memberId);

    loginUserByDialog(context);
  }

  void loginUserByDialog(BuildContext context) async {
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
                  child: Lottie.asset('assets/animations/lottiefiles/sports-loading.json', height: SizeConfig.heightMultiplier * 32, width: SizeConfig.heightMultiplier * 32, repeat: true, animate: true),
                ),
                preferences: AnimationPreferences(duration: const Duration(milliseconds: 800), autoPlay: AnimationPlayStates.Forward),
              ),
              StreamBuilder(
                  stream: apiBloc.loginRes,
                  builder: (context, AsyncSnapshot<LoginResModel> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.status == 1) {
                        SharedPreferenceHelper().saveUserApiKey(snapshot.data.responce.xApiKey);
                        SharedPreferenceHelper().saveUserMemberId(snapshot.data.responce.memberid);

                        Timer(Duration(milliseconds: 2000), () {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => Home(
                                  xApiKey: snapshot.data.responce.xApiKey,
                                  memberId: snapshot.data.responce.memberid,
                                ),
                              ),
                            );
                          });
                        });
                      }

                      return Container();
                    } else if (!snapshot.hasData) {
                      return Container();
                    } else
                      return NoDataFound();
                  }),
            ],
          ),
        );
      },
    );
  }
}
