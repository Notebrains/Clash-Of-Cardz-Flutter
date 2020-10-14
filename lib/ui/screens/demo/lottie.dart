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
      color: Colors.lightBlue,
      home: Scaffold(
        backgroundColor: Colors.lightBlue,
        appBar: AppBar(
          title: Text('Show lottie animation: $_showAnimation'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                if (_showAnimation)
                  Lottie.asset(
                    'assets/lottiefiles/LottieLogo1.json',
                    //fetch from web :
                    //Lottie.network('https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json'),

                    controller: _animationController,
                    width: 200,
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