import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trump_card_game/ui/screens/home.dart';
import 'package:trump_card_game/ui/screens/statistics.dart';
import 'package:trump_card_game/ui/widgets/views/shimmer.dart';
import 'package:trump_card_game/ui/widgets/views/view_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/bg_img4.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300],
                            highlightColor: Colors.grey[100],
                            enabled: true,
                            child: Center(
                              child: Text(
                                'PROFILE',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 35.0,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'montserrat',
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                          ),
                        ),

                        Container(
                          width: 70,
                          height: 70,
                          margin: EdgeInsets.all(5),
                          decoration: Views.boxDecorationWidgetForPngImage(
                              'assets/images/img_person_demo.jpg',
                              4.0,
                              Colors.grey,
                              5.0,
                              5.0,
                              3.0),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Elena Denrik",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),

                        Text(
                          "Elena | @MIS005321",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            "Since: 1st Jan, 2002",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'montserrat',
                                color: Colors.black),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            "20y, Female, Kol-IND",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'montserrat',
                                color: Colors.black),
                          ),
                        ),

                        //Statistics button
                        Container(
                          width: 170,
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          child: RaisedButton(
                            elevation: 5,
                            child: const Text('View Statistics',
                                style: TextStyle(fontSize: 16)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Statistics()));
                            },
                          ),
                        ),

                        IconButton(
                          iconSize: 35,
                          icon: SvgPicture.asset(
                              'assets/icons/svg/back_black.svg'),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HomeScreen()));
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    iconSize: 55,
                                    icon: SvgPicture.asset(
                                        'assets/icons/svg/podium.svg'),
                                    onPressed: () {},
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      "1st",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: 'montserrat',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                  ),
                                  Text(
                                    "RANK",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: 'montserrat',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.all(12),
                                    iconSize: 40,
                                    icon: SvgPicture.asset(
                                        'assets/icons/svg/coin.svg'),
                                    onPressed: () {},
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      "3,000",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: 'montserrat',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                  ),
                                  Text(
                                    "POINTS",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: 'montserrat',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  iconSize: 50,
                                  icon: SvgPicture.asset(
                                      'assets/icons/svg/victory.svg'),
                                  onPressed: () {},
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    "50",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: 'montserrat',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ),
                                Text(
                                  "MATCH",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: 'montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  iconSize: 50,
                                  icon: SvgPicture.asset(
                                      'assets/icons/svg/won.svg'),
                                  onPressed: () {},
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(45, 0, 45, 0),
                                  child: Text(
                                    "35",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: 'montserrat',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ),
                                Text(
                                  "WON",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: 'montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  iconSize: 50,
                                  icon: SvgPicture.asset(
                                      'assets/icons/svg/lost.svg'),
                                  onPressed: () {},
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    "15",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: 'montserrat',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ),
                                Text(
                                  "LOSE",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: 'montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
