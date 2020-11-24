import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trump_card_game/helper/constantvalues/constants.dart';

Widget userList(BuildContext context, int index) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(36)),
    ),
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 3,),
            borderRadius: BorderRadius.all(Radius.circular(35)),
          ),
          child: CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(Constants.imgUrlTest),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 0, 2),
                child: Text(
                  'Player Name',
                  style: TextStyle(
                      color: Colors.white, fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text('Online',
                    style: TextStyle(color: Colors.white, fontSize: 13, letterSpacing: .3)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
