import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselAutoSlider extends StatefulWidget {
  CarouselAutoSlider() : super();

  final String title = "Carousel Demo";

  @override
  CarouselAutoSliderState createState() => CarouselAutoSliderState();
}

class CarouselAutoSliderState extends State<CarouselAutoSlider> {
  CarouselSlider carouselSlider;
  int _current = 0;
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
      height: 300.0,
      initialPage: 0,
      enlargeCenterPage: true,
      autoPlay: true,
      reverse: false,
      enableInfiniteScroll: true,
      autoPlayInterval: Duration(seconds: 4),
      autoPlayAnimationDuration: Duration(milliseconds: 4000),
      pauseAutoPlayOnTouch: Duration(seconds: 10),
      scrollDirection: Axis.horizontal,
      onPageChanged: (index) {
        setState(() {
          _current = index;
        });
      },
      items: imgList.map((imgUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                image: new DecorationImage(
                  image: new AssetImage(imgUrl),
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