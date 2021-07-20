import 'dart:ui';
import 'package:clash_of_cardz_flutter/ui/styles/size_config.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/outlined_btn_gradient_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/base_application_fun.dart';
import 'package:clash_of_cardz_flutter/model/responses/cards_res_model.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/avatar_glow.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/shimmer.dart';
import 'package:flutter_svg/flutter_svg.dart';

void showBothCardsDialog(BuildContext context, List<Cards> cards, int indexOfSelectedCard, int indexOfCardDeck, bool isMatchEnded,
    bool isPlayAsP1,  String isWon,{
  Function(bool isMatchEnded) onClickActionOnPlayAgain,
}) async {

  showDialog(
    context: context,
    barrierDismissible: false,
    useSafeArea: true,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: ZoomIn(
          child: Center(
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
                        decoration: new BoxDecoration(
                            color: Colors.grey.shade200.withOpacity(0.1)
                        ),
                        child: new Center(
                          child: Container(
                            //width: getScreenWidth(context) - 400,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: getScreenHeight(context) / 1.5,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 215,
                                          height: 310,
                                          margin: EdgeInsets.only(right: 12),
                                          child: RotateInDownRight(
                                            child: buildCard1(
                                                context,
                                                cards,
                                                indexOfCardDeck,
                                                indexOfSelectedCard,
                                                isPlayAsP1,
                                                isWon
                                            ),
                                            preferences: AnimationPreferences(
                                                duration: const Duration(milliseconds: 1500),
                                                autoPlay: AnimationPlayStates.Forward),
                                          ),
                                        ),

                                        HeartBeat(
                                          child: AvatarGlow(
                                            endRadius: 90,
                                            glowColor: Colors.lightBlueAccent,
                                            child: Container(
                                              width: 130,
                                              child: Center(
                                                child: Image.asset('assets/icons/png/vs2.png'),
                                              ),
                                            ),
                                          ),
                                          preferences: AnimationPreferences(
                                              duration: const Duration(milliseconds: 2000),
                                              autoPlay: AnimationPlayStates.Loop),
                                        ),

                                        Container(
                                          width: 220,
                                          height: 315,
                                          child: RollIn(
                                            child: buildCard2(
                                                context,
                                                indexOfSelectedCard,
                                                indexOfCardDeck,
                                                cards,
                                                isPlayAsP1,
                                                isWon
                                            ),
                                            preferences: AnimationPreferences(
                                                duration: const Duration(milliseconds: 1500),
                                                autoPlay: AnimationPlayStates.Forward),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(right: 8, top: 16),
                                  child: OutlinedBtnGradientBorder(
                                    gradColor1: Colors.deepOrangeAccent,
                                    gradColor2: Colors.cyan,
                                    height: 30,
                                    width: 250,
                                    thickness: 1,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          isMatchEnded ? 'Match Ended' : "Play Next Card",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontStyle: FontStyle.normal,
                                              fontFamily: 'montserrat',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue.shade50),
                                        ),

                                        TweenAnimationBuilder<Duration>(
                                            duration: Duration(seconds: 7),
                                            tween: Tween(begin: Duration(seconds: 7), end: Duration.zero),
                                            onEnd: () {
                                              try {
                                                onClickActionOnPlayAgain(isMatchEnded);
                                                Navigator.pop(context);
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            builder: (BuildContext context, Duration value, Widget child) {
                                              //adding 0 at first if min or sec show in single digit
                                              final minutes = (value.inMinutes).toString().padLeft(2, "0");
                                              final seconds = (value.inSeconds % 60).toString().padLeft(2, "0");
                                              return Tada(
                                                child: Text(
                                                  '$minutes : $seconds',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.green.shade50,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'montserrat',
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                preferences:
                                                AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Loop),
                                              );
                                            }),
                                      ],
                                    ),
                                    onPressed: () {
                                      onClickActionOnPlayAgain(isMatchEnded);
                                      Navigator.pop(context);
                                    },
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
          preferences: AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
        ),
      );
    },
  );
}

Widget buildCard1(
    BuildContext context,
    List<Cards> cardsList,
    int indexOfCardDeck,
    int indexOfSelectedCard,
    bool isPlayAsP1,
    String isWon) {

  // P1 and P2 value (attributes, name, image etc) will be opposite to each other
  List<List<Attribute>> cardsAttributeList = [];
  int cardListSize = (cardsList.length / 2).round();
  try {
    if (isPlayAsP1) {
      for (int i = 0; i < cardListSize; i++) {
        cardsAttributeList.add(cardsList[i].attribute);
      }
    } else {
      for (int i = cardListSize; i < cardsList.length; i++) {
        cardsAttributeList.add(cardsList[i].attribute);
      }
    }

  } catch (e) {
    print(e);
  }

  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.deepOrange,
        width: 1,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.deepOrangeAccent,
          blurRadius: 15.0,
          offset: Offset(5.0, 5.0),
        ),
      ],
    ),
    child:  Stack(
      children: [
        Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                Colors.deepOrange,
                Colors.orange[600],
                Colors.deepOrangeAccent,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,),
          ),
        ),

        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                placeholder: 'assets/images/cricket_1.png',
                image: isPlayAsP1 ? cardsList[indexOfCardDeck].cardImg : cardsList[cardListSize + indexOfCardDeck].cardImg,
                height: 145,
                width: 145
            ),
          ),
        ),

        showOrHideWinnerImg(isWon),

        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 0, left: 3),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              childAspectRatio: 5 / 3,
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              // if you want IOS bouncing effect, otherwise remove this line
              padding: EdgeInsets.all(2),
              //change the number as you want
              children: List.generate(cardsAttributeList[indexOfCardDeck].length, (index) {
                return Container(
                  padding: index == indexOfSelectedCard? EdgeInsets.only(left: 3, top: 1):EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: index == indexOfSelectedCard? Colors.white24: Colors.transparent,
                    border: index == indexOfSelectedCard? Border.all(color: Colors.white):Border.all(color: Colors.transparent),
                    borderRadius: index == indexOfSelectedCard? BorderRadius.all(Radius.circular(3)):BorderRadius.all(Radius.circular(0)),
                  ),
                  //margin: EdgeInsets.only(left: 5, right: 5),
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 1),
                  child: Material(
                    color: Colors.transparent,
                    borderOnForeground: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeartBeat(
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  cardsAttributeList[indexOfCardDeck][index].value,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: 'neuropol_x_rg',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 3),
                                child: Stack(alignment: Alignment.center, children: <Widget>[
                                  SvgPicture.asset(
                                    'assets/icons/svg/star1.svg',
                                    width: 13,
                                    height: 13,
                                  ),
                                  Text(
                                    cardsAttributeList[indexOfCardDeck][index].winPoints,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.black),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                          preferences: AnimationPreferences(
                              offset: Duration(milliseconds: 4000),
                              duration: const Duration(milliseconds: 1000),
                              autoPlay: AnimationPlayStates.Loop),
                        ),

                        Text(
                          cardsAttributeList[indexOfCardDeck][index].name,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 8,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'neuropol_x_rg',
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, top: 1),
                          child: Divider(
                            color: Colors.white,
                            thickness: 1,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),


        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 46, top: 5, right: 5, bottom: 5),
              child: RotationTransition(
                alignment: Alignment.topLeft,
                turns: AlwaysStoppedAnimation(90 / 360),
                child: Container(
                  width: SizeConfig.heightMultiplier * 37.5,
                  height: SizeConfig.heightMultiplier * 5.2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ShapeOfView(
                          height: 17,
                          width: 17,
                          shape: CircleShape(borderColor: Colors.white, borderWidth: 1),
                          elevation: 1,
                          child: CircleAvatar(
                            radius: 30,
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/icons/png/white-flag.png',
                              image: isPlayAsP1 ? cardsList[indexOfCardDeck].flagImage : cardsList[cardListSize + indexOfCardDeck].flagImage,
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Shimmer.fromColors(
                          baseColor: Colors.white,
                          highlightColor: Colors.orange[800],
                          child: Text(
                            isPlayAsP1 ? cardsList[indexOfCardDeck].cardName : cardsList[cardListSize + indexOfCardDeck].cardName,
                            style: TextStyle(
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget showOrHideWinnerImg(String isWon) {
  return isWon == 'false' || isWon == 'draw'  ? Container() : Align(
    alignment: Alignment.topRight,
    child: Padding(
      padding: const EdgeInsets.all(5),
      child: Tada(
        child: SvgPicture.asset(
          'assets/icons/svg/win.svg',
          width: 30,
          height: 30,
        ),
        preferences:
        AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Loop),
      ),

    ),
  );
}

Widget buildCard2(
    BuildContext context,
    int indexOfSelectedCard,
    int indexOfCardDeck,
    List<Cards> cardsList,
    bool isPlayAsP1,
    String isWon) {

  List<List<Attribute>> cardsAttributeListOfP2 = [];
  int cardListSizeForP2 = (cardsList.length / 2).round();
  try {
    if (!isPlayAsP1) {
      for (int i = 0; i < cardListSizeForP2; i++) {
        cardsAttributeListOfP2.add(cardsList[i].attribute);
      }
    } else {
      for (int i = cardListSizeForP2; i < cardsList.length; i++) {
        cardsAttributeListOfP2.add(cardsList[i].attribute);
      }
    }
  } catch (e) {
    print(e);
  }

  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.blueAccent,
        width: 1,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.blueAccent,
          blurRadius: 15.0,
          offset: Offset(5.0, 5.0),
        ),
      ],
    ),
    child: Stack(
      children: [
        Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                Colors.lightBlue,
                Colors.lightBlue[300],
                Colors.lightBlue[300],
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                placeholder: 'assets/images/cricket_1.png',
                image: isPlayAsP1 ? cardsList[cardListSizeForP2 + indexOfCardDeck].cardImg : cardsList[indexOfCardDeck].cardImg,
                height: 145,
                width: 145),
          ),
        ),

        showOrHideWinnerImg(isWon == 'true' || isWon == 'draw'? 'false': 'true'),

        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 0),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              childAspectRatio: 5/3,
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              // if you want IOS bouncing effect, otherwise remove this line
              padding: EdgeInsets.all(2),
              //change the number as you want
              children: List.generate(cardsAttributeListOfP2[indexOfCardDeck].length, (index) {
                return Container(padding: index == indexOfSelectedCard? EdgeInsets.only(left: 3, top: 1):EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: index == indexOfSelectedCard? Colors.white24: Colors.transparent,
                    border: index == indexOfSelectedCard? Border.all(color: Colors.white):Border.all(color: Colors.transparent),
                    borderRadius: index == indexOfSelectedCard? BorderRadius.all(Radius.circular(3)):BorderRadius.all(Radius.circular(0)),
                  ),
                  //margin: EdgeInsets.only(left: 5, right: 5),
                  margin: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeartBeat(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                cardsAttributeListOfP2[indexOfCardDeck][index].value,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                softWrap: false,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'neuropol_x_rg',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: Stack(alignment: Alignment.center, children: <Widget>[
                                SvgPicture.asset(
                                  'assets/icons/svg/star1.svg',
                                  width: 13,
                                  height: 13,
                                ),
                                Text(
                                  cardsAttributeListOfP2[indexOfCardDeck][index].winPoints,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                              ]),
                            ),
                          ],
                        ),
                        preferences: AnimationPreferences(
                            offset: Duration(milliseconds: 3500),
                            duration: const Duration(milliseconds: 1000),
                            autoPlay: AnimationPlayStates.Loop),
                      ),

                      Text(
                        cardsAttributeListOfP2[indexOfCardDeck][index].name,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 8,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'neuropol_x_rg',
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 10, top: 1),
                        child: Divider(
                          color: Colors.white,
                          thickness: 1,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),

        // Player name, flag , image in card

        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 46, top: 12, right: 5, bottom: 3),
              child: RotationTransition(
                alignment: Alignment.topLeft,
                turns: AlwaysStoppedAnimation(90 / 360),
                child: Container(
                  width: SizeConfig.heightMultiplier * 37.5,
                  height: SizeConfig.heightMultiplier * 5.2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ShapeOfView(
                          height: 16,
                          width: 16,
                          shape: CircleShape(borderColor: Colors.white, borderWidth: 1),
                          elevation: 1,
                          child: CircleAvatar(
                            radius: 30,
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/icons/png/white-flag.png',
                              image: isPlayAsP1 ? cardsList[cardListSizeForP2 + indexOfCardDeck].flagImage: cardsList[indexOfCardDeck].flagImage,
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Shimmer.fromColors(
                          baseColor: Colors.white,
                          highlightColor: Colors.orange[800],
                          child: Text(
                            isPlayAsP1 ? cardsList[cardListSizeForP2 + indexOfCardDeck].cardName : cardsList[indexOfCardDeck].cardName,
                            style: TextStyle(
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
