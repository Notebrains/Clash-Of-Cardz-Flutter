import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Leaderboard extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/bg_img11.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: Text(
                          'LEADERBOARD',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 35.0,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Rapier',
                            color: Colors.grey[700],
                          ),
                        ),
                      ),

                      Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: ClipRRect(
                              child: SizedBox(
                                width: 115,
                                height: 120,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.greenAccent[700],
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.blueGrey,
                                        offset: Offset(5, 5),
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: topPlayerCards(
                                      'assets/icons/svg/madel_first.svg',
                                      '43,55,678', ''),
                                ),
                              ),
                              borderRadius: new BorderRadius.circular(8.0),
                            ),
                          ),
                          ClipRRect(
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                  'assets/images/img_person_demo.jpg'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.topCenter,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 20.0, 20.0, 0.0),
                                child: ClipRRect(
                                  child: SizedBox(
                                    width: 115,
                                    height: 120,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.cyan[600],
                                      ),
                                      child: topPlayerCards(
                                          'assets/icons/svg/leaf_second.svg',
                                          '43,55,678', ''),
                                    ),
                                  ),
                                  borderRadius: new BorderRadius.circular(
                                      8.0),
                                ),
                              ),
                              ClipRRect(
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/images/img_person_demo.jpg'),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            alignment: Alignment.topCenter,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 20.0, 20.0, 0.0),
                                child: ClipRRect(
                                  child: SizedBox(
                                    width: 115,
                                    height: 120,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: Colors.indigo[900]
                                      ),
                                      child: topPlayerCards(
                                          'assets/icons/svg/leaf_third.svg',
                                          '43,55,678', ''),
                                    ),
                                  ),
                                  borderRadius: new BorderRadius.circular(
                                      8.0),
                                ),
                              ),
                              ClipRRect(
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/images/img_person_demo.jpg'),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 12.0, 2.0, 0.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex:1,
                              child: Text(
                                'Rank',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'montserrat',
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),

                            Expanded(
                              flex:5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Point/Name',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'montserrat',
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              flex:1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Text(
                                  'Image',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'montserrat',
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                        height: 1,
                        thickness: 1,
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.fromLTRB(10.0, 2.0, 12.0, 8.0),
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex:1,
                                      child: Row(
                                        children: [
                                          Text(
                                            '4',
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
                                      flex:10,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '4,44,000\nPlayer Name',
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
                                      flex:1,
                                      child: Container(
                                        width:40,
                                        height: 40,
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              'assets/images/img_person_demo.jpg'),
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
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }

  Column topPlayerCards(String image, String points, String playerName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/icons/png/ic_points.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(points,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900)),
              ),
            ],
          ),


        ),
        Text("Player Name",
            style: TextStyle(
                color: Colors.white)),
        IconButton(
          icon: SvgPicture.asset(
            image,
            width: 25,
            height: 25,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
