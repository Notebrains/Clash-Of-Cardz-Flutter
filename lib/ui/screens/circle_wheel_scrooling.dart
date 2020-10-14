import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circle_wheel_scroll/circle_wheel_scroll_view.dart';

class WheelExample extends StatelessWidget {
  Widget _buildItem(int i) {
    return Center(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(80),
            child: Container(
              width: 40,
              padding: EdgeInsets.all(5),
              color: Colors.blue[100 * ((i % 5) + 1)],
              child: Center(
                child: Text(
                  i.toString(),
                ),
              ),
            ),
          ),

          Container(
            width: 140,
            padding: EdgeInsets.all(5),
            child: Center(
              child: Text(
                  'Cricket'),
            ),
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wheel'),
      ),
      body: SafeArea(
        child: Row(
          children: [
            Center(
              child: Container(
                color: Colors.green,
                //height: 260,
                width: 350,
                child: CircleListScrollView(
                  physics: CircleFixedExtentScrollPhysics(),
                  axis: Axis.vertical,
                  itemExtent: 40,
                  children: List.generate(10, _buildItem),
                  radius: MediaQuery.of(context).size.width * 0.15,
                  onSelectedItemChanged: (int index) =>
                      print('Current index: $index'),
                ),
              ),
            ),

            Container(
              color: Colors.green,
              //height: 260,
              width: 250,
              child: CircleListScrollView(
                physics: CircleFixedExtentScrollPhysics(),
                axis: Axis.vertical,
                itemExtent: 40,
                children: List.generate(10, _buildItem),
                radius: MediaQuery.of(context).size.width * 0.15,
                onSelectedItemChanged: (int index) =>
                    print('Current index: $index'),
              ),
            ),

            Container(
              color: Colors.green,
              //height: 260,
              width: 250,
              child: CircleListScrollView(
                physics: CircleFixedExtentScrollPhysics(),
                axis: Axis.vertical,
                itemExtent: 40,
                children: List.generate(10, _buildItem),
                radius: MediaQuery.of(context).size.width * 0.15,
                onSelectedItemChanged: (int index) =>
                    print('Current index: $index'),
              ),
            ),
          ],
        )
      ),
    );
  }
}
