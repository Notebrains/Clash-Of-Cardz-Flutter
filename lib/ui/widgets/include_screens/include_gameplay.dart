import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:clash_of_cardz_flutter/helper/constantvalues/constants.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/common_fun.dart';
import 'package:clash_of_cardz_flutter/helper/shared_preference_data.dart';
import 'package:clash_of_cardz_flutter/model/responses/cards_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/game_option_res_model.dart';
import 'package:clash_of_cardz_flutter/model/state_managements/gameplay_states_model.dart';
import 'package:clash_of_cardz_flutter/ui/screens/game_result.dart';
import 'package:clash_of_cardz_flutter/ui/screens/login.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/giffy_dialog/giffy_dialog.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/views/view_widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animator/flutter_animator.dart';

import 'include_game_play_win_screen.dart';

class BuildPlayer1Screen extends StatelessWidget{
  int listLength = 0;
  String p1Name = '';
  String p2Name = '';
  ValueNotifier<bool> gameScoreStatusValueNotify;

  BuildPlayer1Screen(int length, String p1fullName, String p2Name, ValueNotifier<bool> gameScoreStatusValueNotify){
    this.listLength = (length/2).round();
    this.p1Name = p1fullName;
    this.p2Name = p2Name;
    this.gameScoreStatusValueNotify = gameScoreStatusValueNotify;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GamePlayStatesModel>(
      builder: (context, statesModel, child) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 110,
            height: 70,
            margin: EdgeInsets.all(8.0),
            alignment: AlignmentDirectional.topStart,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius:
              BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(3, 3),
                  blurRadius: 3,
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    'P-1 Cards',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 45,
                      color: Colors.black,
                      margin: EdgeInsets.only(left: 7),
                      padding: EdgeInsets.all(8),
                      child: Text(
                        statesModel.cardCountOnDeck == -5 ? listLength.toString() : statesModel.cardCountOnDeck.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),

                    Container(
                      width: 6,
                      color: Colors.black,
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(
                        '/',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),

                    Container(
                      width: 45,
                      color: Colors.black,
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(right: 7),
                      child: Text(
                        listLength.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: buildGridView(context, statesModel),
          ),

          Row(
            children: [
              Container(
                width: 131,
                height: 87,
                alignment: AlignmentDirectional.bottomStart,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius:
                  BorderRadius.all(Radius.circular(5)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(3, 3),
                      blurRadius: 3,
                    ),
                  ],
                ),
                margin: EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        getFirstWordFromText(p1Name),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          color: Colors.black,
                          padding: EdgeInsets.all(8),
                          child: Text(
                            statesModel.cardCountOnDeck.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          width: 40,
                          color: Colors.black,
                          padding: EdgeInsets.all(8),
                          margin:
                          EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Text(
                            statesModel.player1TotalPoints.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          width: 40,
                          color: Colors.black,
                          padding: EdgeInsets.all(8),
                          child: Text(
                            statesModel.playerOneTrump.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "LEFT",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.normal,
                                color: Colors.white),
                          ),
                        ),
                        Text(
                          "POINTS",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.normal,
                              color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "TRUMP",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.normal,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              HeadShake(
                child: Container(
                  width: 35,
                  height: 35,
                  child: IconButton(
                    icon: Image.asset(
                        'assets/icons/png/ic_right.png'),
                    onPressed: () {
                      if(gameScoreStatusValueNotify.value){
                        gameScoreStatusValueNotify.value = false;
                      } else gameScoreStatusValueNotify.value = true;
                    },
                  ),
                ),
                preferences: AnimationPreferences(
                    duration: const Duration(milliseconds: 5500),
                    autoPlay: AnimationPlayStates.Loop),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildGridView(BuildContext context, GamePlayStatesModel statesModel) {
    int gridListSize = 0;

    //inserting data  and updating statesModel.cardCountOnDeck for the first time
    if(statesModel.cardCountOnDeck == -5){
      gridListSize = listLength;
      statesModel.cardCountOnDeck = listLength;
    } else {
      //getting data from provider and updating count in grid view
      gridListSize = statesModel.cardCountOnDeck;
    }

    //print('---- card Count 11 ${statesModel.cardCountOnDeck}');

    return Container(
      padding: EdgeInsets.only(top: 5, left: 4,),
      height: 110,
      width: 100,
      child:  GridView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        // if you want IOS bouncing effect, otherwise remove this line
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 2,
          childAspectRatio: 0.7,
        ),
        //change the number as you want
        children:  List.generate(gridListSize, (index) {

          return HeartBeat(
            child: GestureDetector(
              child: Card(
                elevation: 5,
                shadowColor: Colors.grey,
                color: Colors.orange,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Image.asset(
                    'assets/images/img_card_demo.png',
                    width: 55,
                  ),
                ),
              ),

              onTap: (){
                //print('---- card Count 22 $gridListSize');
               /* if(gridListSize > 0){
                  context.read<GamePlayStatesModel>().updateCardCountOnDeck(statesModel.cardCountOnDeck - 1);
                  //context.read<GamePlayStatesModel>().updateRebuildDeck(true);
                }*/
              },
            ),
            preferences: AnimationPreferences(
                offset: Duration(milliseconds: 3000),
                duration: const Duration(milliseconds: 2000),
                autoPlay: AnimationPlayStates.Loop),
          );
        }),
      ),
    );
  }

}

class BuildPlayerTwoScreen extends StatelessWidget {
  int listLength = 0;
  String p2Name = '';

  BuildPlayerTwoScreen(int length, String p2name){
    this.listLength = (length/2).round();
    this.p2Name = p2name;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GamePlayStatesModel>(
      builder: (context, statesModel, child) =>  Container(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 110,
                height: 70,
                margin: EdgeInsets.all(8.0),
                alignment: AlignmentDirectional.topEnd,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius:
                  BorderRadius.all(Radius.circular(5)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(3, 3),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        'P-2 Cards',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 45,
                          color: Colors.black,
                          margin: EdgeInsets.only(left: 7),
                          padding: EdgeInsets.all(8),
                          child: Text(
                            statesModel.cardCountOnDeck.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),

                        Container(
                          width: 5,
                          color: Colors.black,
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Text(
                            '/',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),

                        Container(
                          width: 45,
                          color: Colors.black,
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.only(right: 7),
                          child: Text(
                            listLength.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.centerRight,
              child:  Container(
                //height: 260,
                margin: EdgeInsets.only(right: 5),
                width: 45,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        width: 40,
                        height: 40,
                        margin: EdgeInsets.all(5),
                        child: IconButton(
                          icon: SvgPicture.asset(
                            'assets/icons/svg/white-flag.svg',
                            color: Colors.white,
                          ),
                          onPressed: () {

                            showExitDialog(context);
                           /* Navigator.push(context,
                              CupertinoPageRoute(
                                builder: (context) => new GameResult(winnerName: 'Rex Scout', winnerId:'MEM00003', winnerImage: Constants.imgUrlTest, winnerCoins: '200',
                                    winnerPoints: '12', cardType: 'Cricket', clashType: '1 vs 1', playedCards: '16', isP1Won:  true),
                              ),
                            );*/
                          },
                        ),
                        decoration: Views.boxDecorationWidgetForIconWithBgColor(Colors.teal, 4.0, Colors.grey, 5.0, 5.0, 3.0),
                      ),

                      Container(
                        width: 40,
                        height: 40,
                        margin: EdgeInsets.all(5),
                        child: IconButton(
                          icon: SvgPicture.asset(
                            'assets/icons/svg/back_black.svg',
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        decoration: Views.boxDecorationWidgetForIconWithBgColor(Colors.grey[800], 4.0, Colors.grey, 5.0, 5.0, 3.0),
                      ),

                      Container(
                        width: 40,
                        height: 40,
                        margin: EdgeInsets.all(5),
                        child: IconButton(
                          icon: SvgPicture.asset(
                            'assets/icons/svg/logout.svg',
                            color: Colors.white,
                          ),
                          onPressed: () {
                            SharedPreferenceHelper().clearPrefData();
                            //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LogIn()));


                          },
                        ),
                        decoration: Views.boxDecorationWidgetForIconWithBgColor(Colors.red[600], 4.0, Colors.grey, 5.0, 5.0, 3.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 131,
                        height: 87,
                        alignment: AlignmentDirectional.bottomStart,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius:
                          BorderRadius.all(Radius.circular(5)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(3, 3),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        margin: EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                getFirstWordFromText(p2Name),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  color: Colors.black,
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    statesModel.cardCountOnDeck.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  color: Colors.black,
                                  padding: EdgeInsets.all(8),
                                  margin:
                                  EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: Text(
                                    statesModel.player2TotalPoints.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  color: Colors.black,
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    statesModel.playerTwoTrump.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "LEFT",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.white),
                                  ),
                                ),
                                Text(
                                  "POINTS",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.white),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "TRUMP",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AssetGiffyDialog(
        image: Image.asset('assets/animations/gifs/surrender.gif'),
        title: Text(
          'SURRENDER',
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
        ),
        description: Text(
          'Do you really wat to surrender the match!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
        ),
        entryAnimation: EntryAnimation.RIGHT,
        buttonOkText: Text(
          'YES',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        buttonOkColor: Colors.red,
        buttonCancelColor: Colors.greenAccent,
        buttonCancelText: Text(
          'NO',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onOkButtonPressed: () {
          SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
        },
      ),
    );
  }
}

