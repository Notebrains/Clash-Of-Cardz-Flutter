import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:trump_card_game/model/responses/cards_res_model.dart';
import 'package:trump_card_game/ui/widgets/animations/spring_button.dart';
import 'package:trump_card_game/ui/widgets/libraries/animated_text_kit/wavy.dart';
import 'package:trump_card_game/ui/widgets/libraries/avatar_glow.dart';
import 'package:trump_card_game/ui/widgets/libraries/f_dotted_line.dart';
import 'package:trump_card_game/ui/widgets/libraries/flip_card.dart';
import 'package:trump_card_game/ui/widgets/libraries/shimmer.dart';
import 'package:flutter_svg/flutter_svg.dart';

void showBothCardsDialog(BuildContext context, List<Cards> cards, int indexOfSelectedCard, int indexOfCardDeck, bool isMatchEnded, bool isPlayAsP1,{
  Function(bool isPlayAgainClicked) onClickActionOnPlayAgain,
}) {
  BuildContext dialogContext;

  showDialog(
    context: context,
    barrierDismissible: false,
    useSafeArea: true,
    builder: (BuildContext context) {
      dialogContext = context;
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
                                          child: RotateInDownRight(
                                            child: isPlayAsP1? buildCard1(
                                              context,
                                              cards,
                                              indexOfCardDeck,
                                              indexOfSelectedCard,
                                              onClickActionOnP1GameplayCard:
                                                  (int indexOfP1Card, String attributeTitle, String attributeValue, String winBasis, String winPoints) => {

                                                  },
                                            ) : buildCard2(
                                              context,
                                              indexOfSelectedCard,
                                              indexOfCardDeck,
                                              cards,
                                              onClickActionOnP2GameplayCard: (bool isWon, int winPoint) =>
                                              {
                                              },
                                            ),
                                            preferences: AnimationPreferences(
                                                duration: const Duration(milliseconds: 1500),
                                                autoPlay: AnimationPlayStates.Forward),
                                          ),
                                        ),

                                        SizedBox(
                                          width: 80,
                                        ),

                                        Container(
                                          width: 220,
                                          height: 315,
                                          child: RollIn(
                                            child: isPlayAsP1 ? buildCard2(
                                              context,
                                              indexOfSelectedCard,
                                              indexOfCardDeck,
                                              cards,
                                              onClickActionOnP2GameplayCard: (bool isWon, int winPoint) =>
                                              {
                                              },
                                            ) : buildCard1(
                                              context,
                                              cards,
                                              indexOfCardDeck,
                                              indexOfSelectedCard,
                                              onClickActionOnP1GameplayCard:
                                                  (int indexOfP1Card, String attributeTitle, String attributeValue, String winBasis, String winPoints) => {

                                              },
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

                                HeartBeat(
                                  child:  Container(
                                    margin: EdgeInsets.only(top: 20),
                                    child: MaterialButton(
                                      padding: EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
                                      splashColor: Colors.grey,
                                      child: Container(
                                        width: 250,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(image: AssetImage('assets/icons/png/bg_button.png'), fit: BoxFit.fill),
                                        ),
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
                                          child: Text(
                                            isMatchEnded ? "PLAY AGAIN" : 'MATCH ENDED',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontStyle: FontStyle.normal,
                                                fontFamily: 'neuropol_x_rg',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87),
                                          ),
                                        ),
                                      ),
                                      // ),
                                      onPressed: () {
                                        onClickActionOnPlayAgain(isMatchEnded);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                  preferences:
                                  AnimationPreferences(duration: const Duration(milliseconds: 2500), autoPlay: AnimationPlayStates.Loop),
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

  /*Timer(Duration(milliseconds: 100000000), () {
    Navigator.pop(dialogContext);

  });*/
}

Widget buildCard1(
    BuildContext context,
    List<Cards> cardsList,
    int indexOfCardDeck,
    int indexOfSelectedCard,
    {
      Function(int p1SelectedIndexOfAttributeList, String attributeTitle, String attributeValue, String winBasis, String winPoints)
      onClickActionOnP1GameplayCard,
    }) {
  List<List<Attribute>> cardsAttributeList = [];

  try {
    //print('----card list1 length ' + (cardsList.length).toString());
    int cardListSize = (cardsList.length / 2).round();
    for (int i = 0; i < cardListSize; i++) {
      cardsAttributeList.add(cardsList[i].attribute);
    }
  } catch (e) {
    print(e);
  }

  return Container(
    decoration: BoxDecoration(
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.white70,
          blurRadius: 15.0,
          offset: Offset(5.0, 5.0),
        ),
      ],
    ),
    child:  Stack(
      children: [
        Container(
          color: Colors.orange,
        ),

        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                placeholder: 'assets/images/cricket_1.png',
                image: cardsList[indexOfCardDeck].cardImg,
                height: 145,
                width: 145
            ),
          ),
        ),

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
              padding: EdgeInsets.all(4),
              //change the number as you want
              children: List.generate(cardsAttributeList[indexOfCardDeck].length, (index) {
                return Container(
                  padding: index == indexOfSelectedCard? EdgeInsets.only(left: 3, top: 1):EdgeInsets.all(0),
                  decoration: BoxDecoration(
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
                              Text(
                                cardsAttributeList[indexOfCardDeck][index].value,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'neuropol_x_rg',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo),
                              ),

                              Stack(alignment: Alignment.center, children: <Widget>[
                                SvgPicture.asset(
                                  'assets/icons/svg/star.svg',
                                  color: Colors.yellow,
                                  width: 15,
                                  height: 15,
                                ),
                                Text(
                                  cardsAttributeList[indexOfCardDeck][index].winPoints,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                              ]),
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
              padding: EdgeInsets.only(left: 25, top: 12, right: 5, bottom: 5),
              child: RotationTransition(
                alignment: Alignment.topLeft,
                turns: new AlwaysStoppedAnimation(90 / 360),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Shimmer.fromColors(
                        baseColor: Colors.white,
                        highlightColor: Colors.orange[300],
                        child: Text(
                          cardsList[indexOfCardDeck].cardName,
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    ShapeOfView(
                      height: 16,
                      width: 16,
                      shape: CircleShape(borderColor: Colors.white, borderWidth: 1),
                      elevation: 1,
                      child: CircleAvatar(
                        radius: 30,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/icons/png/white-flag.png',
                          image: cardsList[indexOfCardDeck].flagImage,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildCard2(
    BuildContext context,
    int indexOfSelectedCard,
    int indexOfCardDeck,
    List<Cards> cardsList, {
      Function(bool isWon, int winPoint) onClickActionOnP2GameplayCard,
    }) {

  List<List<Attribute>> cardsAttributeListOfP2 = [];
  int cardListSizeForP2 = (cardsList.length / 2).round();
  try {
    for (int i = cardListSizeForP2; i < cardsList.length; i++) {
      cardsAttributeListOfP2.add(cardsList[i].attribute);
    }
  } catch (e) {
    print(e);
  }

  return Container(
    decoration: BoxDecoration(
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.white70,
          blurRadius: 15.0,
          offset: Offset(5.0, 5.0),
        ),
      ],
    ),
    child: Stack(
      children: [
        Container(
          color: Colors.orange,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                placeholder: 'assets/images/cricket_2.png',
                image: cardsList[cardListSizeForP2 + indexOfCardDeck].cardImg,
                height: 145,
                width: 145),
          ),
        ),

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
              padding: EdgeInsets.all(3),
              //change the number as you want
              children: List.generate(cardsAttributeListOfP2[indexOfCardDeck].length, (index) {
                return Container(padding: index == indexOfSelectedCard? EdgeInsets.only(left: 3, top: 1):EdgeInsets.all(0),
                  decoration: BoxDecoration(
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
                            Text(
                              cardsAttributeListOfP2[indexOfCardDeck][index].value,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'neuropol_x_rg',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo),
                            ),

                            Stack(alignment: Alignment.center, children: <Widget>[
                              SvgPicture.asset(
                                'assets/icons/svg/star.svg',
                                color: Colors.yellow,
                                width: 15,
                                height: 15,
                              ),
                              Text(
                                cardsAttributeListOfP2[indexOfCardDeck][index].winPoints,
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                            ]),
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
              padding: EdgeInsets.only(left: 25, top: 12, right: 5, bottom: 3),
              child: RotationTransition(
                alignment: Alignment.topLeft,
                turns: new AlwaysStoppedAnimation(90 / 360),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Shimmer.fromColors(
                        baseColor: Colors.white,
                        highlightColor: Colors.orange[800],
                        child: Text(
                          cardsList[cardListSizeForP2 + indexOfCardDeck].cardName,
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    Container(
                      height: 16,
                      width: 16,
                      child: CircleAvatar(
                        radius: 30,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/icons/png/white-flag.png',
                          image: cardsList[cardListSizeForP2 + indexOfCardDeck].flagImage,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}