import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:trump_card_game/helper/constantvalues/constants.dart';
import 'package:trump_card_game/helper/exten_fun/common_fun.dart';
import 'package:trump_card_game/helper/shared_preference_data.dart';
import 'package:trump_card_game/model/responses/game_option_res_model.dart';
import 'package:trump_card_game/ui/screens/autoplay.dart';
import 'package:trump_card_game/ui/screens/pvp.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_drawer_play_with_friends.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_searching_players.dart';
import 'package:trump_card_game/ui/widgets/libraries/colorize.dart';
import 'package:trump_card_game/ui/widgets/libraries/shimmer.dart';
import 'package:trump_card_game/ui/widgets/views/view_widgets.dart';
import 'package:flutter_animator/flutter_animator.dart';

import 'login.dart';

class GameOptionThree extends StatefulWidget {

  final String gameCat1;
  final String gameCat2;
  final String gameCat3;
  final String gameCat4;
  const GameOptionThree ({ Key key, this.gameCat1, this.gameCat2, this.gameCat3, this.gameCat4}): super(key: key);

  @override
  _GameOptionThreeState createState() => _GameOptionThreeState();
}

class _GameOptionThreeState extends State<GameOptionThree> {

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  List<String> cardToPlayLists = ['14', '22', '30',];
  List<String> gamePlayTypeLists = ['vs Player','vs Friends','vs Computer'];
  List<String> gamePlayTypeEmptyList = [];

  String cardsToPlay = '';
  String gaPlayType = '';
  String xApiKey = '';
  String p1FullName = '';
  String p1MemberId = '';
  String p1Photo = '';

  @override
  void initState() {
    super.initState();
    retrieveSharedPrefData();
  }


  void gameMoreOptState(List<String> gamePlayTypeLists) {
    setState(() {
      gamePlayTypeEmptyList.clear();
      gamePlayTypeEmptyList.addAll(gamePlayTypeLists);
      buildSecondList(gamePlayTypeEmptyList);
      //print("---- cardToPlayLists.length " + cardToPlayLists.length.toString());
      //print("---- cardsToBePlayed.length 2 " + cardsToBePlayed.length.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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

              //change here
              //building friend list ui in drawer

              friendList(context, widget.gameCat1, widget.gameCat2, gaPlayType),

              //gaPlayType.isNotEmpty? friendList(context, widget.categoryName, widget.subcategoryName, gaPlayType):
              //showToastWithReturnWidget(context, 'Please Select No Of Cards To Play'),
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
                    onTapAudio('button');
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

                    Expanded(
                      flex: 4,
                      child: buildFirstList(),
                    ),

                    Container(
                      height: gamePlayTypeLists.length* 80.0,
                      width: 1.5,
                      color: Colors.indigo,
                      margin: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                    ),
                    Expanded(
                      flex: 5,
                      child: buildSecondList(gamePlayTypeEmptyList),
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
                              SlideInDown(
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  margin: EdgeInsets.all(5),
                                  child: IconButton(
                                    icon: SvgPicture.asset(
                                      'assets/icons/svg/friends.svg',
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      //apiBloc.fetchFriendsRes('ZGHrDz4prqsu4BcApPaQYaGgq', 'MEM000001');
                                      //_drawerKey.currentState.openDrawer(); // open drawer
                                    },
                                  ),
                                  decoration: Views.boxDecorationWidgetForIconWithBgColor(Colors.teal[400], 4.0, Colors.grey, 5.0, 5.0, 3.0),
                                ),
                                preferences: AnimationPreferences(
                                    duration: const Duration(milliseconds: 1500),
                                    autoPlay: AnimationPlayStates.Forward),
                              ),

                              SlideInRight(
                                child: Container(
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
                                preferences: AnimationPreferences(
                                    duration: const Duration(milliseconds: 1500),
                                    autoPlay: AnimationPlayStates.Forward),
                              ),

                              SlideInUp(
                                child: Container(
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
                                ),
                                preferences: AnimationPreferences(
                                    duration: const Duration(milliseconds: 1500),
                                    autoPlay: AnimationPlayStates.Forward),
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
      ),
    );
  }


  Widget buildFirstList() {
    //final List<String> listData1 = <String>['Player vs Player', 'Play With Friend', 'Play With Random', 'Tournament', 'Play With Computer'];
    //print('cardToPlayLists.length----' + cardToPlayLists.length.toString());

    if(cardToPlayLists.length >0){
      return ListView.builder(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.fromLTRB(5.0, 33.0, 16.0, 5.0),
        itemCount: cardToPlayLists.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return BounceInRight(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(36)),
              ),
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: GestureDetector(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.grey[350],
                          width: 5,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Color(0x60000000),
                            blurRadius: 12.0,
                            offset: Offset(0.0, 12.0),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        child: Image.asset('assets/icons/png/img_sports.png'),
                        //backgroundColor: Colors.black38,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 16, 0, 2),
                      child: Shimmer.fromColors(
                        baseColor: Colors.black54,
                        highlightColor: Colors.orangeAccent,
                        child: Text('${cardToPlayLists[index]} cards',
                          style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'neuropol_x_rg',
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  cardsToPlay = cardToPlayLists[index];
                  buildSecondList(gamePlayTypeLists);
                  gameMoreOptState(gamePlayTypeLists);

                  onTapAudio('button');
                },
              ),
            ),
            preferences: AnimationPreferences(
                duration: const Duration(milliseconds: 1000),
                autoPlay: AnimationPlayStates.Forward),
          );
        },
      );
    } else return Container();
  }

  Widget buildSecondList(List<String> gamePlayTypeLists) {
    if (gamePlayTypeLists.length > 0) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.fromLTRB(12.0, 33.0, 16.0, 5.0),
        itemCount: gamePlayTypeLists.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return SlideInLeft(
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(36)),
                ),
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.grey[350],
                          width: 5,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Color(0x60000000),
                            blurRadius: 12.0,
                            offset: Offset(0.0, 12.0),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        child: Image.asset('assets/icons/png/img_sports.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 16, 0, 2),
                      child: Shimmer.fromColors(
                        baseColor: Colors.black54,
                        highlightColor: Colors.orangeAccent,
                        child: Text(
                          '${gamePlayTypeLists[index]}',
                          style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'neuropol_x_rg',
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: (){
                if(cardsToPlay == 'vs Computer'){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Pvp(p1Name: p1FullName, p1Id: p1MemberId,
                    p1Image: p1Photo, p2Name: 'Computer', p2Id: 'COMP00005', p2Image: Constants.imgUrlComputer, categoryName: widget.gameCat1,
                    subcategoryName: widget.gameCat2, cardsToPlay: cardsToPlay, gameType:  gamePlayTypeLists[index],),
                  ));
                } else if(cardsToPlay == 'vs Friends'){
                  apiBloc.fetchFriendsRes('ZGHrDz4prqsu4BcApPaQYaGgq', 'MEM000001');
                  _drawerKey.currentState.openDrawer(); // open drawer
                } else {
                  showDialog(
                    context: context,
                    builder: (_) => IncludeSearchingForPlayer(
                      categoryName: widget.gameCat1,
                      subcategoryName: widget.gameCat2,
                      gameType: gamePlayTypeLists[index],
                      cardsToPlay: cardsToPlay, //change
                      xApiKey: xApiKey,
                      p1FullName: p1FullName,
                      p1MemberId: p1MemberId,
                      p1Photo: p1Photo,
                    ),
                  );
                }
              },
            ),
            preferences: AnimationPreferences(
                duration: const Duration(milliseconds: 1200),
                autoPlay: AnimationPlayStates.Forward),
          );
        },
      );
    } else {
      return SizedBox();
    }
  }


  void retrieveSharedPrefData(){
    SharedPreferenceHelper().getUserSavedData().then((sharedPrefUserProfileModel) => {
      print('Fb pref ${sharedPrefUserProfileModel.memberId}'),

      xApiKey = sharedPrefUserProfileModel.xApiKey ?? 'NA',
      p1FullName = sharedPrefUserProfileModel.fullName ?? 'NA',
      p1MemberId = sharedPrefUserProfileModel.memberId ?? 'NA',
      p1Photo = sharedPrefUserProfileModel.photo ?? 'NA',
    });
  }
}
