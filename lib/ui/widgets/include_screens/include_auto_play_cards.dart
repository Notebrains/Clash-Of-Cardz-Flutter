import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:lottie/lottie.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:trump_card_game/helper/constantvalues/constants.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:trump_card_game/model/responses/cards_res_model.dart';
import 'package:trump_card_game/ui/widgets/libraries/animated_text_kit/wavy.dart';
import 'package:trump_card_game/ui/widgets/libraries/f_dotted_line.dart';
import 'package:trump_card_game/ui/widgets/libraries/flip_card.dart';
import 'package:trump_card_game/ui/widgets/libraries/flutter_toast.dart';
import 'package:trump_card_game/ui/widgets/libraries/shimmer.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget buildPlayerOneCard(
    BuildContext context,
    List<Cards> cardsList,
    int indexOfCardDeck,
    bool isPlayerTurn,
    String whoIsPlaying,
    int indexOfCardDeckSelectForComputer,
    { Function(int p1SelectedIndexOfAttributeList, bool isWon, int winPoint, bool isFlipped) onClickActionOnP1AutoPlayCard}) {
  GlobalKey<FlipCardState> cardKeyOfPlayerOne = GlobalKey<FlipCardState>();
  List<List<Attribute>> cardsAttributeListP1 = [];
  List<List<Attribute>> cardsAttributeListOfP2 = [];
  bool isPlayer1Won = false;
  int p1SelectedAttributeValue = 0;
  int p2SelectedAttributeValue = 0;
  int winPoint = 0;
  int cardListSizeForP2 = (cardsList.length / 2).round();
  final ValueNotifier<int> isButtonTappedValueNotify = ValueNotifier<int>(77);

  try {
    for (int i = 0; i < (cardsList.length/2).round(); i++) {
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
    key: cardKeyOfPlayerOne,
    onFlipDone: (status) {
      if (whoIsPlaying == 'player') {
        onClickActionOnP1AutoPlayCard(0, false, 0, true);
      } if (isPlayerTurn && whoIsPlaying == 'computer') {
        p1SelectedAttributeValue = double.parse(cardsAttributeListP1[indexOfCardDeck][indexOfCardDeckSelectForComputer].value).toInt();
        p2SelectedAttributeValue = double.parse(cardsAttributeListOfP2[indexOfCardDeck][indexOfCardDeckSelectForComputer].value).toInt();
        String p1CardStatsTitle = cardsAttributeListP1[indexOfCardDeck][indexOfCardDeckSelectForComputer].name;
        String p2CardStatsTitle = cardsAttributeListOfP2[indexOfCardDeck][indexOfCardDeckSelectForComputer].name;
        int winPoint = int.parse(cardsAttributeListP1[indexOfCardDeck][indexOfCardDeckSelectForComputer].winPoints);

        if (p1CardStatsTitle == p2CardStatsTitle) {
          if(cardsAttributeListP1[indexOfCardDeck][indexOfCardDeckSelectForComputer].winBasis == 'Highest Value'){
            p1SelectedAttributeValue > p2SelectedAttributeValue? isPlayer1Won = true:isPlayer1Won = false;

          } else if (cardsAttributeListP1[indexOfCardDeck][indexOfCardDeckSelectForComputer].winBasis == 'Lowest Value'){
            p1SelectedAttributeValue < p2SelectedAttributeValue ? isPlayer1Won = true:isPlayer1Won = false;
          }

          Future.delayed(Duration(milliseconds: 1200),(){
            onClickActionOnP1AutoPlayCard(indexOfCardDeckSelectForComputer, isPlayer1Won, winPoint, true);
          });
        }
      }
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
        child:  Stack(
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

                child: Container(
                  width: 140,
                  height: 100,
                  alignment: Alignment.center,
                  child: HeartBeat(
                    child: Text(
                      whoIsPlaying == 'player' ? Constants.p1CardText1 : Constants.p1CardText4,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                        fontSize: 12,
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
            color: Colors.orange[600],
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

          ValueListenableBuilder(
            builder: (BuildContext context, int tapIndex, Widget child) {
              return Align(
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
                    padding: EdgeInsets.all(2),
                    //change the number as you want
                    children: List.generate(cardsAttributeListP1[indexOfCardDeck].length, (index) {
                      return Container(
                        padding: index == indexOfCardDeckSelectForComputer || index == isButtonTappedValueNotify.value? EdgeInsets.only(left: 3, top: 1):EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: index == indexOfCardDeckSelectForComputer || index == isButtonTappedValueNotify.value? Colors.white24: Colors.orange[600],
                          border: index == indexOfCardDeckSelectForComputer || index == isButtonTappedValueNotify.value? Border.all(color: Colors.white):Border.all(color: Colors.transparent),
                          borderRadius: index == indexOfCardDeckSelectForComputer || index == isButtonTappedValueNotify.value? BorderRadius.all(Radius.circular(3)):BorderRadius.all(Radius.circular(0)),
                        ),
                        //margin: EdgeInsets.only(left: 5, right: 5),
                        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 1),
                        child: Material(
                          color: Colors.transparent,
                          borderOnForeground: true,
                          child: InkWell(
                            highlightColor: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeartBeat(
                                  child: Row(
                                    children: [
                                      Text(
                                        cardsAttributeListP1[indexOfCardDeck][index].value,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontStyle: FontStyle.normal,
                                            fontFamily: 'neuropol_x_rg',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.indigo),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 2),
                                        child: Stack(alignment: Alignment.center, children: <Widget>[
                                          SvgPicture.asset(
                                            'assets/icons/svg/star1.svg',
                                            width: 13,
                                            height: 13,
                                          ),
                                          Text(
                                            cardsAttributeListP1[indexOfCardDeck][index].winPoints,
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
                                  cardsAttributeListP1[indexOfCardDeck][index].name,
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
                              isButtonTappedValueNotify.value = index;
                              if (isPlayerTurn) {
                                //p1 and p2 card will be touched in same position. So both index will be same.
                                p1SelectedAttributeValue = 0;
                                p2SelectedAttributeValue = 0;
                                winPoint = 0;

                                if(whoIsPlaying == 'player'){
                                  onClickActionOnP1AutoPlayCard(index, false, 0, false);
                                }
                              }
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
            valueListenable: isButtonTappedValueNotify,
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
                        elevation: 4,
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
    List<Cards> cardsList,
    bool isComputerTurn,
    String whoIsPlaying,
    int indexOfCardDeckSelectForComputer,
    bool isFlipped,
    bool isP1SelectedStats,{
      Function(bool isWon, int winPoint) onClickActionOnP2AutoPlayCard,
    }) {

  GlobalKey<FlipCardState> cardKeyOfPlayerTwo = GlobalKey<FlipCardState>();
  List<List<Attribute>> cardsAttributeListOfP2 = [];
  List<List<Attribute>> cardsAttributeListP1 = [];
  bool isPlayer1Won = false;
  int p1SelectedAttributeValue = 0;
  int p2SelectedAttributeValue = 0;
  int winPoint = 0;
  int cardListSizeForP2 = (cardsList.length / 2).round();
  //int indexOfCardDeckForP2 = cardListSizeForP2 + indexOfCardDeck;

  try {
    //print('-----flagImage ' + cardsList[cardListSizeForP2 + indexOfCardDeck].flagImage);

    for (int i = 0; i < cardListSizeForP2; i++) {
      cardsAttributeListP1.add(cardsList[i].attribute);
    }

    for (int i = cardListSizeForP2; i < cardsList.length; i++) {
      cardsAttributeListOfP2.add(cardsList[i].attribute);
    }
  } catch (e) {
    print(e);
  }

  Widget doFlip(bool isComputerTurn, GlobalKey<FlipCardState> cardKeyOfPlayerTwo) {
    //p1 and p2 card will be touched in same position. So both index will be same.
    p1SelectedAttributeValue = 0;
    p2SelectedAttributeValue = 0;
    winPoint = 0;

    if(whoIsPlaying == 'computer' && isP1SelectedStats){
      Future.delayed(Duration(seconds: 2),(){
        cardKeyOfPlayerTwo.currentState.toggleCard();

        onClickActionOnP2AutoPlayCard(
            isPlayer1Won,
            winPoint
        );
      });

    } else if (isComputerTurn && whoIsPlaying == 'player' && isP1SelectedStats) {
      p1SelectedAttributeValue = double.parse(cardsAttributeListP1[indexOfCardDeck][p1SelectedIndexOfAttributeList].value).toInt();
      p2SelectedAttributeValue = double.parse(cardsAttributeListOfP2[indexOfCardDeck][p1SelectedIndexOfAttributeList].value).toInt();
      String p1CardStatsTitle = cardsAttributeListP1[indexOfCardDeck][p1SelectedIndexOfAttributeList].name;
      String p2CardStatsTitle = cardsAttributeListOfP2[indexOfCardDeck][p1SelectedIndexOfAttributeList].name;

      if (p1CardStatsTitle == p2CardStatsTitle) {
        if(cardsAttributeListP1[indexOfCardDeck][p1SelectedIndexOfAttributeList].winBasis == 'Highest Value'){
          if(p1SelectedAttributeValue > p2SelectedAttributeValue){
            isPlayer1Won = true;
            winPoint = int.parse(cardsAttributeListP1[indexOfCardDeck][p1SelectedIndexOfAttributeList].winPoints);
          } else {
            isPlayer1Won = false;
            winPoint = int.parse(cardsAttributeListOfP2[indexOfCardDeck][p1SelectedIndexOfAttributeList].winPoints);
          }

        } else if (cardsAttributeListP1[indexOfCardDeck][p1SelectedIndexOfAttributeList].winBasis == 'Lowest Value'){
          if(p1SelectedAttributeValue < p2SelectedAttributeValue){
            isPlayer1Won = true;
            winPoint = int.parse(cardsAttributeListP1[indexOfCardDeck][p1SelectedIndexOfAttributeList].winPoints);
          } else {
            isPlayer1Won = false;
            winPoint = int.parse(cardsAttributeListOfP2[indexOfCardDeck][p1SelectedIndexOfAttributeList].winPoints);
          }
        }

        print('----indexOfCardDeck ' + indexOfCardDeck.toString());
        print('----p1SelectedIndexOfAttributeList ' + p1SelectedIndexOfAttributeList.toString());
        print('----p2SelectedIndexOfAttributeList ' + p1SelectedIndexOfAttributeList.toString());
        print('----P1 attr name ' + cardsAttributeListP1[indexOfCardDeck][p1SelectedIndexOfAttributeList].name);
        print('----P1 attr value ' + cardsAttributeListP1[indexOfCardDeck][p1SelectedIndexOfAttributeList].value);
        print('----P2 attr name ' + cardsAttributeListOfP2[indexOfCardDeck][p1SelectedIndexOfAttributeList].name);
        print('----P2 attr value ' + cardsAttributeListOfP2[indexOfCardDeck][p1SelectedIndexOfAttributeList].value);
        print('----win Point ' + winPoint.toString());


        Future.delayed(Duration(milliseconds: 2000),(){
          cardKeyOfPlayerTwo.currentState.toggleCard();
        });

        Future.delayed(Duration(milliseconds: 5500),(){
          onClickActionOnP2AutoPlayCard(
              isPlayer1Won,
              winPoint
          );
        });
      } else {
        Toast.show('You Selected Wrong Stats', context, duration: Toast.lengthLong, gravity:  Toast.bottom,
            backgroundColor: Colors.black87.withOpacity(0.5),
            textStyle:  TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'montserrat',
              shadows: [
                Shadow(color: Colors.white),
              ],
            ));
      }
    }

    return Container();
  }

  return FlipCard(
    flipOnTouch: false,
    direction: FlipDirection.HORIZONTAL,
    speed: 1000,
    key: cardKeyOfPlayerTwo,
    onFlipDone: (status) {},

    front: Container(
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
      child: !isFlipped?buildDottedTextViewOfComputerCard(context):
      FadeIn(
        child:Stack(
          children: [
            Container(
              color: Colors.lightBlueAccent[400],
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ShapeOfView(
                  height: 35,
                  width: 35,
                  shape: CircleShape(borderColor: Colors.white, borderWidth: 1),
                  elevation: 5,
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
                Align(
                  alignment: Alignment.center,
                  child: isP1SelectedStats ?
                  Lottie.asset('assets/animations/lottiefiles/confused_robot-bot-3d.json', width: 200, height: 200):
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: 'assets/images/cricket_1.png',
                        image: cardsList[indexOfCardDeck].cardImg,
                        height: 155,
                        width: 155),
                  ),
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
                        fontSize: 19,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        preferences: AnimationPreferences(duration: const Duration(milliseconds: 1200), autoPlay: AnimationPlayStates.Forward),
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
            color: Colors.lightBlueAccent,
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  placeholder: 'assets/images/cricket_1.png',
                  image: cardsList[cardListSizeForP2 + indexOfCardDeck].cardImg,
                  height: 135,
                  width: 135),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 200,
              height: 25,
              child: BounceInLeft(
                child: WavyAnimatedTextKit(
                  textStyle: TextStyle(fontSize: 12.0, color: Colors.white, fontWeight: FontWeight.normal),
                  text: ['*Stats will be automatically selected'],
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
                padding: EdgeInsets.all(2),
                //change the number as you want
                children: List.generate(cardsAttributeListOfP2[indexOfCardDeck].length, (index) {
                  int selectedIndex = 33;
                  whoIsPlaying == 'computer' ? selectedIndex = indexOfCardDeckSelectForComputer: selectedIndex = p1SelectedIndexOfAttributeList;

                  return Container(
                    padding: index == selectedIndex? EdgeInsets.only(left: 3, top: 1):EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: index == selectedIndex? Colors.white24: Colors.lightBlueAccent,
                      border: index == selectedIndex? Border.all(color: Colors.white):Border.all(color: Colors.transparent),
                      borderRadius: index == selectedIndex? BorderRadius.all(Radius.circular(3)):BorderRadius.all(Radius.circular(0)),
                    ),
                    //margin: EdgeInsets.only(left: 5, right: 5),
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 1),
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
                                padding: const EdgeInsets.only(left: 2),
                                child: Stack(alignment: Alignment.center, children: <Widget>[
                                  SvgPicture.asset(
                                    'assets/icons/svg/star1.svg',
                                    width: 13,
                                    height: 13,
                                  ),
                                  Text(
                                    cardsAttributeListP1[indexOfCardDeck][index].winPoints,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo),),
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
                          cardsAttributeListOfP2[indexOfCardDeck][index].name,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 8,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'neuropol_x_rg',
                              fontWeight: FontWeight.normal,
                              color: Colors.indigo),
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
                            cardsList[cardListSizeForP2 + indexOfCardDeck].cardName,
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
                        elevation: 4,
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

          doFlip(isComputerTurn, cardKeyOfPlayerTwo),
        ],
      ),
    ),
  );
}

Widget buildDottedTextViewOfComputerCard(BuildContext context){
  return Stack(
    children: <Widget>[
       Container(
        width: getScreenWidth(context),
        height: getScreenHeight(context),
        color: Colors.lightBlueAccent[400],
        //child: Image.asset('assets/images/bg_card_back.png', fit: BoxFit.fill),
      ),

      Align(
        alignment: Alignment.center,
        child: Center(
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
                  'COMPUTER CARD',
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
      ),
    ],
  );
}
