import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clash_of_cardz_flutter/bloc/api_bloc.dart';
import 'package:clash_of_cardz_flutter/model/responses/cms_res_model.dart';

import 'frosted_glass.dart';

class CarouselAutoSlider extends StatefulWidget {
  final String xApiKey;
  const CarouselAutoSlider({Key key, this.xApiKey}) : super(key: key);

  @override
  CarouselAutoSliderState createState() => CarouselAutoSliderState();
}

class CarouselAutoSliderState extends State<CarouselAutoSlider> {
  CarouselSlider carouselSlider;
  List imgList = [
    'assets/images/img_card_demo.png',
    'assets/images/img_card_demo.png',
    'assets/images/img_card_demo.png',
    'assets/images/img_card_demo.png',
    'assets/images/img_card_demo.png',
    'assets/images/img_card_demo.png',
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
        height: 300.0,
        aspectRatio: 16/9,
        viewportFraction: 0.8,
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
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                image: new DecorationImage(
                  image: AssetImage(imgUrl),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(4, 4),
                    blurRadius: 3,
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}