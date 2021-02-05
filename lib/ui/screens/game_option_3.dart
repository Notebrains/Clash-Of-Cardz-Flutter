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

  final String categoryName;
  final String subcategoryName;
  const GameOptionThree ({ Key key, this.categoryName, this.subcategoryName}): super(key: key);

  @override
  _GameOptionThreeState createState() => _GameOptionThreeState(categoryName, subcategoryName);
}

class _GameOptionThreeState extends State<GameOptionThree> {

  _GameOptionThreeState(String categoryName, String subcategoryName);
  String categoryName = '';
  String subcategoryName = '';

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  List<Subcategory_details> subcategoryDetails = [];
  List<String> cardsToBePlayed = [];

  String gameType = '';
  String cardsToPlay = '';
  String xApiKey = '';
  String p1FullName = '';
  String p1MemberId = '';
  String p1Photo = '';

  @override
  void initState() {
    super.initState();
    retrieveSharedPrefData();
  }


  void gameMoreOptState(List<String> cardsToBePlayed) {
    setState(() {
      this.cardsToBePlayed.clear();
      this.cardsToBePlayed.addAll(cardsToBePlayed);
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
              friendList(context, widget.categoryName, widget.subcategoryName, '14'),
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
                      flex: 7,
                      child: buildFirstList(),
                    ),

                    Container(
                      height: cardsToBePlayed.length* 80.0,
                      width: 1.5,
                      color: Colors.indigo,
                      margin: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                    ),
                    Expanded(
                      flex: 4,
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
                                      apiBloc.fetchFriendsRes('ZGHrDz4prqsu4BcApPaQYaGgq', 'MEM000001');
                                      _drawerKey.currentState.openDrawer(); // open drawer
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
    //print('subcategoryDetails.length----' + subcategoryDetails.length.toString());

    if(subcategoryDetails.length >0){
      return ListView.builder(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.fromLTRB(5.0, 33.0, 16.0, 5.0),
        itemCount: subcategoryDetails.length,
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
                        child: Text(
                          subcategoryDetails[index].gametypeName,
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
                  gameType = subcategoryDetails[index].gametypeName;
                  buildSecondList(subcategoryDetails[index].cardsToBePlayed);
                  gameMoreOptState(subcategoryDetails[index].cardsToBePlayed);

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

  Widget buildSecondList(List<String> cardsToBePlayed) {
    if (cardsToBePlayed.length > 0) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.fromLTRB(5.0, 33.0, 16.0, 5.0),
        itemCount: cardsToBePlayed.length,
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
                          '${cardsToBePlayed[index]} cards',
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
                if(gameType == 'Player vs Computer'){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Pvp(p1Name: p1FullName, p1Id: p1MemberId,
                    p1Image: p1Photo, p2Name: 'Computer', p2Id: 'COMP00005', p2Image: Constants.imgUrlComputer, categoryName: widget.categoryName,
                    subcategoryName: widget.subcategoryName, gameType: gameType, cardsToPlay: cardsToBePlayed[index],),
                  ));
                } else {
                  showDialog(
                    context: context,
                    builder: (_) => IncludeSearchingForPlayer(
                      categoryName: widget.categoryName,
                      subcategoryName: widget.subcategoryName,
                      gameType: gameType,
                      cardsToPlay: cardsToBePlayed[index],
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
