import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Statistics extends StatelessWidget {
  // This widget is the root of your application.
  final List<String> entries = <String>['A', 'B', 'C', 'C', 'C', 'C', 'C', 'C', 'C', 'C', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(

          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/bg_img13.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 4.0),
                child: Text(
                  'Statistics',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35.0,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'Rapier',
                    color: Colors.grey[700],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    final count = index + 1;
                    return Container(
                      margin: EdgeInsets.all(5),
                      decoration: new BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.1, 0.3, 1],
                            colors: [Colors.grey[300], Colors.grey[50], Colors.grey[300]]),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(3, 3),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Stack(
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: SvgPicture.asset(
                                                'assets/icons/svg/victory.svg'),
                                            onPressed: () {},
                                          ),
                                          Container(
                                            padding: new EdgeInsets.all(5),
                                            child: new Text("Victory",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 20,
                                                    fontStyle:
                                                    FontStyle.normal,
                                                    fontFamily: 'Rapier')),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 40,
                                  padding: EdgeInsets.only(right: 8),
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Container(
                                    child: new Text("Cricket-16 cards",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 20,
                                            fontStyle: FontStyle.normal,
                                            fontFamily: 'Rapier')),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Divider(
                            color: Colors.deepOrange,
                            height: 1,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  alignment: AlignmentDirectional.center,
                                  margin: EdgeInsets.all(5.0),
                                  child: Stack(
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 24,
                                            backgroundImage: AssetImage(
                                                'assets/images/img_person_demo.jpg'),
                                          ),
                                          Container(
                                            width: 110,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .fromLTRB(
                                                      12.0, 3.0, 3.0, 0.0),
                                                  child: Text("Player Name",
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w900)),
                                                ),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      icon: SvgPicture.asset(
                                                        'assets/icons/svg/coin.svg',
                                                        width: 18,
                                                        height: 18,
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                    Text("200",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .black54,
                                                            fontWeight:
                                                            FontWeight
                                                                .w900)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Image.asset(
                                'assets/icons/png/img_vs.png',
                                width: 50,
                                height:50,
                                color: Colors.deepOrangeAccent,),

                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  alignment: AlignmentDirectional.centerEnd,
                                  margin: EdgeInsets.all(5.0),
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Column(
                                            children: [
                                              Text("Player Name",
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.w900)),
                                              Row(
                                                children: [
                                                  Text("200",
                                                      style: TextStyle(
                                                          color:
                                                          Colors.black54,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900)),
                                                  IconButton(
                                                    icon: SvgPicture.asset(
                                                      'assets/icons/svg/coin.svg',
                                                      width: 18,
                                                      height: 18,
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        CircleAvatar(
                                          radius: 24,
                                          backgroundImage: AssetImage(
                                              'assets/images/img_person_demo.jpg'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
