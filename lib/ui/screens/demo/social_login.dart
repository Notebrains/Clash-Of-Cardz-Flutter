import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';


class SocialLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<SocialLogin> {
  var loggedIn = false;


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Firebase.initializeApp();
    return MaterialApp(home: _buildSocialLogin());
  }

  _buildSocialLogin() {
    return Scaffold(
      body: Container(
          color: Color.fromRGBO(0, 207, 179, 1),
          child: Center(
            child: loggedIn
                ? Text("Logged In! :)",
                style: TextStyle(color: Colors.white, fontSize: 40))
                : Stack(
              children: <Widget>[
                SizedBox.expand(
                  child: _buildSignUpText(),
                ),
                Container(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      // wrap height
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      // stretch across width of screen
                      children: <Widget>[
                        _buildFacebookLoginButton(),
                        _buildGoogleLoginButton(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Container _buildGoogleLoginButton() {
    return Container(
      margin: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 0),
      child: ButtonTheme(
        height: 48,
        child: RaisedButton(
            onPressed: () {
              initiateSignIn("G");
            },
            color: Colors.white,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            textColor: Color.fromRGBO(122, 122, 122, 1),
            child: Text("Connect with Google",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ))),
      ),
    );
  }

  Container _buildFacebookLoginButton() {
    return Container(
      margin: EdgeInsets.only(left: 16, top: 0, right: 16, bottom: 0),
      child: ButtonTheme(
        height: 48,
        child: RaisedButton(
            materialTapTargetSize: MaterialTapTargetSize.padded,
            onPressed: () {
              initiateSignIn("FB");
            },
            color: Color.fromRGBO(27, 76, 213, 1),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            textColor: Colors.white,
            child: Text(
              "Connect with Facebook",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )),
      ),
    );
  }

  Container _buildSignUpText() {
    return Container(
      margin: EdgeInsets.only(top: 76),
      child: Text(
        "Sign Up",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontSize: 42,
            fontWeight: FontWeight.bold),
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
            print("----G email : " + user.email);
            print("----G phoneNumber : " + user.phoneNumber);
            print("----G photoUrl : " + user.photoUrl);
            print("----G uid : " + user.uid);
            print("----G providerId : " + user.providerId);
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
            print("----F email : " + user.email);
            //print("----F phoneNumber : " + user.phoneNumber);
            print("----F photoUrl : " + user.photoUrl);
            print("----F uid : " + user.uid);
            print("----F providerId : " + user.providerId);
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
}
