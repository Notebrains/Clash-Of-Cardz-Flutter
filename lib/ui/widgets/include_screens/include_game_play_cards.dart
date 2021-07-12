import 'package:clash_of_cardz_flutter/ui/widgets/custom/txt_inside_doted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/base_application_fun.dart';
import 'package:clash_of_cardz_flutter/model/responses/cards_res_model.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/animated_text_kit/wavy.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/edge_alert.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/f_dotted_line.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/flip_card.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/shimmer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

Widget buildCardAsP1(
  BuildContext context,
  bool isPlayAsP1,
  List<Cards> cardsList,
  int indexOfCardDeck,
  bool isYourNextTurn,
  int selectedIndexOfP2Card,
  String whoIsPlaying, {
  Function(int p1SelectedIndexOfAttributeList, String attributeTitle, String attributeValue, String winBasis, String winPoints, bool isFlipped)
      onClickActionOnP1GameplayCard,
}) {
  GlobalKey<FlipCardState> cardKeyOfPlayerOne = GlobalKey<FlipCardState>();
  List<List<Attribute>> cardsAttributeList = [];
  final ValueNotifier<int> isButtonTappedValueNotify = ValueNotifier<int>(77);
  int cardListSize = (cardsList.length / 2).round();

  try {
    print('---- isPlayAsP1, card list1 length : $isPlayAsP1 , ${cardsList.length}');

    for (int i = 0; i < cardsList.length; i++) {
      print('----cardsList length : ${cardsList[i].cardName}');
    }

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
      if (whoIsPlaying == 'p1') {
        onClickActionOnP1GameplayCard(0, 'Title', '0', 'highest','0', true);
      } if (isYourNextTurn && whoIsPlaying == 'p2') {
        String attributeValue = (double.parse(cardsAttributeList[indexOfCardDeck][selectedIndexOfP2Card].value).toInt()).toString();
        String attributeTitle = cardsAttributeList[indexOfCardDeck][selectedIndexOfP2Card].name;
        String winPoint = cardsAttributeList[indexOfCardDeck][selectedIndexOfP2Card].winPoints;
        String winBasis = cardsAttributeList[indexOfCardDeck][selectedIndexOfP2Card].winBasis;

        Future.delayed(Duration(milliseconds: 1200),(){
          onClickActionOnP1GameplayCard(selectedIndexOfP2Card, attributeTitle, attributeValue, winBasis, winPoint, true);
        });
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
        child: Stack(
          children: <Widget>[
            Container(
              width: getScreenWidth(context),
              height: getScreenHeight(context),
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
              //child: Image.asset('assets/images/bg_card_back.png', fit: BoxFit.fill),
            ),

            TxtInsideDottedLine(text: isYourNextTurn ?'TAP TO \nSELECT A CARD': 'PLEASE WAIT...\nUNTIL P-2 SELECT STATS', width: 140, height: 80,),

            Align(
                alignment: Alignment.bottomCenter,
                child: Lottie.asset(
                    isYourNextTurn? 'assets/animations/lottiefiles/tap_finger.json' :
                    'assets/animations/lottiefiles/timer-progress-animation.json',
                    width: 70, height: 70)),
          ],
        ),
        onTap: () {

          //print('----whoIsPlaying $whoIsPlaying');
          //print('----isYourNextTurn $isYourNextTurn');
          //print('----selectedIndexOfP2Card $selectedIndexOfP2Card');

          if (isYourNextTurn) {
            cardKeyOfPlayerOne.currentState.toggleCard();
          } else {
            EdgeAlert.show(context,
                backgroundColor: Colors.blueGrey[800],
                //title: 'Hint',
                description: 'Please wait for other player turn to play.',
                gravity: EdgeAlert.TOP,
                icon: Icons.wb_incandescent_outlined,
            );
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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepOrange,
                  Colors.orange[600],
                  Colors.deepOrangeAccent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
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
                  height: 135,
                  width: 135,
              ),
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
                    padding: EdgeInsets.all(4),
                    //change the number as you want
                    children: List.generate(cardsAttributeList[indexOfCardDeck].length, (index) {
                      return Container(
                        padding: index == selectedIndexOfP2Card || index == isButtonTappedValueNotify.value? EdgeInsets.only(left: 3, top: 1):EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: index == selectedIndexOfP2Card || index == isButtonTappedValueNotify.value? Colors.white24: Colors.transparent,
                          border: index == selectedIndexOfP2Card || index == isButtonTappedValueNotify.value? Border.all(color: Colors.white):Border.all(color: Colors.transparent),
                          borderRadius: index == selectedIndexOfP2Card || index == isButtonTappedValueNotify.value? BorderRadius.all(Radius.circular(3)):BorderRadius.all(Radius.circular(0)),
                        ),
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
                              isButtonTappedValueNotify.value = index;
                              if (isYourNextTurn && whoIsPlaying == 'p1') {
                                onClickActionOnP1GameplayCard(
                                    index,
                                    cardsAttributeList[indexOfCardDeck][index].name,
                                    cardsAttributeList[indexOfCardDeck][index].value,
                                    cardsAttributeList[indexOfCardDeck][index].winBasis,
                                    cardsAttributeList[indexOfCardDeck][index].winPoints,
                                    false
                                );
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
                            isPlayAsP1 ? cardsList[indexOfCardDeck].cardName : cardsList[cardListSize + indexOfCardDeck].cardName,
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
                            image:  isPlayAsP1 ? cardsList[indexOfCardDeck].flagImage : cardsList[cardListSize + indexOfCardDeck].flagImage,
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

Widget buildSecondCard(
    BuildContext context,
    int p1SelectedIndexOfAttributeList,
    int indexOfCardDeck,
    List<Cards> cardsList,
    bool isP1CardFlipped,
    String p1turnStatus,
    String p2turnStatus,
    bool isPlayAsP1,
    ) {
  GlobalKey<FlipCardState> cardKeyOfPlayerTwo = GlobalKey<FlipCardState>();
  int cardListSizeForP2 = (cardsList.length / 2).round();

  Widget doFlip(bool isP1CardFlipped, GlobalKey<FlipCardState> cardKeyOfPlayerTwo) {
    try {
      print('-----1  p1turnStatus: $p1turnStatus , p2turnStatus: $p2turnStatus');
      if(isP1CardFlipped && p1turnStatus == 'no' && p2turnStatus == 'no'){
        print('-----2  p1turnStatus: $p1turnStatus , p2turnStatus: $p2turnStatus');
            Future.delayed(Duration(milliseconds: 800),(){
              cardKeyOfPlayerTwo.currentState.toggleCard();
            });
          }
    } catch (e) {
    }

    return Container();
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
      child: FadeIn(
        child: Stack(
          children: <Widget>[
            Container(
              width: getScreenWidth(context),
              height: getScreenHeight(context),
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  colors: [
                    Colors.blueAccent,
                    Colors.lightBlue,
                    Colors.lightBlueAccent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,),
              ),
              //child: Image.asset('assets/images/bg_card_back.png', fit: BoxFit.fill),
            ),
            //isP1CardFlipped? Lottie.asset('assets/animations/lottiefiles/confused_robot-bot-3d.json', width: 130, height: 130):

            TxtInsideDottedLine(text: 'P-2 CARD', width: 90, height: 50,),
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
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ShapeOfView(
                height: 22,
                width: 22,
                shape: CircleShape(borderColor: Colors.white, borderWidth: 1),
                elevation: 5,
                child: CircleAvatar(
                  radius: 30,
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/icons/png/white-flag.png',
                    image:  isPlayAsP1 ? cardsList[cardListSizeForP2 + indexOfCardDeck].flagImage : cardsList[indexOfCardDeck].flagImage,
                  ),
                ),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              p1turnStatus == 'yes' || p2turnStatus == 'yes' ?
              Lottie.asset('assets/animations/lottiefiles/timer-progress-animation.json', width: 150, height: 150):
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    placeholder: 'assets/images/cricket_1.png',
                    image: isPlayAsP1 ? cardsList[cardListSizeForP2 + indexOfCardDeck].cardImg : cardsList[indexOfCardDeck].cardImg,
                    height: 135,
                    width: 135),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.white,
                  highlightColor: Colors.grey[400],
                  child: Text(
                    isPlayAsP1 ? cardsList[cardListSizeForP2 + indexOfCardDeck].cardName : cardsList[indexOfCardDeck].cardName,
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

          doFlip(isP1CardFlipped, cardKeyOfPlayerTwo),
        ],
      ),
    ),
  );
}


