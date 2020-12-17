import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trump_card_game/model/state_managements/autoplay_states_model.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_gameplay.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_player_card.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AutoPlay extends StatefulWidget {
  AutoPlay({this.name, this.friendId});

  final String name;
  final String friendId;

  @override
  _AutoPlayState createState() => _AutoPlayState();
}

class _AutoPlayState extends State<AutoPlay> with SingleTickerProviderStateMixin {
  final List<String> playerResultStatusList = ['won', 'won', 'sad', 'won', 'won', 'sad', 'sad', 'won'];
  double startPos = -1.0;
  double endPos = 0.0;
  Curve curve = Curves.elasticOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Provide the model to all widgets within the app. We're using
      // ChangeNotifierProvider because that's a simple way to rebuild
      // widgets when a model changes. We could also just use
      // Provider, but then we would have to listen to Counter ourselves.
      //
      // Read Provider's docs to learn about all the available providers.
      body: ChangeNotifierProvider(
        // Initialize the model in the builder. That way, Provider
        // can own AutoPlayStatesModel's lifecycle, making sure to call `dispose`
        // when not needed anymore.
        create: (context) => AutoPlayStatesModel(),
        child: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/bg_img11.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
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
                      flex: 2,
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
                              width: 170,
                              height: 250,
                              child: TweenAnimationBuilder(
                                tween: Tween<Offset>(begin: Offset(startPos, 0), end: Offset(endPos, 0)),
                                duration: Duration(milliseconds: 3500),
                                curve: curve,
                                builder: (context, offset, child) {
                                  return FractionalTranslation(
                                    translation: offset,
                                    child: Container(
                                      width: double.infinity,
                                      child: Center(
                                        child: child,
                                      ),
                                    ),
                                  );
                                },
                                child: buildPlayerCard(
                                  context,
                                  onClickAction: (String index, String attributeTitle, String attributeValue, String cardId) =>
                                  {
                                    context
                                        .read<AutoPlayStatesModel>()
                                        .updateAutoPlayStates(index, attributeTitle, attributeValue, cardId, true, false),
                                  },
                                ),
                                onEnd: () {
                                  print('onEnd');
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 170,
                              height: 250,
                              child: TweenAnimationBuilder(
                                tween: Tween<Offset>(begin: Offset(startPos, 0), end: Offset(endPos, 0)),
                                duration: Duration(milliseconds: 3500),
                                curve: curve,
                                builder: (context, offset, child) {
                                  return FractionalTranslation(
                                    translation: offset,
                                    child: Container(
                                      width: double.infinity,
                                      child: Center(
                                        child: child,
                                      ),
                                    ),
                                  );
                                },
                                child: buildPlayerCard(
                                  context,
                                  onClickAction: (String index, String attributeTitle, String attributeValue, String cardId) =>
                                  {
                                    context
                                        .read<AutoPlayStatesModel>()
                                        .updateAutoPlayStates(index, attributeTitle, attributeValue, cardId, true, false),
                                  },
                                ),
                                onEnd: () {
                                  print('onEnd');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
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
                                  builder: (context, statesModel, child) =>
                                      ClipOval(
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
        ),
      ),
    );
  }

  Widget setResultStatus(AutoPlayStatesModel statesModel, int index) {
    return statesModel.isCardOneTouched ? SvgPicture.asset(
        'assets/icons/svg/${playerResultStatusList[index]}.svg',
        height: 25,
        width: 25) : SvgPicture.asset(
        'assets/icons/svg/${playerResultStatusList[index]}.svg',
        height: 25,
        width: 25);
  }

/*slideAnimCard() {
    TweenAnimationBuilder(
      tween: Tween<Offset>(begin: Offset(startPos, 0), end: Offset(endPos, 0)),
      duration: Duration(seconds: 1),
      curve: curve,
      builder: (context, offset, child) {
        return FractionalTranslation(
          translation: offset,
          child: Container(
            width: double.infinity,
            child: Center(
              child: child,
            ),
          ),
        );
      },
      child: buildPlayerCard(
        context,
        onClickAction: (String index) => {
          //debugPrint(index)

        },
      ),
      onEnd: () {
        print('onEnd');
      },
    );
  }*/
}
