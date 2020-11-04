import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trump_card_game/ui/widgets/libraries/animated_text_kit/animated_text_kit.dart';
import 'package:trump_card_game/ui/widgets/libraries/semi_circle_listview/dart/circle_wheel_scroll_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GameOption extends StatelessWidget {
  Widget _buildCircleItems(int i) {
    return Container(
        margin: EdgeInsets.only(left: 80),
        child: Row(
          children: [
            CircleAvatar(
              child: IconButton(
                icon: SvgPicture.asset(
                    'assets/icons/svg/cricket.svg'),
                onPressed: () {
                  print('------');
                },
              ),
            ),

            /*Container(
              width: 40,
              padding: EdgeInsets.all(5),
              //color: Colors.white,
              child: Center(
                child: Text(i.toString(),
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.w900)),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.orange, spreadRadius: 2, blurRadius: 3),
                ],
              ),
            ),*/
            Container(
              padding: EdgeInsets.only(left: 16),
              child: Center(
                child: Listener(
                  child: Text('Cricket',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        color: Colors.grey[800]),),
                ),
              ),
            ),
          ],
        ));
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
                text: ["CLASH OF CARDZ"],
                textStyle: TextStyle(
                  fontSize: 55.0,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Rapier',
                ),
                colors: [
                  Colors.grey[400],
                  Colors.deepOrange[400],
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
