import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:trump_card_game/helper/exten_fun/common_fun.dart';
import 'package:trump_card_game/model/responses/profile_res_model.dart';
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

class GameRule extends StatefulWidget {

  GameRule({this.xApiKey, this.memberId});
  final String xApiKey;
  final String memberId;

  @override
  State<StatefulWidget> createState() {
    return _GameRuleState();
  }
}

class _GameRuleState extends State<GameRule> {
  BuildContext context;
  final CarouselController _controller = CarouselController();

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

  List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 16.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  child: Stack(
                    children: <Widget>[
                      /*Image.network(
                  item,
                  fit: BoxFit.fill,
                  width: double.infinity
              ),*/

                      FadeInImage.assetNetwork(
                        fit: BoxFit.fill,
                        placeholder: 'assets/animations/gifs/loading_text.gif',
                        image: item??'',
                        width: double.infinity - 60,
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              '${imgList.indexOf(item) + 1}. How to play the game',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();

  Widget buildUI() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          /*SizedBox(
            height: 16,
          ),*/
          CarouselSlider(
            items: imageSliders,
            options:
                CarouselOptions(viewportFraction: 1.0, enlargeCenterPage: true, height: MediaQuery.of(context).size.height - 68),
            carouselController: _controller,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  alignment: Alignment.center,
                  child: new SizedBox(
                    child: FloatingActionButton(
                      tooltip: 'Back to previous screen',
                      backgroundColor: Colors.grey[300],
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        onTapAudio('button');
                        _controller.previousPage();
                      },
                    ),
                  ),
                ),
                ...Iterable<int>.generate(imgList.length).map(
                  (int pageIndex) => Flexible(
                    child: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        child: new SizedBox(
                            child: FloatingActionButton(
                              tooltip: 'Next',
                          backgroundColor: Colors.grey[300],
                          child: Text(
                            "${pageIndex + 1}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'neuropol_x_rg',
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          onPressed: () {
                            onTapAudio('button');
                            _controller.animateToPage(pageIndex);
                          },
                        ))),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  alignment: Alignment.center,
                  child: new SizedBox(
                    child: FloatingActionButton(
                      tooltip: 'Previous',
                      backgroundColor: Colors.grey[300],
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        onTapAudio('button');
                        _controller.nextPage();
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
