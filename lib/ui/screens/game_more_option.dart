import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trump_card_game/helper/uihelper/circle_wheel_scroll_view.dart';
import 'package:trump_card_game/ui/widgets/custom/button_material.dart';

class GameMoreOption extends StatelessWidget {
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
                child: Text('Cricket'),
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
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Center(
                  child: Container(
                    //height: 260,
                    width: 350,
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
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        MaterialButtonShape(
                          text: 'Home',
                          icon: Icons.home,
                          color: Colors.redAccent,
                          textColor: Colors.white,
                          iconColor: Colors.redAccent,
                          iconSize: 40.0,
                          width: 200,
                          height: 70,
                          onClick: () {
                            print("Click");
                          },
                        ),
                        MaterialButtonShape(
                          text: 'Profile',
                          icon: Icons.person_outline,
                          color: Colors.green,
                          textColor: Colors.white,
                          iconColor: Colors.green,
                          iconSize: 40.0,
                          width: 200,
                          height: 70,
                        ),
                        MaterialButtonShape(
                          text: 'Feed',
                          icon: Icons.rss_feed,
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          iconColor: Colors.blue,
                          iconSize: 40.0,
                          width: 200,
                          height: 70,
                        ),
                        MaterialButtonShape(
                          text: 'Friends',
                          icon: Icons.person_add,
                          color: Colors.orange,
                          textColor: Colors.white,
                          iconColor: Colors.orangeAccent,
                          iconSize: 40.0,
                          width: 200,
                          height: 70,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
