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
      Function(String index, String attributeTitle, String attributeValue, String cardId) onClickAction,
    }) {
  final List<String> matches = ['150', '250', '350', '50', '508', '113', '222', '321'];
  final List<String> cardRatingList = ['4', '2', '3', '5', '3', '4', '2', '5'];
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  List<List<Attribute>> cardsAttributeList = [];

  for (var attributes in cardsList) {
    cardsAttributeList.add(attributes.attribute);
  }

  return FlipCard(
    flipOnTouch: false,
    direction: FlipDirection.HORIZONTAL,
    speed: 1000,
    key: cardKey,
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
                child: Image.asset('assets/images/bg_card_back.png', fit: BoxFit.fill)),
            /*Align(
              alignment: Alignment.center,
              child: Lottie.asset('assets/animations/lottiefiles/sports-loading.json', width: 250, height: 250),
            )*/
          ],
        ),
        onTap: () {
          cardKey.currentState.toggleCard();
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

              Align(alignment: Alignment.topRight, child: Image.asset('assets/images/cricket_1.png', height: 150, width: 150)),

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
                  children: List.generate(cardsAttributeList[0].length, (index) {
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
                                cardsAttributeList[0][index].value,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 9,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'neuropol_x_rg',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo),
                              ),
                              Stack(children: <Widget>[
                                Image.asset(
                                  'assets/icons/png/stars.png',
                                  color: Colors.yellow,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5.5, top: 4),
                                  child: Text(
                                    //cardsAttributeList[0][index].winPoints,
                                    cardRatingList[index],
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.black),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                          GestureDetector(
                            child: Text(
                              cardsAttributeList[0][index].name,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 8,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'neuropol_x_rg',
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                            onTap: () {
                              onClickAction(index.toString(), cardsAttributeList[0][index].name,
                                  cardsAttributeList[0][index].value, '0PLY002');
                            },
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
                            child: Image.asset(
                              "assets/icons/png/india.png",
                              fit: BoxFit.cover,
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
            if (statesModel.isCardTwoTouched) {
              cardKey.currentState.toggleCard();
            }
          },
        ),
      ),
    ),
  );
}

Widget buildPlayerTwoCard(
    BuildContext context,
    List<Cards> cardsList, {
      Function(String index, String attributeTitle, String attributeValue, String cardId) onClickActionP2,
    }) {
  final List<String> matches = ['150', '250', '350', '50', '508', '113', '222', '321'];
  final List<String> cardRatingList = ['4', '2', '3', '5', '3', '4', '2', '5'];
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  List<List<Attribute>> cardsAttributeList = [];

  for (var attributes in cardsList) {
    cardsAttributeList.add(attributes.attribute);
  }

  return FlipCard(
    flipOnTouch: false,
    direction: FlipDirection.HORIZONTAL,
    speed: 1000,
    key: cardKey,
    onFlipDone: (status) {
      onClickActionP2('0', 'Match', '11', '0PLY002');
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
                child: Image.asset('assets/images/bg_card_back.png', fit: BoxFit.fill)),
            /*Align(
              alignment: Alignment.center,
              child: Lottie.asset('assets/animations/lottiefiles/sports-loading.json', width: 250, height: 250),
            )*/
          ],
        ),
        onTap: () {
          cardKey.currentState.toggleCard();
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
        builder: (context, statesModel, child) => Stack(
          children: [
            Container(
              color: Colors.orange,
            ),
            Align(alignment: Alignment.topRight, child: Image.asset('assets/images/cricket_2.png', height: 150, width: 150)),
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
                children: List.generate(cardsAttributeList[0].length, (index) {
                  return Container(
                    //margin: EdgeInsets.only(left: 5, right: 5),
                    margin: EdgeInsets.symmetric(vertical: 1, horizontal: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              cardsAttributeList[0][index].value,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 9,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'neuropol_x_rg',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo),
                            ),
                            Stack(children: <Widget>[
                              Image.asset(
                                'assets/icons/png/stars.png',
                                color: Colors.yellow,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5.5, top: 4),
                                child: Text(
                                  cardRatingList[index],
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                              ),
                            ]),
                          ],
                        ),
                        Text(
                          cardsAttributeList[0][index].name,
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
                          child: Image.asset(
                            "assets/icons/png/india.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            doFlip(cardKey, statesModel),
          ],
        ),
      ),
    ),
  );
}

Widget doFlip(GlobalKey<FlipCardState> cardKey, AutoPlayStatesModel statesModel) {
  try {
    Timer(Duration(seconds: 1), () {
      if (statesModel.isCardOneTouched) {
        statesModel.isCardOneTouched = false;
        cardKey.currentState.toggleCard();
      }
    });
  } catch (e) {
    print(e);
  }

  return Container();
}
