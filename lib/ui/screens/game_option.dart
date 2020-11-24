import 'package:flutter/material.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:trump_card_game/model/responses/leaderboard_res_model.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_game_options.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_game_options_circle_list.dart';
import 'package:trump_card_game/ui/widgets/libraries/animated_text_kit/animated_text_kit.dart';
import 'package:trump_card_game/ui/widgets/libraries/semi_circle_listview/dart/circle_wheel_scroll_view.dart';

class GameOption extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/bg_img3.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              height: 150,
              child: ColorizeAnimatedTextKit(
                onTap: () {
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
                  Colors.yellow[800],
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
            StreamBuilder(
              stream: apiBloc.leaderboardRes,
              builder: (context, AsyncSnapshot<LeaderboardResModel> snapshot) {
                if (snapshot.hasData) {
                  return buildFirstList();
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
