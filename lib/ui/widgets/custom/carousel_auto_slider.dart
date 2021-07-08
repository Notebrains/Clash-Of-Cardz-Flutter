import 'package:clash_of_cardz_flutter/helper/exten_fun/base_application_fun.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clash_of_cardz_flutter/bloc/api_bloc.dart';
import 'package:clash_of_cardz_flutter/model/responses/cms_res_model.dart';

import 'loading_sports_frosted_glass.dart';

class CarouselAutoSlider extends StatefulWidget {
  final String xApiKey;
  const CarouselAutoSlider({Key key, this.xApiKey}) : super(key: key);

  @override
  CarouselAutoSliderState createState() => CarouselAutoSliderState();
}

class CarouselAutoSliderState extends State<CarouselAutoSlider> {
  CarouselSlider carouselSlider;
  List imgList = [
    'assets/images/cricket_card.png',
    'assets/images/cricket_Bowller_card.png',
    'assets/images/soccer_card.png',
    'assets/images/formula_one.png',
    'assets/images/golf.png',
    'assets/images/moto_gp_card.png',
    'assets/images/tennis_card.png',
    'assets/images/wwe_card.png',
    'assets/images/badminton.png',
    'assets/images/nascar_card.png',
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: getScreenHeight(context)/1.35,
        aspectRatio: 4/3,
        viewportFraction: 0.6,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 4),
        autoPlayAnimationDuration: Duration(milliseconds: 4000),
        pauseAutoPlayOnTouch: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {

        },
        scrollDirection: Axis.horizontal,
      ),

      items: imgList.map((imgUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                gradient: LinearGradient(
                  colors: [ Colors.cyan,Colors.lightBlue],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                image: new DecorationImage(image: AssetImage(imgUrl), fit: BoxFit.fill,),
                borderRadius: BorderRadius.all(Radius.circular(3.0)),

              ),
            );
          },
        );
      }).toList(),
    );
  }
}