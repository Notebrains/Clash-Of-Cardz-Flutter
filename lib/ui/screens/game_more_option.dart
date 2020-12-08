import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:trump_card_game/model/responses/game_option_res_model.dart';
import 'package:trump_card_game/ui/widgets/include_screens/friends_drawer.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_searching_players.dart';
import 'package:trump_card_game/ui/widgets/libraries/colorize.dart';
import 'package:trump_card_game/ui/widgets/views/view_widgets.dart';

import 'login.dart';

class GameMoreOption extends StatefulWidget {

  @override
  _GameMoreOptionState createState() => _GameMoreOptionState();
}

class _GameMoreOptionState extends State<GameMoreOption> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  List<Subcategory_details> subcategoryDetails = List();
  List<String> cardsToBePlayed = List<String>();

  void gameMoreOptState() {
    setState(() {
      cardsToBePlayed.clear();
      cardsToBePlayed.addAll(subcategoryDetails[0].cardsToBePlayed);
      buildSecondList(cardsToBePlayed);
      //print("---- subcategoryDetails.length " + subcategoryDetails.length.toString());
      //print("---- cardsToBePlayed.length 2 " + cardsToBePlayed.length.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    subcategoryDetails = ModalRoute
        .of(context)
        .settings
        .arguments;

    return Scaffold(
      key: _drawerKey, // assign key to Scaffold
      drawer: Drawer(
        child: new ListView(
          children: <Widget>[
            Container(
              height: 55,
              child: DrawerHeader(
                margin: EdgeInsets.all(0),
                child: Column(
                  children: [
                    Text(
                      'Friends',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'neuropol_x_rg',
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                ),
              ),
            ),

            //building friend list ui in drawer
            friendList(context),
          ],
        ),
      ),
      body: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/bg_img13.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: ColorizeAnimatedTextKit(
                onTap: () {
                  //print("Tap Event");
                },
                text: ["CLASH OF CARDZ"],
                textStyle: TextStyle(
                  fontSize: 55.0,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Rapier',
                ),
                colors: [
                  Colors.grey[400],
                  Colors.grey[500],
                  Colors.grey[400],
                ],
                textAlign: TextAlign.center,
                alignment: AlignmentDirectional.center,
                // or Alignment.topLeft
                isRepeatingAnimation: true,
                repeatForever: true,
                speed: Duration(milliseconds: 1000),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: 1.5,
                    color: Colors.indigo,
                    margin: const EdgeInsets.only(left: 40, top: 50.0, bottom: 50.0),
                  ),

                  Expanded(
                    flex: 3,
                    child: _buildFirstList(subcategoryDetails[0].noOfPlayerPlayed, 0),
                  ),

                  Container(
                    height: cardsToBePlayed.length* 80.0,
                    width: 1.5,
                    color: Colors.indigo,
                    margin: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                  ),
                  Expanded(
                    flex: 3,
                    child: buildSecondList(cardsToBePlayed),
                  ),

                  Expanded(
                    flex: 1,
                    child: Container(
                      //height: 260,
                      width: 50,
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
                                  'assets/icons/svg/friends.svg',
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  apiBloc.fetchFriendsRes('ZGHrDz4prqsu4BcApPaQYaGgq', 'MEM000001');
                                  _drawerKey.currentState.openDrawer(); // open drawer
                                },
                              ),
                              decoration: Views.boxDecorationWidgetForIconWithBgColor(Colors.teal[400], 4.0, Colors.grey, 5.0, 5.0, 3.0),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFirstList(String noOfPlayerPlaying, int index) {
    final List<String> vsList = <String>[];

    try {
      switch(noOfPlayerPlaying){
            case "2":
              vsList.add("1 vs 1");
              break;
            case "3":
              vsList.add("1 vs 1");
              vsList.add("1 vs 2");
              break;
            case "4":
              vsList.add("1 vs 1");
              vsList.add("1 vs 2");
              vsList.add("1 vs 3");
              break;
          }
    } catch (e) {
      print(e);
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: EdgeInsets.fromLTRB(10.0, 12.0, 16.0, 5.0),
      itemCount: vsList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(36)),
          ),
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.grey[350],
                    width: 5,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
                child: CircleAvatar(
                  child: SvgPicture.asset('assets/icons/svg/cricket.svg'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 0, 2),
                child: GestureDetector(
                  child: Text(
                    vsList[index],
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        fontFamily: 'neuropol_x_rg',
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  onTap: () {
                    buildSecondList(cardsToBePlayed);
                    gameMoreOptState();
                    //print('subcategory.length----' + data.response[index].subcategory.length.toString());
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildSecondList(List<String> cardsToBePlayed) {
    if (cardsToBePlayed.length > 0) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.fromLTRB(5.0, 33.0, 16.0, 5.0),
        itemCount: cardsToBePlayed.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(36)),
            ),
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.grey[350],
                      width: 5,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                  child: CircleAvatar(
                    child: SvgPicture.asset('assets/icons/svg/cricket.svg'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 12, 0, 2),
                  child: GestureDetector(
                    child: Text(
                      cardsToBePlayed[index],
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                          fontFamily: 'neuropol_x_rg',
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (_) => IncludeSearchingForPlayer(),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      return SizedBox();
    }
  }
}
