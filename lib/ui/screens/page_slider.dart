import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselDemo extends StatefulWidget {
  CarouselDemo() : super();

  final String title = "Carousel Demo";

  @override
  CarouselDemoState createState() => CarouselDemoState();
}

class CarouselDemoState extends State<CarouselDemo> {
  //
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: 400,
        child: CarouselSlider(
          height: 200.0,
          initialPage: 0,
          enlargeCenterPage: true,
          autoPlay: true,
          reverse: false,
          enableInfiniteScroll: true,
          autoPlayInterval: Duration(seconds: 4),
          autoPlayAnimationDuration: Duration(milliseconds: 2000),
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
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage(imgUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey[700],
                        offset: Offset(5, 5),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
