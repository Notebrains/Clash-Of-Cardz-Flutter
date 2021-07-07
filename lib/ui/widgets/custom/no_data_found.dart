import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoDataFound extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset('assets/images/bg_img13.png', fit:  BoxFit.cover,),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Lottie.asset('assets/animations/lottiefiles/no-data-found-sad-face.json'),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Text("No data found".toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blueGrey, fontSize: 26, fontFamily: 'montserrat', fontWeight: FontWeight.bold),),
        ),

      ],
    );
  }

}