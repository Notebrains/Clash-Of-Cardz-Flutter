import 'package:clash_of_cardz_flutter/helper/exten_fun/base_application_fun.dart';
import 'package:clash_of_cardz_flutter/ui/styles/size_config.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/include_screens/player_info_back_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/common_fun.dart';
import 'package:clash_of_cardz_flutter/model/responses/game_option_res_model.dart';
import 'package:clash_of_cardz_flutter/ui/screens/game_option_3.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/colorize.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/shimmer.dart';

class GameOptionTwo extends StatefulWidget {
  final String gameCat1;
  final String gameCat2;

  const GameOptionTwo({Key key, this.gameCat1, this.gameCat2}) : super(key: key);

  @override
  _GameOptionTwoState createState() => _GameOptionTwoState();
}

class _GameOptionTwoState extends State<GameOptionTwo> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  List<Sub1category_details> subCat3List = [];
  List<Sub2category_details> subCat4List = [];
  List<Sub2category_details> subCat4EmptyList = [];

  String gameCat3 = '';
  double screenHeight = 400;

  void gameMoreOptState(List<Sub2category_details> subCat4List) {
    setState(() {
      this.subCat4EmptyList.clear();
      this.subCat4EmptyList.addAll(subCat4List);
      buildSecondList(subCat4EmptyList);
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = getScreenHeight(context);
    subCat3List = ModalRoute.of(context).settings.arguments;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFF364B5A),
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
                          fontFamily: 'montserrat',
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                  ),
                ),
              ),
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
              padding: EdgeInsets.only(bottom: 16, top: SizeConfig.heightMultiplier * 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: buildFirstList(),
                  ),
                  Container(
                    height: subCat4EmptyList.length * 65.0,
                    width: 1.5,
                    color: Colors.blueGrey,
                    margin: const EdgeInsets.only(top: 12.0,),
                  ),
                  Expanded(
                    flex: 4,
                    child: buildSecondList(subCat4List),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget buildFirstList() {
    //print('subCat3List.length----' + subCat3List.length.toString());
    if (subCat3List.length > 0) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.fromLTRB(5.0, 33.0, 16.0, 5.0),
        itemCount: subCat3List.length,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: screenHeight/9,
                      height: screenHeight/9,
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
                      child: Pulse(
                        child: CircleAvatar(
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/icons/png/img_sports.png',
                            image: subCat3List[index].sub2categoryIcon??'',
                          ),
                          //backgroundColor: Colors.black38,
                        ),
                        preferences: AnimationPreferences(
                            duration: const Duration(milliseconds: 1500),
                            autoPlay: AnimationPlayStates.Loop),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Shimmer.fromColors(
                        baseColor: Colors.blue[100],
                        highlightColor: Colors.lightBlueAccent,
                        child: Text(
                          subCat3List[index].sub2categoryName,
                          style: TextStyle( fontSize: screenHeight/18, fontFamily: 'montserrat', fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  //onTapAudio('button');
                  gameCat3 = subCat3List[index].sub2categoryName;
                  buildSecondList(subCat3List[index].sub2categoryDetails);
                  gameMoreOptState(subCat3List[index].sub2categoryDetails);
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

  Widget buildSecondList(List<Sub2category_details> subCat4List) {
    if (subCat4EmptyList.length > 0) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.fromLTRB(5.0, 33.0, 16.0, 5.0),
        itemCount: subCat4EmptyList.length,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: screenHeight/9,
                      height: screenHeight/9,
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
                      child: Pulse(
                        child: CircleAvatar(
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/icons/png/img_sports.png',
                            image: subCat4EmptyList[index].sub3categoryIcon??'',
                          ),
                        ),
                        preferences: AnimationPreferences(
                            duration: const Duration(milliseconds: 1500),
                            autoPlay: AnimationPlayStates.Loop),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Shimmer.fromColors(
                        baseColor: Colors.blue[100],
                        highlightColor: Colors.lightBlueAccent,
                        child: Text(
                          subCat4EmptyList[index].sub3categoryName,
                          style: TextStyle(fontSize: screenHeight/18, fontFamily: 'montserrat', fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              onTap: () {
                //onTapAudio('button');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameOptionThree(gameCat1: widget.gameCat1, gameCat2: widget.gameCat2, gameCat3: gameCat3, gameCat4: subCat4EmptyList[index].sub3categoryName,),
                    settings: RouteSettings(arguments: subCat4EmptyList[index].cardType,),
                  ),
                );
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

  void alertDialogForPlayerType() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ZoomInDown(
            child: AlertDialog(
              backgroundColor: Colors.white38,
              title: Text('Choose One',
                style: TextStyle(fontSize: 26, color: Colors.white, fontFamily: 'neuropol_x_rg', fontWeight: FontWeight.bold),),
              content: Container(
                width: 250,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(top: 8),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: GestureDetector(
                        child: Text(index== 0? 'Batsman' : 'Bowler',
                          style: TextStyle(fontSize: 22, color: Colors.white, fontFamily: 'montserrat', fontWeight: FontWeight.bold),),
                        onTap: (){
                          print('---- $index');
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            preferences: AnimationPreferences(duration: const Duration(milliseconds: 1000), autoPlay: AnimationPlayStates.Forward),
          );
        });
  }
}
