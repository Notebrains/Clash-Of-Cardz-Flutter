import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:trump_card_game/helper/exten_fun/common_fun.dart';
import 'package:trump_card_game/model/responses/profile_res_model.dart';
import 'package:trump_card_game/ui/widgets/custom/card_shape_background.dart';
import 'package:trump_card_game/ui/widgets/custom/frosted_glass.dart';
import 'package:lottie/lottie.dart';
import 'package:trump_card_game/ui/widgets/libraries/colorize.dart';

List<String> imgList = [
  'https://urbanmatter.com/chicago/wp-content/uploads/2020/04/Switch_RingFitAdventure_1200x675.jpg',
  'https://images.crazygames.com/basketball-legends-2020/20200916082052/basketball-legends-2020-cover?auto=format,compress&q=100&cs=strip',
  'https://assets.pokemon.com/assets//cms2/img/trading-card-game/_tiles/how-to-play/tcg-how-to-play-169.jpg',
  'https://www.cbc.ca/kids/images/soccerhero_play.png',
  'https://www.taminggaming.com/cms/graphics/screen_shot_2242.png',
  'https://thumbs.videogamer.com/duniaEO8faz37xybe7XcfB6g8no=/960x540/smart/https://s.videogamer.com/meta/9535/945ce33b-43f2-493a-8b30-71e9f2e0eef4_3532583-screen_shot_2019-05-10_at_2.01.24_pm.jpg',
  'https://is1-ssl.mzstatic.com/image/thumb/Purple71/v4/bf/16/01/bf160198-18a6-2eb1-54fb-798ca4d3d9f1/mzl.itlosrgt.png/1080x800bb.jpg',
];

class Cards extends StatefulWidget {

  Cards({this.xApiKey, this.memberId});
  final String xApiKey;
  final String memberId;

  @override
  State<StatefulWidget> createState() {
    return _GameRuleState();
  }
}

class _GameRuleState extends State<Cards> {
  BuildContext context;
  final CarouselController _controller = CarouselController();
  int _index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    setScreenOrientationToLandscape();
    apiBloc.fetchProfileRes('ZGHrDz4prqsu4BcApPaQYaGgq', "MEM000001");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/bg_img13.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder(
          stream: apiBloc.profileRes,
          builder: (context, AsyncSnapshot<ProfileResModel> snapshot) {
            if (snapshot.hasData && snapshot.data.response.length > 0) {
              return buildUI();
            } else if (!snapshot.hasData) {
              return frostedGlassWithProgressBarWidget(context);
            } else
              return Center(
                child: Text("No Data Found", style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 30)),
              );
          },
        ),
      ),
    );
  }

  Widget buildUI() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: Row(
              children: [
                FloatingActionButton(
                  tooltip: 'Back to previous screen',
                  backgroundColor: Colors.amber[900],
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    onTapAudio('button');
                    Navigator.pop(context);
                  },
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 4.0),
                  child: ColorizeAnimatedTextKit(
                    onTap: () {
                      //print("Tap Event");
                    },
                    text: [
                      "GAME CARDS"
                    ],
                    textStyle: TextStyle(
                        fontSize: 35.0,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Rapier'
                    ),
                    colors: [
                      Colors.grey[700],
                      Colors.amber[900],
                      Colors.grey[700],
                    ],
                    textAlign: TextAlign.center,
                    alignment: AlignmentDirectional.center,
                    // or Alignment.topLeft
                    isRepeatingAnimation: true,
                    repeatForever: true,
                    speed: Duration(milliseconds: 1000),
                  ),
                ),
              ],
            ),
          ),
        ),

        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 50.0,
            vertical: 24.0,
          ),
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 11,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(15, 5, 5, 16),
                  //width: MediaQuery.of(context).size.width * 0.3,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ClipPath(
                          clipper: CharacterCardBackgroundClipper(),
                          child: Container(
                            height: 280,
                            width: 220,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.orange.shade400, Colors.deepOrange],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(50, -0.9),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Lottie.asset('assets/animations/lottiefiles/confused_robot-bot-3d.json', width: 250, height: 290),
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 99, right: 16, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Hero(
                              tag: "Cricket}",
                              child: Material(
                                color: Colors.transparent,
                                child: Container(
                                  child: ColorizeAnimatedTextKit(
                                    onTap: () {
                                      //print("Tap Event");
                                    },
                                    text: [
                                      "CRICKET"
                                    ],
                                    textStyle: TextStyle(
                                        fontSize: 30.0,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: 'Rapier'
                                    ),
                                    colors: [
                                      Colors.black54,
                                      Colors.white60,
                                      Colors.black54,
                                    ],
                                    textAlign: TextAlign.center,
                                    alignment: AlignmentDirectional.center,
                                    // or Alignment.topLeft
                                    isRepeatingAnimation: true,
                                    repeatForever: true,
                                    speed: Duration(milliseconds: 200),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
