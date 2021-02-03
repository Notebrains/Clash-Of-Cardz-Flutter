import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:trump_card_game/helper/exten_fun/common_fun.dart';
import 'package:trump_card_game/ui/screens/gameplay.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:trump_card_game/ui/widgets/libraries/colorize.dart';
import 'package:shape_of_view/shape_of_view.dart';


class Pvp extends StatefulWidget{
  final String p1Name;
  final String p1Id;
  final String p1Image;
  final String p2Name;
  final String p2Id;
  final String p2Image;
  final String categoryName;
  final String subcategoryName;
  final String gameType;
  final String cardsToPlay;

  Pvp({this.p1Name,
      this.p1Id,
      this.p1Image,
      this.p2Name,
      this.p2Id,
      this.p2Image,
      this.categoryName,
      this.subcategoryName,
      this.gameType,
      this.cardsToPlay,
  });


  @override
  State<StatefulWidget> createState() {
    return _PvpState();
  }
}

class _PvpState extends State<Pvp>{
  bool _isOpenGamePlayScreen = false;
  
  @override
  void initState() {
    super.initState();
    setScreenOrientationToLandscape();
    onTapAudio('pvp_screen');
    _loadWidget();
  }


  _loadWidget() async {
    var _duration = Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => Gameplay(p1FullName: widget.p1Name, p1MemberId:  widget.p1Id, p1Photo:  widget.p1Image,
        p2Name:  widget.p2Name, p2MemberId:  widget.p2Id, p2Image:  widget.p2Image, categoryName:  widget.categoryName,
        subcategoryName: widget.subcategoryName, gameType:  widget.gameType, cardsToPlay:  widget.cardsToPlay,),),
    ).then((value) => Navigator.of(context).pop());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/bg-vs-4.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BounceInDown(
                      child: ShapeOfView(
                        height: 160,
                        width: 160,
                        shape: CircleShape(borderColor: Colors.orangeAccent, borderWidth: 5),
                        elevation: 16,
                        child: CircleAvatar(
                          radius: 30,
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/icons/png/circle-avator-default-img.png',
                            image: widget.p1Image,
                          ),
                        ),
                      ),
                      preferences: AnimationPreferences(duration: const Duration(milliseconds: 2100), autoPlay: AnimationPlayStates.Forward),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BounceInLeft(
                      child: ColorizeAnimatedTextKit(
                        onTap: () {
                          //print("Tap Event");
                        },
                        text: [widget.p1Name],
                        textStyle: TextStyle(fontSize: 30.0, fontStyle: FontStyle.normal, fontFamily: 'Rapier'),
                        colors: [
                          Colors.white,
                          Colors.yellow,
                          Colors.white,
                        ],
                        textAlign: TextAlign.center,
                        alignment: AlignmentDirectional.center,
                        // or Alignment.topLeft
                        isRepeatingAnimation: true,
                        repeatForever: true,
                        speed: Duration(milliseconds: 800),
                      ),
                      preferences: AnimationPreferences(duration: const Duration(milliseconds: 2200), autoPlay: AnimationPlayStates.Forward),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ZoomInRight(
                      child: ShapeOfView(
                        height: 160,
                        width: 160,
                        shape: CircleShape(borderColor: Colors.lightBlueAccent, borderWidth: 5),
                        elevation: 12,
                        child: CircleAvatar(
                          radius: 30,
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/icons/png/circle-avator-default-img.png',
                            image: widget.p2Image,
                          ),
                        ),
                      ),
                      preferences: AnimationPreferences(duration: const Duration(milliseconds: 2000), autoPlay: AnimationPlayStates.Forward),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BounceInRight(
                      child: ColorizeAnimatedTextKit(
                        onTap: () {
                          //print("Tap Event");
                        },
                        text: [widget.p2Name],
                        textStyle: TextStyle(fontSize: 30.0, fontStyle: FontStyle.normal, fontFamily: 'Rapier'),
                        colors: [
                          Colors.white,
                          Colors.lightBlueAccent,
                          Colors.white,
                        ],
                        textAlign: TextAlign.center,
                        alignment: AlignmentDirectional.center,
                        // or Alignment.topLeft
                        isRepeatingAnimation: true,
                        repeatForever: true,
                        speed: Duration(milliseconds: 800),
                      ),
                      preferences: AnimationPreferences(duration: const Duration(milliseconds: 1800), autoPlay: AnimationPlayStates.Forward),
                    ),
                  ],
                ),
              ),

              //openGamePlayPage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget openGamePlayPage(){
    if (_isOpenGamePlayScreen) {
      /*Timer(Duration(milliseconds: 2000), () {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => Gameplay(p1FullName: widget.p1Name, p1MemberId:  widget.p1Id, p1Photo:  widget.p1Image,
            p2Name:  widget.p2Name, p2MemberId:  widget.p2Id, p2Image:  widget.p2Image, categoryName:  widget.categoryName,
            subcategoryName: widget.subcategoryName, gameType:  widget.gameType, cardsToPlay:  widget.cardsToPlay,),),
        );
      });*/

      Future.delayed(const Duration(seconds: 3));
      Navigator.push(context, new MaterialPageRoute(builder: (__) =>  Gameplay(p1FullName: widget.p1Name, p1MemberId:  widget.p1Id, p1Photo:  widget.p1Image,
        p2Name:  widget.p2Name, p2MemberId:  widget.p2Id, p2Image:  widget.p2Image, categoryName:  widget.categoryName,
        subcategoryName: widget.subcategoryName, gameType:  widget.gameType, cardsToPlay:  widget.cardsToPlay,)));

    }  
    return Container();
  }

}
