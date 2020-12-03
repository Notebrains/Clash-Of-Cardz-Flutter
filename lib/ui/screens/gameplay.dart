import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_gameplay.dart';
import 'package:trump_card_game/ui/widgets/views/view_widgets.dart';

import 'login.dart';

class Gameplay extends StatelessWidget {

  Gameplay({this.name, this.friendId});
  final String name;
  final String friendId;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final List<int> numbers = [1, 2, 3, 5, 8];

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
                child: buildPlayerOneScreen(name),
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
                child: buildPlayerTwoScreen(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
