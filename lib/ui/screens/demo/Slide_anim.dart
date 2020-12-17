import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SlideInOutWidgetState();
}

class _SlideInOutWidgetState extends State<Home>
    with SingleTickerProviderStateMixin {
  double startPos = -1.0;
  double endPos = 0.0;
  Curve curve = Curves.elasticOut;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: Offset(startPos, 0), end: Offset(endPos, 0)),
      duration: Duration(seconds: 1),
      curve: curve,
      builder: (context, offset, child) {
        return FractionalTranslation(
          translation: offset,
          child: Container(
            width: double.infinity,
            child: Center(
              child: child,
            ),
          ),
        );
      },
      child: Image.asset('assets/images/bg_card_back.png', fit: BoxFit.fill),
      onEnd: () {
        print('onEnd');
       /* Future.delayed(
          Duration(milliseconds: 500),
              () {
            curve = curve == Curves.elasticOut
                ? Curves.elasticIn
                : Curves.elasticOut;
            if (startPos == -1) {
              setState(() {
                startPos = 0.0;
                endPos = 1.0;
              });
            }
          },
        );*/
      },
    );
  }
}