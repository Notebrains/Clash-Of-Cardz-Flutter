import 'package:clash_of_cardz_flutter/ui/styles/size_config.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/include_screens/player_info_back_btn.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/common_fun.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/include_screens/include_game_options.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/animated_text_kit/animated_text_kit.dart';

class GameOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFF364B5A),
        body: Stack(
          children: [

            PlayerInfoBackBtn(pageTitle: '',),

            Container(
              margin: EdgeInsets.only(top:  SizeConfig.widthMultiplier * 10),
              alignment: Alignment.center,
              child: Shimmer.fromColors(
                baseColor: Colors.blue[100].withOpacity(0.1),
                highlightColor: Colors.white.withOpacity(0.13),
                child: Text(
                  'CLASH OF CARDZ',
                  style: TextStyle( fontSize: SizeConfig.widthMultiplier * 14, fontFamily: 'Rapier', fontWeight: FontWeight.normal),
                ),
              ),
            ),


            IncludeGameOption(),

            /*Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 16, 16),
                  child: Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: FloatingActionButton(
                      mini: true,
                      tooltip: 'Back to previous screen',
                      backgroundColor: Colors.blueGrey,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        onTapAudio('button');
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),*/
          ],
        ),
      ),
    );
  }
}
