import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:trump_card_game/ui/widgets/libraries/flip_card.dart';

class PlayerCard extends StatelessWidget {
  List<String> images = [
    "https://uae.microless.com/cdn/no_image.jpg",
    "https://images-na.ssl-images-amazon.com/images/I/81aF3Ob-2KL._UX679_.jpg",
    "https://www.boostmobile.com/content/dam/boostmobile/en/products/phones/apple/iphone-7/silver/device-front.png.transform/pdpCarousel/image.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgUgs8_kmuhScsx-J01d8fA1mhlCR5-1jyvMYxqCB8h3LCqcgl9Q",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgUgs8_kmuhScsx-J01d8fA1mhlCR5-1jyvMYxqCB8h3LCqcgl9Q",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgUgs8_kmuhScsx-J01d8fA1mhlCR5-1jyvMYxqCB8h3LCqcgl9Q",
    "https://ae01.alicdn.com/kf/HTB11tA5aiAKL1JjSZFoq6ygCFXaw/Unlocked-Samsung-GALAXY-S2-I9100-Mobile-Phone-Android-Wi-Fi-GPS-8-0MP-camera-Core-4.jpg_640x640.jpg",
    "https://media.ed.edmunds-media.com/gmc/sierra-3500hd/2018/td/2018_gmc_sierra-3500hd_f34_td_411183_1600.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
            width: 180,
            height: 300,
            child: FlipCard(
              flipOnTouch: false,
              direction: FlipDirection.HORIZONTAL,
              speed: 1000,
              key: cardKey,
              onFlipDone: (status) {
                //print(status);
              },
              front: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color(0x40000000),
                      blurRadius: 30.0,
                      offset: Offset(0.0, 30.0),
                    ),
                  ],
                ),
                child: GestureDetector(
                  child: Image.asset(
                    'assets/images/bg_card_back.png',
                    width: getScreenWidth(context),
                    height: getScreenHeight(context),
                    fit: BoxFit.fill,
                  ),
                  onTap: (){
                    cardKey.currentState.toggleCard();
                  },
                ),
              ),
              back: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color(0x60000000),
                      blurRadius: 30.0,
                      offset: Offset(0.0, 30.0),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/bg_card_back.png',
                      width: getScreenWidth(context),
                      height: getScreenHeight(context),
                      fit: BoxFit.fill,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GridView(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        // if you want IOS bouncing effect, otherwise remove this line
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                          childAspectRatio: 3 / 2,
                        ),
                        padding: EdgeInsets.all(5),
                        //change the number as you want
                        children: images.map((url) {
                          return Container(
                            //margin: EdgeInsets.only(left: 5, right: 5),
                            margin: EdgeInsets.symmetric(vertical: 1, horizontal: 2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "280",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: 'neuropol_x_rg',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.indigo),
                                    ),
                                    Stack(children: <Widget>[
                                      Image.asset(
                                        'assets/icons/png/stars.png',
                                        color: Colors.yellow,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 7, top: 3),
                                        child: Text(
                                          "1",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 8,
                                              fontFamily: 'neuropol_x_rg',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ]),
                                  ],
                                ),
                                Text(
                                  "Match",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 9,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: 'neuropol_x_rg',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8, top: 3),
                                  child: Divider(
                                    color: Colors.white,
                                    thickness: 1,
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 30, top: 5),
                          child: RotationTransition(
                            alignment: Alignment.topLeft,
                            turns: new AlwaysStoppedAnimation(90 / 360),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Text(
                                    "Hugh Jackman",
                                    style: TextStyle(fontWeight: FontWeight.w200, color: Colors.white, fontSize: 18, shadows: [
                                      Shadow(color: Colors.white, blurRadius: 1, offset: Offset(1, 1)),
                                    ]),
                                  ),
                                ),
                                ShapeOfView(
                                  height: 20,
                                  width: 20,
                                  shape: CircleShape(borderColor: Colors.white, borderWidth: 1),
                                  elevation: 1,
                                  child: Image.asset(
                                    "assets/icons/png/india.png",
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
            ),
          ),
        ),
      ),
    );
  }
}

