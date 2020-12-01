import 'package:flutter/material.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_game_options.dart';
import 'package:trump_card_game/ui/widgets/libraries/animated_text_kit/animated_text_kit.dart';

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
                  Colors.black12,
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

            IncludeGameOption()
          ],
        ),
      ),
    );
  }
}
