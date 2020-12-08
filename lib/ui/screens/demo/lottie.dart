import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyLottePage extends StatefulWidget {
  const MyLottePage({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MyLottePage> with TickerProviderStateMixin {
  AnimationController _animationController;
  bool _showAnimation = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _showAnimation = false;
          });
        }
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                if (_showAnimation)
                  Lottie.asset(
                    'assets/animations/lottiefiles/page-searching.json',
                    //fetch from web :
                    //Lottie.network('https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json'),

                    controller: _animationController,
                    width: 500,
                    onLoaded: (composition) {
                      _animationController
                        ..duration = composition.duration
                        ..reset()
                        ..forward();
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}