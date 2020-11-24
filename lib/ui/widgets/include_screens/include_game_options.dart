import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trump_card_game/helper/constantvalues/constants.dart';

Widget buildFirstList() {
  final List<String> listData1 = <String>['Sports', 'Superheroes', 'Cartoons', 'Cars', 'Technology'];

  return ListView.builder(
    physics: const AlwaysScrollableScrollPhysics(),
    padding: EdgeInsets.fromLTRB(25.0, 2.0, 16.0, 8.0),
    itemCount: listData1.length,
    itemBuilder: (context, index) {
      if (index < 3) return SizedBox();
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Text(
                      listData1[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'montserrat',
                        color: Colors.grey[700],
                      ),
                    ),
                    new Container(
                      height: 30.0,
                      width: 1.0,
                      color: Colors.black54,
                      margin: const EdgeInsets.only(left: 16.0, right: 0.0),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 10,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 5.0, 5.0, 5.0),
                  child: Text(
                    '4,44,000\n' + listData1[index],
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'montserrat',
                      color: Colors.grey[900],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: 40,
                  height: 40,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(Constants.imgUrlTest),
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black,
            height: 1,
          ),
        ],
      );
    },
  );

}