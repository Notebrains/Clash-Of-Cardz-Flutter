import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:trump_card_game/model/responses/cards_res_model.dart';
import 'package:trump_card_game/ui/widgets/libraries/animated_text_kit/wavy.dart';
import 'package:trump_card_game/ui/widgets/libraries/edge_alert.dart';
import 'package:trump_card_game/ui/widgets/libraries/f_dotted_line.dart';
import 'package:trump_card_game/ui/widgets/libraries/flip_card.dart';
import 'package:trump_card_game/ui/widgets/libraries/shimmer.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget buildCardAsP1(
  BuildContext context,
  bool isPlayAsP1,
  List<Cards> cardsList,
  int indexOfCardDeck, bool isYourTurn, {
  Function(int p1SelectedIndexOfAttributeList, String attributeTitle, String attributeValue, String winBasis, String winPoints)
      onClickActionOnP1GameplayCard,
}) {
  GlobalKey<FlipCardState> cardKeyOfPlayerOne = GlobalKey<FlipCardState>();
  List<List<Attribute>> cardsAttributeList = [];

  try {
    //print('----card list1 length ' + (cardsList.length).toString());
    int cardListSize = (cardsList.length / 2).round();

    if (isPlayAsP1) {
      for (int i = 0; i < cardListSize; i++) {
        cardsAttributeList.add(cardsList[i].attribute);
      }
    } else {
      //set p2 data
      for (int i = cardListSize; i < cardsList.length; i++) {
        cardsAttributeList.add(cardsList[i].attribute);
      }
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
            Center(
              child: FDottedLine(
                color: Colors.white,
                strokeWidth: 2.0,
                dottedLength: 8.0,
                space: 3.0,
                corner: FDottedLineCorner.all(6.0),

                /// add widget
                child: Container(
                  width: 140,
                  height: 80,
                  alignment: Alignment.center,
                  child: HeartBeat(
                    child: Text(
                      'TAP TO \nSELECT A CARD',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    preferences: AnimationPreferences(duration: const Duration(milliseconds: 2500), autoPlay: AnimationPlayStates.Loop),
                  ),
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          
          if (isYourTurn) {
            cardKeyOfPlayerOne.currentState.toggleCard();
          } else {
            EdgeAlert.show(context, title: 'Info', description: 'Please wait for other player turn to play.', gravity: EdgeAlert.TOP);
          }
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
                  placeholder: 'assets/images/cricket_1.png',
                  image: cardsList[indexOfCardDeck].cardImg,
                  height: 135,
                  width: 135),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: 200,
              height: 25,
              child: BounceInLeft(
                child: WavyAnimatedTextKit(
                  textStyle: TextStyle(fontSize: 12.0, color: Colors.white, fontWeight: FontWeight.normal),
                  text: ['*Select a stats to play'],
                  isRepeatingAnimation: true,
                ),
                preferences: AnimationPreferences(duration: const Duration(milliseconds: 3000), autoPlay: AnimationPlayStates.Forward),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 20, left: 5),
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
                                  fontSize: 9,
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
                            cardsAttributeList[indexOfCardDeck][index].name,
                            cardsAttributeList[indexOfCardDeck][index].value,
                            cardsAttributeList[indexOfCardDeck][index].winBasis,
                            cardsAttributeList[indexOfCardDeck][index].winPoints,
                          );
                        },
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
                padding: EdgeInsets.only(left: 25, top: 5, right: 5, bottom: 5),
                child: RotationTransition(
                  alignment: Alignment.topLeft,
                  turns: new AlwaysStoppedAnimation(90 / 360),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Shimmer.fromColors(
                          baseColor: Colors.white,
                          highlightColor: Colors.grey[400],
                          child: Text(
                            cardsList[indexOfCardDeck].cardName,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      ShapeOfView(
                        height: 17,
                        width: 17,
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

Widget buildSecondCard(BuildContext context, int p1SelectedIndexOfAttributeList, int indexOfCardDeck, List<Cards> cardsList) {
  GlobalKey<FlipCardState> cardKeyOfPlayerTwo = GlobalKey<FlipCardState>();
  List<List<Attribute>> cardsAttributeListOfP2 = [];
  List<List<Attribute>> cardsAttributeList = [];
  int cardListSizeForP2 = (cardsList.length / 2).round();
  //int indexOfCardDeckForP2 = cardListSizeForP2 + indexOfCardDeck;

  try {
    //print('-----flagImage ' + cardsList[cardListSizeForP2 + indexOfCardDeck].flagImage);

    for (int i = 0; i < cardListSizeForP2; i++) {
      cardsAttributeList.add(cardsList[i].attribute);
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
            Center(
              child: FDottedLine(
                color: Colors.white,
                strokeWidth: 2.0,
                dottedLength: 8.0,
                space: 3.0,
                corner: FDottedLineCorner.all(6.0),

                /// add widget
                child: Container(
                  width: 100,
                  height: 50,
                  alignment: Alignment.center,
                  child: HeartBeat(
                    child: Text(
                      'P-2 CARD',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    preferences: AnimationPreferences(duration: const Duration(milliseconds: 2500), autoPlay: AnimationPlayStates.Loop),
                  ),
                ),
              ),
            ),
          ],
        ),
        onTap: () {
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
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ShapeOfView(
                height: 22,
                width: 22,
                shape: CircleShape(borderColor: Colors.white, borderWidth: 1),
                elevation: 1,
                child: CircleAvatar(
                  radius: 30,
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/icons/png/white-flag.png',
                    image: cardsList[cardListSizeForP2 + indexOfCardDeck].flagImage,
                  ),
                ),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    placeholder: 'assets/images/cricket_1.png',
                    image: cardsList[indexOfCardDeck].cardImg,
                    height: 135,
                    width: 135),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.white,
                  highlightColor: Colors.grey[400],
                  child: Text(
                    cardsList[cardListSizeForP2 + indexOfCardDeck].cardName,
                    textAlign:TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 17,
                    ),
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

Widget buildCardAsP2(
  BuildContext context,
  int p1SelectedIndexOfAttributeList,
  int indexOfCardDeck,
  List<Cards> cardsList, {
  Function(bool isWon, int winPoint) onClickActionOnP2GameplayCard,
}) {
  List<List<Attribute>> cardsAttributeListOfP2 = [];
  List<List<Attribute>> cardsAttributeList = [];
  int cardListSizeForP2 = (cardsList.length / 2).round();

  try {
    //print('-----flagImage ' + cardsList[cardListSizeForP2 + indexOfCardDeck].flagImage);

    for (int i = 0; i < cardListSizeForP2; i++) {
      cardsAttributeList.add(cardsList[i].attribute);
    }

    for (int i = cardListSizeForP2; i < cardsList.length; i++) {
      cardsAttributeListOfP2.add(cardsList[i].attribute);
    }
  } catch (e) {
    print(e);
  }

  return Container(
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
                height: 140,
                width: 140),
          ),
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 200,
            height: 25,
            child: WavyAnimatedTextKit(
              textStyle: TextStyle(fontSize: 12.0, color: Colors.white, fontWeight: FontWeight.normal),
              text: [
                '*Computer automatically select stats',
              ],
              isRepeatingAnimation: true,
            ),
          ),
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 30),
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
              children: List.generate(cardsAttributeListOfP2[indexOfCardDeck].length, (index) {
                return Container(
                  //margin: EdgeInsets.only(left: 5, right: 5),
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 1),
                  child: InkWell(
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
                              fontSize: 9,
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
                      /* //p1 and p2 card will be touched in same position. So both index will be same.

                        if(cardsAttributeList[indexOfCardDeck][index].name == cardsAttributeListOfP2[indexOfCardDeck][index].name){
                          p1SelectedAttributeValue = 0;
                          p2SelectedAttributeValue = 0;
                          winPoint = 0;

                          p1SelectedAttributeValue = int.parse(cardsAttributeList[indexOfCardDeck][index].value);
                          p2SelectedAttributeValue = int.parse(cardsAttributeListOfP2[indexOfCardDeck][index].value);

                          if(cardsAttributeList[indexOfCardDeck][index].winBasis == 'Highest Value'){
                            if(p1SelectedAttributeValue > p2SelectedAttributeValue){
                              isPlayer1Won = true;
                              winPoint = int.parse(cardsAttributeList[indexOfCardDeck][index].winPoints);
                            } else {
                              isPlayer1Won = false;
                              winPoint = int.parse(cardsAttributeListOfP2[indexOfCardDeck][index].winPoints);
                            }

                          } else if (cardsAttributeList[indexOfCardDeck][index].winBasis == 'Lowest Value'){
                            if(p1SelectedAttributeValue < p2SelectedAttributeValue){
                              isPlayer1Won = true;
                              winPoint = int.parse(cardsAttributeList[indexOfCardDeck][index].winPoints);
                            } else {
                              isPlayer1Won = false;
                              winPoint = int.parse(cardsAttributeListOfP2[indexOfCardDeck][index].winPoints);
                            }
                          }


                          print('----indexOfCardDeck ' + indexOfCardDeck.toString());
                          print('----p1SelectedIndexOfAttributeList ' + p1SelectedIndexOfAttributeList.toString());
                          print('----p2SelectedIndexOfAttributeList ' + index.toString());
                          print('----P1 attr name ' + cardsAttributeList[indexOfCardDeck][index].name);
                          print('----P1 attr value ' + cardsAttributeList[indexOfCardDeck][index].value);
                          print('----P2 attr name ' + cardsAttributeListOfP2[indexOfCardDeck][index].name);
                          print('----P2 attr value ' + cardsAttributeListOfP2[indexOfCardDeck][index].value);
                          print('----win Point ' + winPoint.toString());

                          onClickActionOnP2GameplayCard(
                              isPlayer1Won,
                              winPoint
                          );
                        }
                        else {
                          showWrongSelectionDialog(context, cardsAttributeList[indexOfCardDeck][index].name);
                        }*/
                    },
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
              padding: EdgeInsets.only(left: 25, top: 5, right: 5, bottom: 5),
              child: RotationTransition(
                alignment: Alignment.topLeft,
                turns: new AlwaysStoppedAnimation(90 / 360),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Shimmer.fromColors(
                        baseColor: Colors.white,
                        highlightColor: Colors.grey[300],
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
