import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:trump_card_game/model/responses/cards_res_model.dart';
import 'package:trump_card_game/model/state_managements/autoplay_states_model.dart';
import 'package:trump_card_game/ui/widgets/libraries/flip_card.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

Widget buildPlayerOneCard(
  BuildContext context,
  List<Cards> cardsList, {
  Function(int indexOfP1Card, String attributeTitle, String attributeValue, String cardId) onClickAction,
}) {
  //final List<String> matches = ['150', '250', '350', '50', '508', '113', '222', '321'];
  //final List<String> cardRatingList = ['4', '2', '3', '5', '3', '4', '2', '5'];
  GlobalKey<FlipCardState> cardKeyOfPlayerOne = GlobalKey<FlipCardState>();
  List<List<Attribute>> cardsAttributeListP1 = [];

  try {
    print('----card list1 length ' + (cardsList.length).toString());

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
                child: Image.asset('assets/images/bg_card_back.png', fit: BoxFit.fill),
            ),

            /*Align(
              alignment: Alignment.center,
              child: Lottie.asset('assets/animations/lottiefiles/sports-loading.json', width: 250, height: 250),
            )*/

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
      child: Consumer<AutoPlayStatesModel>(
        builder: (context, statesModel, child) => GestureDetector(
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
                      placeholder: 'assets/animations/gifs/loading.gif',
                      image: cardsList[0].cardImg,
                      height: 150,
                      width: 150),
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
                  children: List.generate(cardsAttributeListP1[0].length, (index) {
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
                                    cardsAttributeListP1[0][index].value,
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
                                      cardsAttributeListP1[0][index].winPoints,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold, color: Colors.black),
                                    ),
                                  ]),
                                ],
                              ),
                              Text(
                                cardsAttributeListP1[0][index].name,
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
                            onClickAction(
                                index,
                                cardsAttributeListP1[0][index].name,
                                cardsAttributeListP1[0][index].value,
                                '0PLY002'
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
                              cardsList[0].cardName,
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
                            child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              placeholder: '',
                              //placeholder: 'assets/animations/gifs/loading.gif',
                              image: cardsList[0].flagImage,
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
          onTap: () {
            /*if (statesModel.isCardTwoTouched) {
              cardKeyOfPlayerOne.currentState.toggleCard();
            }*/
          },
        ),
      ),
    ),
  );
}

Widget buildPlayerTwoCard(
  BuildContext context,
  int indexOfP1Card,
  List<Cards> cardsList, {
  Function(int index, bool isWon, int winPoint) onClickActionP2,
}) {

  GlobalKey<FlipCardState> cardKeyOfPlayerTwo = GlobalKey<FlipCardState>();
  List<List<Attribute>> cardsAttributeListOfP2 = [];
  List<List<Attribute>> cardsAttributeListP1 = [];
  int indexOfP2Card = 0;
  bool isPlayer1Won = false;
  int p1SelectedAttributeValue = 0;
  int p2SelectedAttributeValue = 0;
  int winPoint = 0;

  try {
    //print('----card list2 length ' + (cardsList.length/2).round().toString());

    for (int i = 0; i < (cardsList.length / 2).round(); i++) {
      cardsAttributeListP1.add(cardsList[i].attribute);
    }

    for (int i = (cardsList.length / 2).round(); i < cardsList.length; i++) {
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
      //p1 and p2 card will be touched in same position. So both index will be same.
      print('----indexOfP1Card ' + indexOfP1Card.toString());
      print('----P1 attr value ' + cardsAttributeListP1[0][indexOfP1Card].value);
      print('----P2 attr value ' + cardsAttributeListOfP2[0][indexOfP1Card].value);

      p1SelectedAttributeValue = int.parse(cardsAttributeListP1[0][indexOfP1Card].value);
      p2SelectedAttributeValue = int.parse(cardsAttributeListOfP2[0][indexOfP1Card].value);


      if(cardsAttributeListP1[0][indexOfP1Card].winBasis == 'Highest Value'){

        if(p1SelectedAttributeValue > p2SelectedAttributeValue){
          isPlayer1Won = true;
          winPoint = int.parse(cardsAttributeListP1[0][indexOfP1Card].winPoints);
        } else {
          isPlayer1Won = false;
          winPoint = int.parse(cardsAttributeListOfP2[0][indexOfP1Card].winPoints);
        }

      } else if (cardsAttributeListP1[0][indexOfP1Card].winBasis == 'Lowest Value'){
        if(p1SelectedAttributeValue < p2SelectedAttributeValue){
          isPlayer1Won = true;
          winPoint = int.parse(cardsAttributeListP1[0][indexOfP1Card].winPoints);
        } else {
          isPlayer1Won = false;
          winPoint = int.parse(cardsAttributeListOfP2[0][indexOfP1Card].winPoints);
        }
      }

      if(p1SelectedAttributeValue > p2SelectedAttributeValue && cardsAttributeListP1[0][indexOfP1Card].winBasis == 'Highest Value'){
        isPlayer1Won = true;

      } else if (p1SelectedAttributeValue < p2SelectedAttributeValue && cardsAttributeListP1[0][indexOfP1Card].winBasis == 'Lowest Value'){
        isPlayer1Won = true;
      }

      onClickActionP2(
          indexOfP1Card,
          isPlayer1Won,
          winPoint
      );
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
      child: Stack(
        children: <Widget>[
          Container(
              width: getScreenWidth(context),
              height: getScreenHeight(context),
              child: Image.asset('assets/images/bg_card_back.png', fit: BoxFit.fill),
          ),

          /*Align(
              alignment: Alignment.center,
              child: Lottie.asset('assets/animations/lottiefiles/sports-loading.json', width: 250, height: 250),
            )*/

        ],
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
                  placeholder: 'assets/animations/gifs/loading.gif',
                  image: cardsList[7 + 0].cardImg,
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
              children: List.generate(cardsAttributeListOfP2[0].length, (index) {
                return Container(
                  //margin: EdgeInsets.only(left: 5, right: 5),
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            cardsAttributeListOfP2[0][index].value,
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
                              cardsAttributeListOfP2[0][index].winPoints,
                              textAlign: TextAlign.right,
                              style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                          ]),
                        ],
                      ),

                      Text(
                        cardsAttributeListOfP2[0][index].name,
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
                          cardsList[7 + 0].cardName,
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
                          backgroundImage: NetworkImage(cardsList[7 + 0].flagImage),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          doFlip(cardKeyOfPlayerTwo),
        ],
      ),
    ),
  );
}

Widget doFlip(GlobalKey<FlipCardState> cardKeyOfPlayerTwo) {
  return Consumer<AutoPlayStatesModel>(builder: (context, statesModel, _) {
    Timer(Duration(milliseconds: 999), () {
      if (statesModel.isCardOneTouched) {
        //print('----- ${statesModel.isCardTwoTouched}');
        cardKeyOfPlayerTwo.currentState.toggleCard();
      }
    });
    return Container();
  });
}
