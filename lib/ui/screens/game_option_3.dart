import 'package:clash_of_cardz_flutter/helper/exten_fun/base_application_fun.dart';
import 'package:clash_of_cardz_flutter/ui/screens/setting.dart';
import 'package:clash_of_cardz_flutter/ui/styles/size_config.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/include_screens/player_info_back_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:clash_of_cardz_flutter/bloc/api_bloc.dart';
import 'package:clash_of_cardz_flutter/helper/constantvalues/constants.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/common_fun.dart';
import 'package:clash_of_cardz_flutter/helper/shared_preference_data.dart';
import 'package:clash_of_cardz_flutter/model/responses/game_option_res_model.dart';
import 'package:clash_of_cardz_flutter/ui/screens/pvp.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/include_screens/include_drawer_play_with_friends.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/include_screens/include_searching_players.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/colorize.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/shimmer.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/views/view_widgets.dart';
import 'package:flutter_animator/flutter_animator.dart';

import 'login.dart';

class GameOptionThree extends StatefulWidget {
  final String gameCat1;
  final String gameCat2;
  final String gameCat3;
  final String gameCat4;

  const GameOptionThree({Key key, this.gameCat1, this.gameCat2, this.gameCat3, this.gameCat4}) : super(key: key);

  @override
  _GameOptionThreeState createState() => _GameOptionThreeState();
}

class _GameOptionThreeState extends State<GameOptionThree> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  List<String> cardToPlayLists = [
    '14',
    '22',
    '30',
  ];
  List<String> gamePlayTypeLists = ['vs Player', 'vs Friends', 'vs Computer'];
  List<String> cardToPlayEmptyList = [];
  List<String> gamePlayTypeEmptyList = [];
  List<Card_type> playerTypeList = [];

  String playerType = '';
  String cardsToPlay = '';
  String gamePlayType = '';
  String xApiKey = '';
  String p1FullName = '';
  String p1MemberId = '';
  String p1Photo = '';

  double screenWidth = 800;
  double screenHeight = 400;

  @override
  void initState() {
    super.initState();
    retrieveSharedPrefData();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = getScreenWidth(context);
    screenHeight = getScreenHeight(context);
    playerTypeList = ModalRoute.of(context).settings.arguments;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFF364B5A),
        key: _drawerKey, // assign key to Scaffold
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                height: 55,
                color: Color(0xFF253845),
                child: DrawerHeader(
                  margin: EdgeInsets.all(0),
                  child: Text(
                    'Friends',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'neuropol_x_rg',
                    ),
                  ),
                ),
              ),

              //building friend list ui in drawer
              friendList(context, xApiKey, p1MemberId, widget.gameCat1, widget.gameCat2, widget.gameCat3, widget.gameCat4, gamePlayType, playerType),
            ],
          ),
        ),

        body: Stack(
          children: [
            PlayerInfoBackBtn(pageTitle: '',),

            Container(
              margin: EdgeInsets.only(top:  SizeConfig.widthMultiplier * 10),
              alignment: Alignment.center,
              child: Shimmer.fromColors(
                baseColor: Colors.blue[100].withOpacity(0.1),
                highlightColor: Colors.white.withOpacity(0.13),
                child: Text(
                  'CLASH OF CARDZ',
                  style: TextStyle( fontSize: SizeConfig.widthMultiplier * 14, fontFamily: 'Rapier', fontWeight: FontWeight.normal),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Container(
                    width: screenWidth / 3.6,
                    child: buildPlayerTypeList(),
                  ),
                  Container(
                    height: cardToPlayEmptyList.length * 65.0,
                    width: 1.5,
                    color: Colors.blueGrey,
                  ),
                  Container(
                    width: screenWidth / 3.7,
                    child: build2ndList(cardToPlayEmptyList),
                  ),
                  Container(
                    height: gamePlayTypeEmptyList.length * 65.0,
                    width: 1.5,
                    color: Colors.blueGrey,
                  ),
                  Container(
                    width: screenWidth / 2.8,
                    child: build3rdList(gamePlayTypeEmptyList),
                  ),
                  Container(
                    width: screenWidth / 12,
                    child: Container(
                      //height: 260,
                      width: 50,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SlideInDown(
                              child: Container(
                                width: 35,
                                height: 35,
                                margin: EdgeInsets.only(bottom: 8),
                                child: IconButton(
                                  icon: SvgPicture.asset(
                                    'assets/icons/svg/settings.svg',
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    bool isNotifiOn;
                                    SharedPreferenceHelper().getNotificationOnOffState().then((isNotificationOn) => {
                                          isNotifiOn = isNotificationOn,
                                        });
                                    bool isSfxOn;
                                    SharedPreferenceHelper().getSfxOnOffState().then((isSFXOn) => {
                                          isSfxOn = isSFXOn,
                                        });

                                    bool isMusicOn;
                                    SharedPreferenceHelper().getMusicOnOffState().then((isMusicsOn) => {
                                      isMusicOn = isMusicsOn,
                                    });

                                    SharedPreferenceHelper().getUserUserMemberId().then((memberId) => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext context) =>
                                                      Setting(isMusicOn, isNotifiOn, isSfxOn, memberId))),
                                        });
                                  },
                                ),
                                decoration:
                                    Views.boxDecorationWidgetForIconWithBgColor(Colors.teal[400], 4.0, Colors.black54, 3.0, 3.0, 2.0),
                              ),
                              preferences: AnimationPreferences(
                                  duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                            ),

                            SlideInUp(
                              child: Container(
                                width: 35,
                                height: 35,
                                margin: EdgeInsets.only(top: 8),
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
                                decoration: Views.boxDecorationWidgetForIconWithBgColor(Colors.red[600], 4.0, Colors.black54, 3.0, 3.0, 2.0),
                              ),
                              preferences: AnimationPreferences(
                                  duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
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

  Widget buildPlayerTypeList() {
    if (playerTypeList.length > 0) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.fromLTRB(0.0, 33.0, 0.0, 5.0),
        itemCount: playerTypeList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return BounceInRight(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(36)),
              ),
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: screenHeight / 9,
                      height: screenHeight / 9,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.cyanAccent.shade100,
                          width: 1,
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
                      padding: const EdgeInsets.only(left: 12),
                      child: Shimmer.fromColors(
                        baseColor: Colors.blue[100],
                        highlightColor: Colors.lightBlueAccent,
                        child: Text(
                          playerTypeList[index].type,
                          style: TextStyle(fontSize: screenHeight / 20, fontFamily: 'montserrat', fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  playerType = playerTypeList[index].type;
                  setState(() {
                    cardToPlayEmptyList.clear();
                    cardToPlayEmptyList.addAll(cardToPlayLists);

                    //to hide 3rd list
                    gamePlayTypeEmptyList.clear();
                  });

                  //onTapAudio('button');
                },
              ),
            ),
            preferences: AnimationPreferences(duration: const Duration(milliseconds: 1000), autoPlay: AnimationPlayStates.Forward),
          );
        },
      );
    } else
      return Container();
  }

  Widget build2ndList(List<String> cardToPlayLists) {
    if (cardToPlayLists.length > 0) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.fromLTRB(0.0, 33.0, 0.0, 5.0),
        itemCount: cardToPlayLists.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return BounceInRight(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(36)),
              ),
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: screenHeight / 9,
                      height: screenHeight / 9,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.cyanAccent.shade100,
                          width: 1,
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
                      padding: const EdgeInsets.only(left: 12),
                      child: Shimmer.fromColors(
                        baseColor: Colors.blue[100],
                        highlightColor: Colors.lightBlueAccent,
                        child: Text(
                          '${cardToPlayLists[index]} cards',
                          style: TextStyle(fontSize: screenHeight / 20, fontFamily: 'montserrat', fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  cardsToPlay = cardToPlayLists[index];
                  setState(() {
                    gamePlayTypeEmptyList.clear();
                    gamePlayTypeEmptyList.addAll(gamePlayTypeLists);
                  });

                  // onTapAudio('button');
                },
              ),
            ),
            preferences: AnimationPreferences(duration: const Duration(milliseconds: 1000), autoPlay: AnimationPlayStates.Forward),
          );
        },
      );
    } else
      return Container();
  }

  Widget build3rdList(List<String> gamePlayTypeLists) {
    if (gamePlayTypeLists.length > 0) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.fromLTRB(5.0, 33.0, 0.0, 5.0),
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
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: screenHeight / 9,
                      height: screenHeight / 9,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.cyanAccent.shade100,
                          width: 1,
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
                      padding: const EdgeInsets.only(left: 12),
                      child: Shimmer.fromColors(
                        baseColor: Colors.blue[100],
                        highlightColor: Colors.lightBlueAccent,
                        child: Text(
                          '${gamePlayTypeLists[index]}',
                          style: TextStyle(fontSize: screenHeight / 20, fontFamily: 'montserrat', fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                print('----game op: ${widget.gameCat1} , ${widget.gameCat2} , ${widget.gameCat3}, ${widget.gameCat4}');

                if (gamePlayTypeLists[index] == 'vs Computer') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => Pvp(
                          xApiKey: xApiKey,
                          p1Name: p1FullName,
                          p1Id: p1MemberId,
                          p1Image: p1Photo,
                          p2Name: 'Computer',
                          p2Id: 'COMP00005',
                          p2Image: Constants.imgUrlComputer,
                          gameCat1: widget.gameCat1,
                          gameCat2: widget.gameCat2,
                          gameCat3: widget.gameCat3,
                          gameCat4: widget.gameCat4,
                          cardsToPlay: cardsToPlay,
                          playerType: playerType,
                          gameType: gamePlayTypeLists[index],
                        ),
                      ));
                } else if (gamePlayTypeLists[index] == 'vs Friends') {
                  apiBloc.fetchFriendsRes(xApiKey, p1MemberId);
                  _drawerKey.currentState.openDrawer(); // open drawer
                } else {
                  showDialog(
                    context: context,
                    builder: (_) => IncludeSearchingForPlayer(
                      gameCat1: widget.gameCat1,
                      gameCat2: widget.gameCat2,
                      gameCat3: widget.gameCat3,
                      gameCat4: widget.gameCat4,
                      playerType: playerType,
                      gameType: gamePlayTypeLists[index],
                      cardsToPlay: cardsToPlay,
                      //change here
                      xApiKey: xApiKey,
                      p1FullName: p1FullName,
                      p1MemberId: p1MemberId,
                      p1Photo: p1Photo,
                    ),
                  );
                }
              },
            ),
            preferences: AnimationPreferences(duration: const Duration(milliseconds: 1200), autoPlay: AnimationPlayStates.Forward),
          );
        },
      );
    } else {
      return SizedBox();
    }
  }

  void retrieveSharedPrefData() {
    SharedPreferenceHelper().getUserSavedData().then((sharedPrefUserProfileModel) => {
          print('Fb pref ${sharedPrefUserProfileModel.memberId}'),
          xApiKey = sharedPrefUserProfileModel.xApiKey ?? 'NA',
          p1FullName = sharedPrefUserProfileModel.fullName ?? 'NA',
          p1MemberId = sharedPrefUserProfileModel.memberId ?? 'NA',
          p1Photo = sharedPrefUserProfileModel.photo ?? 'NA',
        });
  }
}
