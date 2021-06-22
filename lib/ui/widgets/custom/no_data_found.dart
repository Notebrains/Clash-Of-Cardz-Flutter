import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoDataFound extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset('assets/images/bg_img13.png', fit:  BoxFit.cover,),

        Lottie.asset('assets/animations/lottiefiles/no-data-found-sad-face.json'),

        Center(
          child: Text("No data found :( \nPlease try again.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 26, fontFamily: 'neuropol_x_rg', fontWeight: FontWeight.bold)),
        ),

      ],
    );
  }

}