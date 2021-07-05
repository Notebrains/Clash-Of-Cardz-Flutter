import 'package:clash_of_cardz_flutter/ui/widgets/libraries/f_dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';

class TxtInsideDottedLine extends StatelessWidget {
  final String text;
  final double width;
  final double height;

  const TxtInsideDottedLine({
    Key key,
    @required this.text,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FDottedLine(
        color: Colors.white,
        strokeWidth: 2.0,
        dottedLength: 8.0,
        space: 3.0,
        corner: FDottedLineCorner.all(6.0),

        /// add widget
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          child: HeartBeat(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w200,
                color: Colors.white,
                fontSize: 13,
              ),
            ),
            preferences: AnimationPreferences(duration: const Duration(milliseconds: 2500), autoPlay: AnimationPlayStates.Loop),
          ),
        ),
      ),
    );
  }
}