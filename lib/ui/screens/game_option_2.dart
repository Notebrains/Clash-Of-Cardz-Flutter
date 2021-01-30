
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trump_card_game/helper/exten_fun/common_fun.dart';
import 'package:trump_card_game/model/responses/game_option_res_model.dart';
import 'package:trump_card_game/ui/screens/game_option_3.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_drawer_play_with_friends.dart';
import 'package:trump_card_game/ui/widgets/libraries/blurry_container.dart';
import 'package:trump_card_game/ui/widgets/libraries/colorize.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:trump_card_game/ui/widgets/libraries/shimmer.dart';


class GameOptionTwo extends StatefulWidget {
  final String categoryName;
  final String subcategoryName;

  const GameOptionTwo({Key key, this.categoryName, this.subcategoryName}) : super(key: key);

  @override
  _GameOptionTwoState createState() => _GameOptionTwoState(categoryName, subcategoryName);
}

class _GameOptionTwoState extends State<GameOptionTwo> {
  _GameOptionTwoState(String categoryName, String subcategoryName);

  String categoryName = '';
  String subcategoryName = '';

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  List<Subcategory_details> subcategoryDetails = [];
  List<String> cardsToBePlayed = [];

  String gameType = '';
  String cardsToPlay = '';

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
    subcategoryDetails = ModalRoute.of(context).settings.arguments;

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
                      height: cardsToBePlayed.length * 80.0,
                      width: 1.5,
                      color: Colors.indigo,
                      margin: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                    ),
                    Expanded(
                      flex: 4,
                      child: buildSecondList(cardsToBePlayed),
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

    if (subcategoryDetails.length > 0) {
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
                      child: Pulse(
                        child: CircleAvatar(
                          child: Image.asset('assets/icons/png/img_sports.png'),
                          //backgroundColor: Colors.black38,
                        ),
                        preferences: AnimationPreferences(
                            duration: const Duration(milliseconds: 1500),
                            autoPlay: AnimationPlayStates.Loop),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 16, 0, 2),
                      child: Shimmer.fromColors(
                        baseColor: Colors.black54,
                        highlightColor: Colors.orangeAccent,
                        child: Text(
                          subcategoryDetails[index].gametypeName,
                          style: TextStyle( fontSize: 22, fontFamily: 'neuropol_x_rg', fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  onTapAudio('button');
                  print('-----game type name: ${subcategoryDetails[index].gametypeName}');
                  if (subcategoryDetails[index].gametypeName == 'Player vs Multi Players') {
                    alertDialogForPlayerType();
                  } else {
                    gameType = subcategoryDetails[index].gametypeName;
                    buildSecondList(subcategoryDetails[index].cardsToBePlayed);
                    gameMoreOptState(subcategoryDetails[index].cardsToBePlayed);
                  }
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
                          style: TextStyle(fontSize: 22, fontFamily: 'neuropol_x_rg', fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              onTap: () {
                onTapAudio('button');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameOptionThree(categoryName: 'sports', subcategoryName: 'cricket'),
                    // Pass the arguments as part of the RouteSettings. The
                    // DetailScreen reads the arguments from these settings.
                    settings: RouteSettings(
                      arguments: subcategoryDetails,
                    ),
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
                style: TextStyle(fontSize: 28, color: Colors.white, fontFamily: 'neuropol_x_rg', fontWeight: FontWeight.bold),),
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
                        child: Text('batsman',
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
