import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:trump_card_game/helper/shared_preference_data.dart';
import 'package:trump_card_game/model/responses/login_res_model.dart';
import 'package:trump_card_game/ui/screens/home.dart';
import 'package:trump_card_game/ui/widgets/custom/carousel_auto_slider.dart';
import 'package:trump_card_game/ui/widgets/libraries/animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_animator/flutter_animator.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  var loggedIn = false;
  var context;

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    this.context = context;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                      ColorizeAnimatedTextKit(
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

                      ZoomIn(
                        child: MaterialButton(
                          padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
                          textColor: Colors.white70,
                          splashColor: Colors.grey,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/icons/png/bg_button.png'),
                                  fit: BoxFit.cover),
                            ),
                            child: Container(
                              width: 220,
                              height: 45,
                              padding: EdgeInsets.fromLTRB(24.0, 5.0, 24.0, 16.0),
                              child: Text(
                                "LOGIN USING",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'neuropol_x_rg',
                                    color: Colors.black87),
                              ),
                            ),
                          ),
                          // ),
                          onPressed: () {
                            //Navigator.of(context).push(new PageRouteWithAnimation());
                            //onPressed: () {Navigator.push(context, _pageRouteBuilder());
                          },
                        ),
                        preferences:
                        AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                      ),

                      //login button


                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BounceInLeft(
                            child: IconButton(
                              highlightColor: Colors.grey,
                              icon: SvgPicture.asset(
                                  'assets/icons/svg/google.svg'),
                              onPressed: () {
                                initiateSignIn("G");
                              },
                            ),
                            preferences:
                            AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                          ),

                          BounceInDown(
                            child: IconButton(
                              highlightColor: Colors.green[200],
                              icon: Image.asset(
                                  'assets/icons/png/ic_google_play_games.png'),
                              onPressed: () {
                                Navigator.of(context).push(new PageRouteWithAnimation());

                              },
                            ),
                            preferences:
                            AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                          ),



                          BounceInRight(
                            child: IconButton(
                              highlightColor: Colors.blue[200],
                              icon: SvgPicture.asset(
                                  'assets/icons/svg/facebook.svg'),
                              onPressed: () {
                                initiateSignIn("FB");
                              },
                            ),
                            preferences:
                            AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                          ),


                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Or",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'neuropol_x_rg',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700]),
                        ),
                      ),

                      BounceInUp(
                        child: GestureDetector(
                          child: Text(
                            "Play As Guest",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22.0,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'neuropol_x_rg',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700]),
                          ),

                          onTap: (){
                            Navigator.of(context).push(new PageRouteWithAnimation());
                          },
                        ),
                        preferences:
                        AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                      ),

                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(80, 0, 80, 0),
                    child: CarouselAutoSlider(),
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
            print("----G User : " + user.displayName);
            print("----G uid : " + user.uid);
            print("----G email : " + user.email);
            print("----G phoneNumber : " + user.phoneNumber);
            print("----G photoUrl : " + user.photoUrl);
            print("----G providerId : " + user.providerId);

            //loginByServer(user.displayName, user.email, user.uid, user.photoUrl, "deviceToken", "memberId");
            loginByServer("soijioejfoief", "dijdidoiascswidii@gijg.se", "8565635353", "ddw.jpg", "fsefsefsf", "MEM000019");
          } catch (e) {
            print(e);
          }
          return 1;
        } else
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
            print("----F User : " + user.displayName);
            print("----F uid : " + user.uid);
            print("----F email : " + user.email);
            //print("----F phoneNumber : " + user.phoneNumber);
            print("----F photoUrl : " + user.photoUrl);
            print("----F providerId : " + user.providerId);


            loginByServer("soijioejfoief", "dijdidoiascswidii@gijg.se", "8565635353", "ddw.jpg", "fsefsefsf", "MEM000019");

          } catch (e) {
            print(e);
          }

          return 1;
        } catch (error) {
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

  void loginByServer(String name, String email, String socialId, String image, String deviceToken, String memberId) {
    apiBloc.fetchLoginRes(name, email, socialId, image, deviceToken, memberId);
     StreamBuilder(
        stream: apiBloc.loginRes,
        builder: (context, AsyncSnapshot<LoginResModel> snapshot) {
          if (snapshot.hasData) {
            LoginResModel res = snapshot.data;
            if(res.message == "login successfully"){
              SharedPreferenceHelper().saveUserApiKey(res.responce.xApiKey);
              Navigator.of(context).push(new PageRouteWithAnimation());
            }
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        });
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