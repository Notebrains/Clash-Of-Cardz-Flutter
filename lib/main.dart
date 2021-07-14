import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:clash_of_cardz_flutter/ui/screens/splash.dart';
import 'ui/styles/size_config.dart';

//This function will call if app run on background
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  //print("Handling a background message-messageId: ${message.messageId}");
  //print("Handling a background message-title: ${message.notification.title}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyRootApp());
}

class MyRootApp extends StatelessWidget {
  // This widget is the root of your application.
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              //theme: AppTheme.lightTheme,
              builder: (context, child) {
                return MediaQuery(
                  child: child, data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                );
              },
              debugShowCheckedModeBanner: false,
              navigatorKey: navigatorKey,
              home: SplashScreen(),
            );
          },
        );
      },
    );
  }
}
