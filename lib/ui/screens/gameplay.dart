import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Gameplay extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final List<int> numbers = [1, 2, 3, 5, 8, 13];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/bg_img8.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                //padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                                height: 40,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: numbers.length,
                                    itemBuilder: (context, index) {
                                      return ClipRRect(
                                        child: Image.asset(
                                          'assets/images/img_card_demo.png',
                                          width: 25,
                                        ),
                                      );
                                    }),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 150,
                                  height: 95,
                                  alignment: AlignmentDirectional.bottomStart,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(3, 3),
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.all(5.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Player Name",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 45,
                                            color: Colors.black,
                                            padding: EdgeInsets.all(8),
                                            child: Text(
                                              "10",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Container(
                                            width: 50,
                                            color: Colors.black,
                                            padding: EdgeInsets.all(8),
                                            margin:
                                                EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            child: Text(
                                              "05",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Container(
                                            width: 45,
                                            color: Colors.black,
                                            padding: EdgeInsets.all(8),
                                            child: Text(
                                              "00",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              "LEFT",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontStyle: FontStyle.normal,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Text(
                                            "POINTS",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontStyle: FontStyle.normal,
                                                color: Colors.white),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              "TRUMP",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontStyle: FontStyle.normal,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 35,
                                  height: 35,
                                  child: IconButton(
                                    icon: Image.asset(
                                        'assets/icons/png/ic_right.png'),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: 150,
                                  height: 95,
                                  alignment: AlignmentDirectional.topStart,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(3, 3),
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.all(5.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Player Name",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 45,
                                            color: Colors.black,
                                            padding: EdgeInsets.all(8),
                                            child: Text(
                                              "10",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Container(
                                            width: 50,
                                            color: Colors.black,
                                            padding: EdgeInsets.all(8),
                                            margin:
                                                EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            child: Text(
                                              "05",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Container(
                                            width: 45,
                                            color: Colors.black,
                                            padding: EdgeInsets.all(8),
                                            child: Text(
                                              "00",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              "LEFT",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontStyle: FontStyle.normal,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Text(
                                            "POINTS",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontStyle: FontStyle.normal,
                                                color: Colors.white),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              "TRUMP",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontStyle: FontStyle.normal,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/svg/timer.svg',
                              height: 30, width: 30),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "15:05 min",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              width: 170,
                              height: 300,
                              child: Image.asset(
                                  'assets/images/img_card_demo.png'),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              width: 170,
                              height: 300,
                              child: Image.asset(
                                  'assets/images/img_card_demo.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Expanded(
                          child: Container(
                            //padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                            height: 50,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: numbers.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 50,
                                    child: Card(
                                      color: Colors.white70,
                                      child: ClipOval(
                                        child: SvgPicture.asset(
                                            'assets/icons/svg/won.svg',
                                            height: 30,
                                            width: 30),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 150,
                          height: 95,
                          alignment: AlignmentDirectional.topEnd,
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(3, 3),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          margin: EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  "Player Name",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 45,
                                    color: Colors.black,
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "10",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    width: 50,
                                    color: Colors.black,
                                    padding: EdgeInsets.all(8),
                                    margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: Text(
                                      "05",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    width: 45,
                                    color: Colors.black,
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "00",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "LEFT",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Text(
                                    "POINTS",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.white),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "TRUMP",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  width: 150,
                                  height: 95,
                                  alignment: AlignmentDirectional.bottomStart,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(3, 3),
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.all(5.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Player Name",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 45,
                                            color: Colors.black,
                                            padding: EdgeInsets.all(8),
                                            child: Text(
                                              "10",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Container(
                                            width: 50,
                                            color: Colors.black,
                                            padding: EdgeInsets.all(8),
                                            margin:
                                                EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            child: Text(
                                              "05",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Container(
                                            width: 45,
                                            color: Colors.black,
                                            padding: EdgeInsets.all(8),
                                            child: Text(
                                              "00",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              "LEFT",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontStyle: FontStyle.normal,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Text(
                                            "POINTS",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontStyle: FontStyle.normal,
                                                color: Colors.white),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              "TRUMP",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontStyle: FontStyle.normal,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
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
