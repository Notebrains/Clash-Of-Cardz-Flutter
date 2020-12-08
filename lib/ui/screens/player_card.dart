import 'package:flutter/material.dart';
import 'package:trump_card_game/helper/constantvalues/constants.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:shape_of_view/shape_of_view.dart';

class PlayerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PlayerCardStateFull(),
      ),
    );
  }
}

class PlayerCardStateFull extends StatefulWidget {
  PlayerCardStateFull({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PlayerCardState();
}

class PlayerCardState extends State<PlayerCardStateFull> {
  @override
  void initState() {
    setScreenOrientationToLandscape();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            GridView.count(
              crossAxisCount: 4,
              children: new List<Widget>.generate(
                16,
                (index) {
                  return new GridTile(
                    child: new Card(
                        color: Colors.blue.shade200,
                        child: new Center(
                          child: new Text('tile $index'),
                        )),
                  );
                },
              ),
            ),
            ShapeOfView(
              elevation: 12,
              width: 200,
              height: 250,
              shape: DiagonalShape(
                angle: DiagonalAngle.deg(angle: 15),
              ),
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/bg_card_back.png",
                    fit: BoxFit.fitHeight,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 40, top: 20),
                        child: RotationTransition(
                          alignment: Alignment.topLeft,
                          turns: new AlwaysStoppedAnimation(90 / 360),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Hugh Jackman",
                                  style: TextStyle(fontWeight: FontWeight.w200, color: Colors.white, fontSize: 20, shadows: [
                                    Shadow(color: Colors.white, blurRadius: 1, offset: Offset(1, 1)),
                                  ]),
                                ),
                              ),
                              ShapeOfView(
                                height: 30,
                                width: 30,
                                shape: CircleShape(borderColor: Colors.orange, borderWidth: 1),
                                elevation: 12,
                                child: Image.asset(
                                  "assets/images/img_person_demo.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
