import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trump_card_game/helper/constantvalues/constants.dart';
import 'package:trump_card_game/helper/shared_preference_data.dart';
import 'package:trump_card_game/model/responses/cards_res_model.dart';
import 'package:trump_card_game/model/responses/game_option_res_model.dart';
import 'package:trump_card_game/model/state_managements/autoplay_states_model.dart';
import 'package:trump_card_game/ui/screens/game_result.dart';
import 'package:trump_card_game/ui/screens/login.dart';
import 'package:trump_card_game/ui/widgets/views/view_widgets.dart';
import 'package:provider/provider.dart';

class BuildPlayerOneScreen extends StatelessWidget{
  int listLength = 0;

  BuildPlayerOneScreen(int length){
    this.listLength = length;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AutoPlayStatesModel>(
      builder: (context, statesModel, child) =>  Container(
        child: Stack(
          children: <Widget>[
            BuildPlayerThreeScreen(listLength),

            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 131,
                        height: 87,
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
                        margin: EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                'Player 1',
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
                                    statesModel.playerOneLeft,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18,
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
                                    statesModel.playerOnePoint,
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
                                    statesModel.playerOneTrump,
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
}

class BuildPlayerTwoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AutoPlayStatesModel>(
      builder: (context, statesModel, child) =>  Container(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 131,
                height: 87,
                alignment: AlignmentDirectional.topEnd,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.all(Radius.circular(5)),
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
                        "Player 2",
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
                            statesModel.playerTwoLeft,
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
                          margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Text(
                            statesModel.playerTwoPoint,
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
                            statesModel.playerTwoTrump,
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
                            Navigator.push(context,
                              CupertinoPageRoute(
                                builder: (context) => new GameResult(winnerName: 'Rex Scout', winnerId:'MEM00003', winnerImage: Constants.imgUrlTest, winnerCoins: '200',
                                    winnerPoints: '12', cardType: 'Cricket', clashType: '1 vs 1', playedCards: '16'),
                              ),
                            );
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
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LogIn()));
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
                                "Player 4",
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
                                    "10",
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
                                    "05",
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
                                    "00",
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
}

class BuildPlayerThreeScreen extends StatelessWidget{
  int listLength = 0;

  BuildPlayerThreeScreen(int length){
    this.listLength = (length/2).round();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AutoPlayStatesModel>(
        builder: (context, statesModel, child) => '1' == '1'? Align(
          alignment: AlignmentDirectional.bottomStart,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child:  buildGridView(context, statesModel),
              ),
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
                          'Player 3',
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
                              statesModel.playerTwoLeft,
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
                              statesModel.playerTwoPoint,
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
                              statesModel.playerTwoTrump,
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
                Container(
                  width: 35,
                  height: 35,
                  child: IconButton(
                    icon: Image.asset(
                        'assets/icons/png/ic_right.png'),
                    onPressed: () {
                      if(statesModel.isShowPlayerMatchStatus){
                        context.read<AutoPlayStatesModel>().showPlayerMatchStatus(false);
                      } else context.read<AutoPlayStatesModel>().showPlayerMatchStatus(true);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ) : Container(),
    );


  }

  Widget buildGridView(BuildContext context, AutoPlayStatesModel statesModel) {
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
      padding: EdgeInsets.only(top: 20, left: 4, right: 50),
      height: 120,
      width: 200,
      child:  GridView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        // if you want IOS bouncing effect, otherwise remove this line
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 5,
          mainAxisSpacing: 2,
          childAspectRatio: 0.7,
        ),
        //change the number as you want
        children:  List.generate(gridListSize, (index) {

          return GestureDetector(
            child: Card(
              elevation: 5,
              shadowColor: Colors.grey,
              color: Colors.orange,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8.00)),
                child: Image.asset(
                  'assets/images/img_card_demo.png',
                  width: 55,
                ),
              ),
            ),

            onTap: (){
              print('---- card Count 22 $gridListSize');
              if(gridListSize > 0){
                context.read<AutoPlayStatesModel>().updateCardCountOnDeck(statesModel.cardCountOnDeck - 1);
              }
            },
          );
        }),
      ),
    );
  }

}


