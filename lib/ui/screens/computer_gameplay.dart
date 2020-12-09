
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_gameplay.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_player_card.dart';

class ComputerGameplay extends StatefulWidget{
  ComputerGameplay({this.name, this.friendId});

  final String name;
  final String friendId;

  @override
  _ComputerGameplayState createState() => _ComputerGameplayState();

}

class _ComputerGameplayState extends State<ComputerGameplay> {

  @override
  Widget build(BuildContext context) {
    final List<int> numbers = [1, 2, 3, 5, 8];

    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/bg_img8.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: buildPlayerOneScreen('Player One'),
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
                        SvgPicture.asset('assets/icons/svg/timer.svg', height: 30, width: 30),
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
                                    child: Text('$minutes:$seconds min',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 26)));
                              }),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: 170,
                            height: 300,
                            child: buildPlayerCard(context),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: 170,
                            height: 300,
                            child:  buildPlayerCard(context),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Expanded(
                        child: Container(
                          //padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                          height: 50,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                            scrollDirection: Axis.horizontal,
                            itemCount: numbers.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 50,
                                child: Card(
                                  color: Colors.white70,
                                  child: ClipOval(
                                    child: SvgPicture.asset('assets/icons/svg/won.svg', height: 25, width: 25),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: buildPlayerTwoScreen(context),
            ),
          ],
        ),
      ),
    );
  }

}