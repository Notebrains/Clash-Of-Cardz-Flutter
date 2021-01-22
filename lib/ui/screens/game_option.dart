import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_game_options.dart';
import 'package:trump_card_game/ui/widgets/libraries/animated_text_kit/animated_text_kit.dart';

class GameOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                    //print("Tap Event");
                  },
                  text: ["CLASH OF CARDZ"],
                  textStyle: TextStyle(
                    fontSize: 55.0,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'Rapier',
                  ),
                  colors: [
                    Colors.grey[300],
                    Colors.grey[200],
                    Colors.grey[300],
                  ],
                  textAlign: TextAlign.center,
                  alignment: AlignmentDirectional.center,
                  // or Alignment.topLeft
                  isRepeatingAnimation: true,
                  repeatForever: true,
                  speed: Duration(milliseconds: 1000),
                ),
              ),

              IncludeGameOption(),

              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 16, 16),
                child: Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: FloatingActionButton(
                    mini: true,
                    tooltip: 'Back to previous screen',
                    backgroundColor: Colors.grey[400],
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
