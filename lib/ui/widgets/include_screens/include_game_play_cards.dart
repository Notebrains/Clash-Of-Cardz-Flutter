import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:trump_card_game/model/responses/cards_res_model.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_game_play_dialogs.dart';
import 'package:trump_card_game/ui/widgets/libraries/flip_card.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

Widget buildPlayerOneCard(
    BuildContext context,
    List<Cards> cardsList,
    int indexOfCardDeck,
    {
      Function(int p1SelectedIndexOfAttributeList, String attributeTitle, String attributeValue) onClickActionOnP1GameplayCard,
    }) {
  //final List<String> matches = ['150', '250', '350', '50', '508', '113', '222', '321'];
  //final List<String> cardRatingList = ['4', '2', '3', '5', '3', '4', '2', '5'];
  GlobalKey<FlipCardState> cardKeyOfPlayerOne = GlobalKey<FlipCardState>();
  List<List<Attribute>> cardsAttributeListP1 = [];

  try {
    //print('----card list1 length ' + (cardsList.length).toString());

    for (int i = 0; i < (cardsList.length/2).round(); i++) {
      cardsAttributeListP1.add(cardsList[i].attribute);
    }
  } catch (e) {
    print(e);
  }

  return FlipCard(
    flipOnTouch: false,
    direction: FlipDirection.HORIZONTAL,
    speed: 1000,
    key: cardKeyOfPlayerOne,
    onFlipDone: (status) {
      //print(status);
    },
    front: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 30.0,
            offset: Offset(0.0, 30.0),
          ),
        ],
      ),
      child: GestureDetector(
        child: Stack(
          children: <Widget>[
            Container(
              width: getScreenWidth(context),
              height: getScreenHeight(context),
              color: Colors.deepOrangeAccent,
              //child: Image.asset('assets/images/bg_card_back.png', fit: BoxFit.fill),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.center,
                child: Lottie.asset('assets/animations/lottiefiles/touch-screen.json', width: 250, height: 270),
              ),
            ),
          ],
        ),
        onTap: () {
          cardKeyOfPlayerOne.currentState.toggleCard();
        },
      ),
    ),
    back: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x60000000),
            blurRadius: 30.0,
            offset: Offset(0.0, 30.0),
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
                  height: 150,
                  width: 150
              ),
            ),
          ),

          //child: Lottie.asset('assets/animations/lottiefiles/confused_robot-bot-3d.json', height: 150, width: 150)),

          Align(
            alignment: Alignment.bottomCenter,
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
              children: List.generate(cardsAttributeListP1[indexOfCardDeck].length, (index) {
                return Container(
                  //margin: EdgeInsets.only(left: 5, right: 5),
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 1),
                  child: Material(
                    color: Colors.transparent,
                    borderOnForeground: true,
                    child: InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                cardsAttributeListP1[indexOfCardDeck][index].value,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 9,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'neuropol_x_rg',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo),
                              ),
                              Stack(alignment: Alignment.center, children: <Widget>[
                                Image.asset(
                                  'assets/icons/png/stars.png',
                                  color: Colors.yellow,
                                ),
                                Text(
                                  cardsAttributeListP1[indexOfCardDeck][index].winPoints,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                              ]),
                            ],
                          ),
                          Text(
                            cardsAttributeListP1[indexOfCardDeck][index].name,
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
                      onTap: () {
                        onClickActionOnP1GameplayCard(
                            index,
                            cardsAttributeListP1[indexOfCardDeck][index].name,
                            cardsAttributeListP1[indexOfCardDeck][index].value
                        );
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25, top: 5),
                child: RotationTransition(
                  alignment: Alignment.topLeft,
                  turns: new AlwaysStoppedAnimation(90 / 360),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Text(
                          cardsList[indexOfCardDeck].cardName,
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            color: Colors.white,
                            fontSize: 16,
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
    ),
  );
}

Widget buildPlayerTwoCard(
    BuildContext context,
    int p1SelectedIndexOfAttributeList,
    int indexOfCardDeck,
    List<Cards> cardsList, {
      Function(bool isWon, int winPoint) onClickActionOnP2GameplayCard,
    }) {

  GlobalKey<FlipCardState> cardKeyOfPlayerTwo = GlobalKey<FlipCardState>();
  List<List<Attribute>> cardsAttributeListOfP2 = [];
  List<List<Attribute>> cardsAttributeListP1 = [];
  int indexOfP2Card = 0;
  bool isPlayer1Won = false;
  int p1SelectedAttributeValue = 0;
  int p2SelectedAttributeValue = 0;
  int winPoint = 0;
  int cardListSizeForP2 = (cardsList.length / 2).round();
  //int indexOfCardDeckForP2 = cardListSizeForP2 + indexOfCardDeck;

  try {
    print('-----flagImage ' + cardsList[cardListSizeForP2 + indexOfCardDeck].flagImage);

    for (int i = 0; i < cardListSizeForP2; i++) {
      cardsAttributeListP1.add(cardsList[i].attribute);
    }

    for (int i = cardListSizeForP2; i < cardsList.length; i++) {
      cardsAttributeListOfP2.add(cardsList[i].attribute);
    }
  } catch (e) {
    print(e);
  }

  return FlipCard(
    flipOnTouch: false,
    direction: FlipDirection.HORIZONTAL,
    speed: 1000,
    key: cardKeyOfPlayerTwo,
    onFlipDone: (status) {
    },

    front: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 30.0,
            offset: Offset(0.0, 30.0),
          ),
        ],
      ),
      child: InkWell(
        child: Stack(
          children: <Widget>[
            Container(
              width: getScreenWidth(context),
              height: getScreenHeight(context),
              color: Colors.deepOrangeAccent,
              //child: Image.asset('assets/images/bg_card_back.png', fit: BoxFit.fill),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Align(
                  alignment: Alignment.center,
                  child: Lottie.asset('assets/animations/lottiefiles/touch-screen.json', width: 250, height: 270),
                ),
            )

          ],
        ),

        onTap: (){
          cardKeyOfPlayerTwo.currentState.toggleCard();
        },
      ),
    ),

    back: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x60000000),
            blurRadius: 30.0,
            offset: Offset(0.0, 30.0),
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
                  height: 150,
                  width: 150),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              childAspectRatio: 5/3,
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              // if you want IOS bouncing effect, otherwise remove this line
              padding: EdgeInsets.all(4),
              //change the number as you want
              children: List.generate(cardsAttributeListOfP2[indexOfCardDeck].length, (index) {
                return Container(
                  //margin: EdgeInsets.only(left: 5, right: 5),
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 1),
                  child: InkWell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              cardsAttributeListOfP2[indexOfCardDeck][index].value,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 9,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'neuropol_x_rg',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo),
                            ),
                            Stack(alignment: Alignment.center, children: <Widget>[
                              Image.asset(
                                'assets/icons/png/stars.png',
                                color: Colors.yellow,
                              ),
                              Text(
                                cardsAttributeListOfP2[indexOfCardDeck][index].winPoints,
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                            ]),
                          ],
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

                    onTap: (){
                      //p1 and p2 card will be touched in same position. So both index will be same.

                      if(cardsAttributeListP1[indexOfCardDeck][index].name == cardsAttributeListOfP2[indexOfCardDeck][index].name){
                        p1SelectedAttributeValue = 0;
                        p2SelectedAttributeValue = 0;
                        winPoint = 0;

                        p1SelectedAttributeValue = int.parse(cardsAttributeListP1[indexOfCardDeck][index].value);
                        p2SelectedAttributeValue = int.parse(cardsAttributeListOfP2[indexOfCardDeck][index].value);

                        if(cardsAttributeListP1[indexOfCardDeck][index].winBasis == 'Highest Value'){
                          if(p1SelectedAttributeValue > p2SelectedAttributeValue){
                            isPlayer1Won = true;
                            winPoint = int.parse(cardsAttributeListP1[indexOfCardDeck][index].winPoints);
                          } else {
                            isPlayer1Won = false;
                            winPoint = int.parse(cardsAttributeListOfP2[indexOfCardDeck][index].winPoints);
                          }

                        } else if (cardsAttributeListP1[indexOfCardDeck][index].winBasis == 'Lowest Value'){
                          if(p1SelectedAttributeValue < p2SelectedAttributeValue){
                            isPlayer1Won = true;
                            winPoint = int.parse(cardsAttributeListP1[indexOfCardDeck][index].winPoints);
                          } else {
                            isPlayer1Won = false;
                            winPoint = int.parse(cardsAttributeListOfP2[indexOfCardDeck][index].winPoints);
                          }
                        }


                        print('----indexOfCardDeck ' + indexOfCardDeck.toString());
                        print('----p1SelectedIndexOfAttributeList ' + p1SelectedIndexOfAttributeList.toString());
                        print('----p2SelectedIndexOfAttributeList ' + index.toString());
                        print('----P1 attr name ' + cardsAttributeListP1[indexOfCardDeck][index].name);
                        print('----P1 attr value ' + cardsAttributeListP1[indexOfCardDeck][index].value);
                        print('----P2 attr name ' + cardsAttributeListOfP2[indexOfCardDeck][index].name);
                        print('----P2 attr value ' + cardsAttributeListOfP2[indexOfCardDeck][index].value);
                        print('----win Point ' + winPoint.toString());

                        onClickActionOnP2GameplayCard(
                            isPlayer1Won,
                            winPoint
                        );
                      }
                      else {
                        showWrongSelectionDialog(context, cardsAttributeListP1[indexOfCardDeck][index].name);
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          // Player name, flag , image in card
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25, top: 5),
                child: RotationTransition(
                  alignment: Alignment.topLeft,
                  turns: new AlwaysStoppedAnimation(90 / 360),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Text(
                          cardsList[cardListSizeForP2 + indexOfCardDeck].cardName,
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            color: Colors.white,
                            fontSize: 16,
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
    ),
  );
}
