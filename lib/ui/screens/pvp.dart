import 'dart:async';

import 'package:clash_of_cardz_flutter/helper/shared_preference_data.dart';
import 'package:clash_of_cardz_flutter/ui/styles/size_config.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clash_of_cardz_flutter/helper/constantvalues/constants.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/base_application_fun.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/common_fun.dart';
import 'package:clash_of_cardz_flutter/ui/screens/autoplay.dart';
import 'package:clash_of_cardz_flutter/ui/screens/gameplay.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:shape_of_view/shape_of_view.dart';

class Pvp extends StatefulWidget {
  final String xApiKey;
  final String p1Name;
  final String p1Id;
  final String p1Image;
  final String p2Name;
  final String p2Id;
  final String p2Image;
  final String gameCat1;
  final String gameCat2;
  final String gameCat3;
  final String gameCat4;
  final String playerType;
  final String gameType;
  final String cardsToPlay;

  Pvp({
    this.xApiKey,
    this.p1Name,
    this.p1Id,
    this.p1Image,
    this.p2Name,
    this.p2Id,
    this.p2Image,
    this.gameCat1,
    this.gameCat2,
    this.gameCat3,
    this.gameCat4,
    this.playerType,
    this.gameType,
    this.cardsToPlay,
  });

  @override
  _PvpState createState() => _PvpState();
}

class _PvpState extends State<Pvp> {
  bool _isOpenGamePlayScreen = false;

  @override
  void initState() {
    super.initState();
    setScreenOrientationToLandscape();
    onTapAudio('pvp_screen');

    openGamePlayPage();
  }

  @override
  Widget build(BuildContext context) {
    //print('----game cats pvp: ${widget.gameCat1} , ${widget.gameCat2} , ${widget.gameCat3}, ${widget.gameCat4}, ${widget.playerType}, ${widget.cardsToPlay}, ${widget.gameType}');
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg-vs-4.jpg"),
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
                      height: SizeConfig.heightMultiplier * 18,
                      width: SizeConfig.heightMultiplier * 18,
                      shape: CircleShape(borderColor: Colors.orangeAccent, borderWidth: 5),
                      elevation: 16,
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/icons/png/circle-avator-default-img.png',
                        image: widget.p1Image,
                        fit: BoxFit.fill,
                      ),
                    ),
                    preferences:
                    AnimationPreferences(duration: const Duration(milliseconds: 2100), autoPlay: AnimationPlayStates.Forward),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BounceInLeft(
                    child: Shimmer.fromColors(
                      baseColor: Colors.white,
                      highlightColor: Colors.orangeAccent,
                      child: Text(widget.p1Name.toUpperCase(),
                          textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25, fontFamily: 'montserrat', color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    preferences:
                    AnimationPreferences(duration: const Duration(milliseconds: 2200), autoPlay: AnimationPlayStates.Forward),
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
                      height: SizeConfig.heightMultiplier * 17,
                      width: SizeConfig.heightMultiplier * 17,
                      shape: CircleShape(borderColor: Colors.lightBlueAccent, borderWidth: 5),
                      elevation: 12,
                      child: FadeInImage.assetNetwork(
                        placeholder: widget.p2Image != Constants.imgUrlComputer
                            ? 'assets/icons/png/circle-avator-default-img.png'
                            : 'assets/icons/png/chatbots-chat-bot-azul.png',
                        image: widget.p2Image,
                        fit: BoxFit.contain,
                      ),
                    ),
                    preferences:
                    AnimationPreferences(duration: const Duration(milliseconds: 2000), autoPlay: AnimationPlayStates.Forward),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BounceInRight(
                    child: Shimmer.fromColors(
                      baseColor: Colors.white,
                      highlightColor: Colors.lightBlueAccent,
                      child: Text(widget.p2Name.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25, fontFamily: 'montserrat', color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    preferences:
                    AnimationPreferences(duration: const Duration(milliseconds: 1800), autoPlay: AnimationPlayStates.Forward),
                  ),
                ],
              ),
            ),
            //openGamePlayPage(),
          ],
        ),
      ),
    );
  }

  void openGamePlayPage() async {
    Future.delayed(const Duration(milliseconds: 2500), () {
      SharedPreferenceHelper().getUserUserMemberId().then((p1MemberIdPref) => {
            Future.delayed(const Duration(milliseconds: 2500), () {
              String gameRoomName = 'gamePlay-${widget.p1Id}-${widget.p2Id}';
              if (widget.p2Image == Constants.imgUrlComputer) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AutoPlay(
                      xApiKey: widget.xApiKey,
                      gameCat1: widget.gameCat1,
                      gameCat2: widget.gameCat2,
                      gameCat3: widget.gameCat3,
                      gameCat4: widget.gameCat4,
                      playerType: widget.playerType,
                      gameType: widget.gameType,
                      cardToPlay: widget.cardsToPlay,
                    ),
                  ),
                  ModalRoute.withName("/Autoplay"),
                );
              } else if (p1MemberIdPref == widget.p1Id) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Gameplay(
                            xApiKey: widget.xApiKey,
                            isPlayAsP1: true,
                            p1FullName: widget.p1Name,
                            p1MemberId: widget.p1Id,
                            p1Photo: widget.p1Image,
                            p2Name: widget.p2Name,
                            p2MemberId: widget.p2Id,
                            p2Image: widget.p2Image,
                            gameCat1: widget.gameCat1,
                            gameCat2: widget.gameCat2,
                            gameCat3: widget.gameCat3,
                            gameCat4: widget.gameCat4,
                            playerType: widget.playerType,
                            gameType: widget.gameType,
                            cardsToPlay: widget.cardsToPlay,
                            gameRoomName: gameRoomName,
                          ),
                  ),
                  ModalRoute.withName("/Gameplay"),
                );
              } else if (p1MemberIdPref == widget.p2Id) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Gameplay(
                            xApiKey: widget.xApiKey,
                            isPlayAsP1: false,
                            p1FullName: widget.p2Name,
                            p1MemberId: widget.p2Id,
                            p1Photo: widget.p2Image,
                            p2Name: widget.p1Name,
                            p2MemberId: widget.p1Id,
                            p2Image: widget.p1Image,
                            gameCat1: widget.gameCat1,
                            gameCat2: widget.gameCat2,
                            gameCat3: widget.gameCat3,
                            gameCat4: widget.gameCat4,
                            playerType: widget.playerType,
                            gameType: widget.gameType,
                            cardsToPlay: widget.cardsToPlay,
                            gameRoomName: gameRoomName,
                          ),
                  ),
                  ModalRoute.withName("/Gameplay"),
                );
              }
            }),
          });
    });
  }
}
