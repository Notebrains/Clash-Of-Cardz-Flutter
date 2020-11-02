import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trump_card_game/helper/uihelper/circle_wheel_scroll_view.dart';
import 'package:trump_card_game/ui/widgets/libraries/animated_text_kit/animated_text_kit.dart';

class GameOption extends StatelessWidget {
  Widget _buildCircleItems(int i) {
    return Container(
        margin: EdgeInsets.only(left: 80),
      child: Row(
        children: [
          Container(
            width: 40,
            padding: EdgeInsets.all(5),
            //color: Colors.white,
            child: Center(
              child: Text(i.toString(),
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w900)),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.orange,
                  spreadRadius: 2,
                  blurRadius: 3),
              ],
            ),
          ),

          Container(
            width: 120,
            padding: EdgeInsets.all(5),
            child: Center(
              child: Listener
                (child: Text('Cricket'),
                onPointerDown: (PointerDownEvent event) {
                  print("tap up -----");
                },
                onPointerUp: (PointerUpEvent event) {
                  print("tap up---- ");
                },
              ),
            ),
          ),
        ],
      )
    );
  }

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
                  text: [
                    "CLASH OF CARDZ"
                  ],
                  textStyle: TextStyle(
                      fontSize: 55.0,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Rapier'
                  ),
                  colors: [
                    Colors.grey[700],
                    Colors.deepOrange,
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
                      children: List.generate(15, _buildCircleItems),
                      radius: MediaQuery.of(context).size.width * 0.22,
                      onSelectedItemChanged: (int index) =>
                          print('Current index: $index'),
                    ),
                  ),

                  Container(
                    //height: 260,
                    width: 250,
                    child: CircleListScrollView(
                      physics: CircleFixedExtentScrollPhysics(),
                      axis: Axis.vertical,
                      itemExtent: 40,
                      children: List.generate(15, _buildCircleItems),
                      radius: MediaQuery.of(context).size.width * 0.22,
                      onSelectedItemChanged: (int index) =>
                          print('Current index: $index'),
                    ),
                  ),

                  Container(
                    //height: 260,
                    width: 250,
                    child: CircleListScrollView(
                      physics: CircleFixedExtentScrollPhysics(),
                      axis: Axis.vertical,
                      itemExtent: 40,
                      children: List.generate(15, _buildCircleItems),
                      radius: MediaQuery.of(context).size.width * 0.22,
                      onSelectedItemChanged: (int index) =>
                          print('Current index: $index'),
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
}
