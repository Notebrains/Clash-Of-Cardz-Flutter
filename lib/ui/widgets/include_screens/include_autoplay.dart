import 'package:clash_of_cardz_flutter/ui/screens/old_screen/setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:clash_of_cardz_flutter/helper/shared_preference_data.dart';
import 'package:clash_of_cardz_flutter/model/state_managements/autoplay_states_model.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/views/view_widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animator/flutter_animator.dart';

class BuildPlayer1Screen extends StatelessWidget{
  int listLength = 0;
  String p1FullName = 'Player 1';
  ValueNotifier<bool> gameScoreStatusValueNotify;

  BuildPlayer1Screen(int length, String p1fullName, ValueNotifier<bool> gameScoreStatusValueNotify){
    this.listLength = (length/2).round();
    this.p1FullName = p1fullName;
    this.gameScoreStatusValueNotify = gameScoreStatusValueNotify;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AutoPlayStatesModel>(
        builder: (context, statesModel, child) =>  SlideInLeft(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 95,
                height: 70,
                margin: EdgeInsets.all(8.0),
                alignment: AlignmentDirectional.topStart,
                decoration: BoxDecoration(
                  color: Color(0xFF364B5A),
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
                      padding: const EdgeInsets.all(5.0),
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
                          width: 40,
                          color: Color(0xFF20313E),
                          margin: EdgeInsets.only(left: 5),
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
                          width: 5,
                          color: Color(0xFF20313E),
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
                          width: 40,
                          color: Color(0xFF20313E),
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.only(right: 5),
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
                    //width: getScreenWidth(context)/6.4,
                    width: 131,
                    height: 87,
                    alignment: AlignmentDirectional.bottomStart,
                    decoration: BoxDecoration(
                      color: Color(0xFF364B5A),
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
                            p1FullName,
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
                              height: 35,
                              color: Color(0xFF20313E),
                              child: Center(
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
                            ),
                            Container(
                              width: 40,
                              height: 35,
                              color: Color(0xFF20313E),
                              margin:
                              EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Center(
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
                            ),
                            Container(
                              width: 40,
                              height: 35,
                              color: Color(0xFF20313E),
                              child: Center(
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
                  /*HeadShake(
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
                  ),*/

                ],
              ),
            ],
          ),
          preferences: AnimationPreferences(
              duration: const Duration(milliseconds: 1500),
              autoPlay: AnimationPlayStates.Forward),
        ),
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
                    'assets/images/bg_card_back.png',
                    width: 55,
                  ),
                ),
              ),

              onTap: (){
                /*print('---- card Count 22 $gridListSize');
                if(gridListSize > 0){
                  context.read<AutoPlayStatesModel>().updateCardCountOnDeck(statesModel.cardCountOnDeck - 1);
                  context.read<AutoPlayStatesModel>().updateRebuildDeck(true);
                }*/
              },
            ),
            preferences: AnimationPreferences(
                offset: Duration(milliseconds: 3500),
                duration: const Duration(milliseconds: 2500),
                autoPlay: AnimationPlayStates.Loop),
          );
        }),
      ),
    );
  }

}

class BuildPlayerTwoScreen extends StatelessWidget {
  final int listLength;
  final String memberId;
  final Function onPressed;

  const BuildPlayerTwoScreen({
    Key key,
    @required this.listLength,
    @required this.memberId,
    @required this.onPressed,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Consumer<AutoPlayStatesModel>(
      builder: (context, statesModel, child) =>  SlideInRight(
        child: Container(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 95,
                  height: 70,
                  margin: EdgeInsets.all(8.0),
                  alignment: AlignmentDirectional.topEnd,
                  decoration: BoxDecoration(
                    color: Color(0xFF364B5A),
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
                        padding: const EdgeInsets.all(5.0),
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
                            width: 40,
                            color: Color(0xFF20313E),
                            margin: EdgeInsets.only(left: 5),
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
                            color: Color(0xFF20313E),
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
                            width: 40,
                            color: Color(0xFF20313E),
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.only(right: 5),
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
                            onPressed: onPressed,
                          ),
                          decoration: Views.boxDecorationWidgetForIconWithBgColor(Colors.teal, 4.0, Colors.grey, 5.0, 5.0, 3.0),
                        ),

                        Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.all(5),
                          child: IconButton(
                            icon: Image.asset('assets/icons/png/ic_setting.png', color: Colors.white,),
                            onPressed: () {
                              //onTapAudio('icon');
                              bool isNotifiOn;
                              SharedPreferenceHelper().getNotificationOnOffState().then((isNotificationOn) => {
                                isNotifiOn =isNotificationOn,
                              });
                              bool isSfxOn;
                              SharedPreferenceHelper().getSfxOnOffState().then((isSFXOn) => {
                                isSfxOn = isSFXOn,
                              });

                              SharedPreferenceHelper().getMusicOnOffState().then((isMusicOn) => {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OldSetting(isMusicOn, isNotifiOn, isSfxOn, memberId))),
                              });
                            },
                          ),
                          decoration: Views.boxDecorationWidgetForIconWithBgColor(Color(0xFF20313E), 4.0, Colors.grey, 5.0, 5.0, 3.0),
                        ),

                       /* Container(
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
                          decoration: Views.boxDecorationWidgetForIconWithBgColor(Color(0xFF364B5A), 4.0, Colors.grey, 5.0, 5.0, 3.0),
                        ),*/

                        /*Container(
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
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LogIn()));
                            },
                          ),
                          decoration: Views.boxDecorationWidgetForIconWithBgColor(Colors.red[600], 4.0, Colors.grey, 5.0, 5.0, 3.0),
                        ),*/
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
                            color: Color(0xFF364B5A),
                            borderRadius:
                            BorderRadius.all(Radius.circular(5)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(-3, 3),
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
                                  "Computer",
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
                                    height: 35,
                                    color: Color(0xFF20313E),
                                    child: Center(
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
                                  ),
                                  Container(
                                    width: 40,
                                    height: 35,
                                    color: Color(0xFF20313E),
                                    margin:
                                    EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: Center(
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
                                  ),
                                  Container(
                                    width: 40,
                                    height: 35,
                                    color: Color(0xFF20313E),
                                    child: Center(
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
                                  ),
                                ],
                              ),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
        preferences: AnimationPreferences(
            duration: const Duration(milliseconds: 1500),
            autoPlay: AnimationPlayStates.Forward),
      ),
    );
  }
}

