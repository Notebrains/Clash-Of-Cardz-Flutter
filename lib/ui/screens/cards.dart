import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:trump_card_game/helper/exten_fun/common_fun.dart';
import 'package:trump_card_game/model/responses/profile_res_model.dart';
import 'package:trump_card_game/ui/widgets/custom/carousel_auto_slider.dart';
import 'package:trump_card_game/ui/widgets/custom/frosted_glass.dart';

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
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 50.0,
        vertical: 24.0,
      ),
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 30,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 16),
              //width: MediaQuery.of(context).size.width * 0.3,
              child: Card(
                color: Colors.deepOrange,
                elevation: 12,
                shadowColor: Colors.orange,
                child: Container(
                  child: Center(
                      child: Image.asset('assets/images/img_card_demo.png'),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
