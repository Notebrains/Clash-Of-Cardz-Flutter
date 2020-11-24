import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget buildCircleItemsOne(int i) {
  final List<String> listData1 = <String>['Sports', 'Superheroes', 'Cartoons', 'Cars', 'Technology'];

  return Container(
      margin: EdgeInsets.only(left: 80),
      child: Row(
        children: [
          CircleAvatar(
            child: SvgPicture.asset('assets/icons/svg/cricket.svg'),
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
                child: Text(listData1[i],
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

Widget buildCircleItemsTwo(int i) {
  final List<String> listDataSports = <String>['Cricket', 'Football', 'Basketball', 'Tennis'];

  return Container(
      margin: EdgeInsets.only(left: 80),
      child: Row(
        children: [
          CircleAvatar(
            child: SvgPicture.asset('assets/icons/svg/cricket.svg'),
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
                child: Text(listDataSports[i],
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

Widget buildCircleItemsThree(int i) {

  final List<String> listDataSuperHero = <String>['Avenger', 'Bollywood', 'Hollywood'];

  return Container(
      margin: EdgeInsets.only(left: 80),
      child: Row(
        children: [
          CircleAvatar(
            child: SvgPicture.asset(
                'assets/icons/svg/cricket.svg'),
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
                child: Text(listDataSuperHero[i],
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