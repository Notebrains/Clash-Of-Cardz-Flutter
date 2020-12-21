import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:trump_card_game/model/responses/cards_res_model.dart';
import 'package:trump_card_game/ui/screens/autoplay.dart';
import 'package:trump_card_game/ui/screens/gameplay.dart';
import 'package:trump_card_game/ui/widgets/custom/frosted_glass.dart';

class IncludeSearchingForPlayer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IncludeSearchingForPlayerState();
}

class IncludeSearchingForPlayerState extends State<IncludeSearchingForPlayer> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    apiBloc.fetchCardsRes('ZGHrDz4prqsu4BcApPaQYaGgq', 'cricket', 'sports', '2', '14');
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Stack(
            children: <Widget>[
              new ConstrainedBox(
                constraints: const BoxConstraints.expand(),
              ),
              new Center(
                child: new ClipRect(
                  child: new BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: new Container(
                      decoration: new BoxDecoration(color: Colors.grey.shade50.withOpacity(0.1)),
                      child: new Center(
                        child: Container(
                          margin: EdgeInsets.all(5.0),
                          padding: EdgeInsets.all(5.0),
                          height: MediaQuery.of(context).size.height,
                          decoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))),
                          child: Column(
                            children: <Widget>[
                              Lottie.asset(
                                'assets/animations/lottiefiles/page-searching.json',
                                width: getScreenWidth(context),
                                height: getScreenHeight(context) * 0.8,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "Searching for player",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontFamily: 'neuropol_x_rg',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              StreamBuilder(
                                stream: apiBloc.cardsRes,
                                builder: (context, AsyncSnapshot<CardsResModel> snapshot) {
                                  if (snapshot.hasData) {
                                    try {
                                      Navigator.of(context).push(new PageRouteWithAnimation());
                                    } catch (e) {
                                      print(e);
                                    }
                                  } else if (!snapshot.hasData) {
                                    return Center(
                                      child: Container(
                                        //padding: const EdgeInsets.only(top: 12.0),
                                        child: Text(
                                          "No Player Found! Please Try Again.",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontFamily: 'neuropol_x_rg',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    );
                                  }
                                  return Container();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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

class PageRouteWithAnimation extends CupertinoPageRoute {
  PageRouteWithAnimation()
      : super(
            builder: (BuildContext context) => AutoPlay(
                  name: 'Jack Demon',
                  friendId: 'F006754',
                ));

  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return new ScaleTransition(
      scale: animation,
      child: new FadeTransition(
        opacity: animation,
        child: AutoPlay(
          name: 'Jack Demon',
          friendId: 'F006754',
        ),
      ),
    );
  }
}
