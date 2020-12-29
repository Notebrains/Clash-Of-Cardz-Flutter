import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieLoading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IncludeSearchingForPlayerState();
}

class IncludeSearchingForPlayerState extends State<LottieLoading> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Stack(
            children: <Widget>[
              new ConstrainedBox(
                constraints: const BoxConstraints.expand(),
              ),
              new Center(
                child: new ClipRect(
                  child: new BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: new Container(
                      decoration: new BoxDecoration(color: Colors.grey.shade50.withOpacity(0.1)),
                      child: new Center(
                        child: Container(
                          margin: EdgeInsets.all(5.0),
                          padding: EdgeInsets.all(5.0),
                          height: 350.0,
                          decoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))),
                          child: Column(
                            children: <Widget>[
                              Lottie.asset('assets/animations/lottiefiles/lottie_list_loading.json', width: 500, height: 290),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    "Loading...",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontFamily: 'neuropol_x_rg',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}