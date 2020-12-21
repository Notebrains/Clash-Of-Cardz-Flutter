import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:trump_card_game/helper/constantvalues/constants.dart';
import 'package:trump_card_game/model/state_managements/autoplay_states_model.dart';
import 'package:trump_card_game/ui/widgets/custom/frosted_glass.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_gameplay.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_player_card.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:trump_card_game/model/responses/cards_res_model.dart';
import 'package:flutter_animator/flutter_animator.dart';

class AutoPlay extends StatelessWidget {
  AutoPlay({this.name, this.friendId});

  final List<String> playerResultStatusList = ['won', 'won', 'sad', 'won', 'won', 'sad', 'sad', 'won'];
  final String name;
  final String friendId;

  @override
  Widget build(BuildContext context) {
    apiBloc.fetchCardsRes("ZGHrDz4prqsu4BcApPaQYaGgq", 'cricket', 'sports', '2', '14');

    return Scaffold(
      // Provide the model to all widgets within the app. We're using
      // ChangeNotifierProvider because that's a simple way to rebuild
      // widgets when a model changes. We could also just use
      // Provider, but then we would have to listen to Counter ourselves.
      // Read Provider's docs to learn about all the available providers.
      body: ChangeNotifierProvider(
        // Initialize the model in the builder. That way, Provider
        // can own AutoPlayStatesModel's lifecycle, making sure to call `dispose`
        // when not needed anymore.
        create: (context) => AutoPlayStatesModel(),
        child: StreamBuilder(
          stream: apiBloc.cardsRes,
          builder: (context, AsyncSnapshot<CardsResModel> snapshot) {
            if (snapshot.hasData) {
              return Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/bg_img11.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: BuildPlayerOneScreen(),
                        ),
                        Expanded(
                          flex: 7,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Lottie.asset('assets/animations/lottiefiles/timer-moving.json', height: 50, width: 50),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0, top: 6),
                                      child: TweenAnimationBuilder<Duration>(
                                          duration: Duration(minutes: 3),
                                          tween: Tween(begin: Duration(minutes: 3), end: Duration.zero),
                                          onEnd: () {
                                            print('Timer Ended');
                                          },
                                          builder: (BuildContext context, Duration value, Widget child) {
                                            final minutes = value.inMinutes;
                                            final seconds = value.inSeconds % 60;
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 5),
                                              child: Text(
                                                '$minutes:$seconds min',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 26,
                                                  shadows: [
                                                    Shadow(color: Colors.white),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 200,
                                        height: 250,
                                        child: BounceInLeft(
                                          child: buildPlayerCard(
                                            context,
                                            snapshot.data.response.cards,
                                            onClickAction:
                                                (String index, String attributeTitle, String attributeValue, String cardId) => {
                                              context.read<AutoPlayStatesModel>().updateAutoPlayStates(
                                                  index, attributeTitle, attributeValue, cardId, true, false),
                                            },
                                          ),
                                          preferences: AnimationPreferences(
                                              duration: const Duration(milliseconds: 1500),
                                              autoPlay: AnimationPlayStates.Forward),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Container(
                                        width: 170,
                                        height: 250,
                                        child: BounceInRight(
                                          child: buildPlayerTwoCard(
                                            context,
                                            snapshot.data.response.cards,
                                            onClickActionP2:
                                                (String index, String attributeTitle, String attributeValue, String cardId) => {
                                              context.read<AutoPlayStatesModel>().updateAutoPlayStates(
                                                  index, attributeTitle, attributeValue, cardId, true, false),
                                              if ('win' == 'win') {playerResultStatusList.add("won")}
                                            },
                                          ),
                                          preferences: AnimationPreferences(
                                              duration: const Duration(milliseconds: 1500),
                                              autoPlay: AnimationPlayStates.Forward),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                                    height: 40,
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: playerResultStatusList.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          elevation: 5,
                                          shadowColor: Colors.lightBlueAccent,
                                          color: Colors.white60,
                                          child: Consumer<AutoPlayStatesModel>(
                                            builder: (context, statesModel, child) => ClipOval(
                                              child: setResultStatus(statesModel, index),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: BuildPlayerTwoScreen(),
                        ),
                      ],
                    ),
                    showWinnerResult(),
                  ],
                ),
              );
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

  Widget setResultStatus(AutoPlayStatesModel statesModel, int index) {
    return statesModel.isCardOneTouched
        ? SvgPicture.asset('assets/icons/svg/${playerResultStatusList[index]}.svg', height: 25, width: 25)
        : SvgPicture.asset('assets/icons/svg/${playerResultStatusList[index]}.svg', height: 25, width: 25);
  }

  Widget showWinnerResult() {
    return '1' == '2'
        ? Stack(children: <Widget>[
            Center(
              child: Lottie.asset(
                'assets/animations/lottiefiles/win-result.json',
                height: 290,
                width: 290,
                //repeat: false,
                //animate: true
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.network(
                      Constants.imgUrlTest,
                      fit: BoxFit.fill,
                      width: 65,
                      height: 65,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Player Name',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'neuropol_x_rg',
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                    ),
                  ),
                ],
              ),
            ),
          ])
        : Container();
  }
}
