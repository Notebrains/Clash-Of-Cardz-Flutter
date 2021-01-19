import 'package:flutter/material.dart';
import 'package:trump_card_game/ui/screens/demo/firebasse_notification.dart';
import 'package:trump_card_game/ui/screens/demo/value_listener_state_management.dart';
import 'package:trump_card_game/ui/screens/splash.dart';

/*

// This is for firebase crud fun screen
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
    name: 'clash_of_cardz_db',
    */
/*options: Platform.isIOS || Platform.isMacOS
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
    ),*//*


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
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Firebase Realtime Database',
    home: FirebaseCrud(app: app),
  ));
}
*/



void main() => runApp(MyRootApp());

class MyRootApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Value Lin',),
    );
  }
}

