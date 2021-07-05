import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';

class BtnLeftBorderSq extends StatelessWidget {
  const BtnLeftBorderSq({
    Key key,
    this.text,
    this.onClick,
  }) : super(key: key);

  final String text;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return SlideInRight(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF364B5A),
          border: Border(
            left: BorderSide(
              color: Colors.lightBlue,
              width: 3,
            ),
          ),
          //gradient: LinearGradient(colors: [Colors.blueAccent, Colors.lightBlue]),
        ),
        //padding: const EdgeInsets.all(6.0),
        margin: const EdgeInsets.only(left: 16, right: 16, top: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            onPrimary: Color(0xFF324653),
            primary: Color(0xFF314452),
            shadowColor: Colors.blueAccent,
            //minimumSize: Size(88, 36),
            //textStyle: TextStyle(color: Colors.white),
            padding: EdgeInsets.symmetric(horizontal: 18),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0),),
            ),
          ),
          onPressed: onClick,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              style: TextStyle(color: Colors.white.withOpacity(0.8), fontFamily: 'montserrat', fontWeight: FontWeight.w700,
                  fontSize: 16),
            ),
          ),
        ),
      ),
      preferences:
      AnimationPreferences(duration: const Duration(milliseconds: 1200), autoPlay: AnimationPlayStates.Forward),
    );
  }
}