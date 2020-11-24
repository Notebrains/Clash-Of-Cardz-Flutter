import 'package:flutter/material.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_game_options_circle_list.dart';
import 'package:trump_card_game/ui/widgets/libraries/animated_text_kit/animated_text_kit.dart';
import 'package:trump_card_game/ui/widgets/libraries/semi_circle_listview/dart/circle_wheel_scroll_view.dart';

class GameOptionCircleList extends StatelessWidget {

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
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Container(
                    //height: 260,
                    width: 280,
                    child: CircleListScrollView(
                      physics: CircleFixedExtentScrollPhysics(),
                      axis: Axis.vertical,
                      itemExtent: 40,
                      children: List.generate(5, buildCircleItemsOne),
                      radius: MediaQuery.of(context).size.width * 0.22,
                      onSelectedItemChanged: (int index) =>
                          //print('Current index: $index'),
                          buildSecondList(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void buildSecondList(BuildContext context) {
    Container(
      //height: 260,
      width: 250,
      child: CircleListScrollView(
        physics: CircleFixedExtentScrollPhysics(),
        axis: Axis.vertical,
        itemExtent: 40,
        children: List.generate(4, buildCircleItemsTwo),
        radius: MediaQuery.of(context).size.width * 0.22,
        onSelectedItemChanged: (int index) =>
            //print('Current index: $index'),
            buildThirdList(context),
      ),
    );
  }

  void buildThirdList(BuildContext context) {
    Container(
      //height: 260,
      width: 250,
      child: CircleListScrollView(
        physics: CircleFixedExtentScrollPhysics(),
        axis: Axis.vertical,
        itemExtent: 40,
        children: List.generate(3, buildCircleItemsThree),
        radius: MediaQuery.of(context).size.width * 0.22,
        onSelectedItemChanged: (int index) =>
            print('Current index: $index'),
      ),
    );
  }
}
