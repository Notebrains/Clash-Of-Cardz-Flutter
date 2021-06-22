import 'package:clash_of_cardz_flutter/helper/constantvalues/constants.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/common_fun.dart';
import 'package:clash_of_cardz_flutter/helper/shared_preference_data.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/avatar_glow.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:shape_of_view/shape_of_view.dart';

class PlayerInfoBackBtn extends StatefulWidget{
  @override
  _PlayerInfoBackBtnState createState() => _PlayerInfoBackBtnState();
}

class _PlayerInfoBackBtnState extends State<PlayerInfoBackBtn> {
  String playerName = '';
  String playerImage = '';
  String playerPoints = '';

  @override
  void initState() {
    super.initState();

    SharedPreferenceHelper().getUserSavedData().then((sharedPrefUserProfileModel) {
      playerName = sharedPrefUserProfileModel.fullName ?? '';
      playerImage = sharedPrefUserProfileModel.photo ?? Constants.imgUrlNotFoundYellowAvatar;
      playerPoints = sharedPrefUserProfileModel.points ?? '';

      setState(() {

      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Color(0xFF2C3E4B),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  onTapAudio('button');
                  Navigator.pop(context);
                },
              ),
              SlideInDown(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.cyanAccent[100],
                    highlightColor: Colors.lightBlueAccent,
                    child: Text(playerName.isNotEmpty? playerName.toUpperCase(): 'CLASH OF CARDZ',
                        style: TextStyle(fontSize: 21, fontFamily: 'montserrat', fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SlideInRight(
            child: Row(
              children: [
                HeartBeat(
                  child: Image.asset(
                    'assets/icons/png/coins.png',
                    height: 40,
                    width: 40,
                  ),
                  preferences: AnimationPreferences(duration: const Duration(milliseconds: 2000), autoPlay: AnimationPlayStates.Loop),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5.0, 8.0, 12.0, 8.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.cyanAccent,
                    highlightColor: Colors.lightBlueAccent,
                    child: Text(playerPoints.isNotEmpty? playerPoints: '0',
                        style:
                        TextStyle(fontSize: 20, fontFamily: 'montserrat', fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                  child: AvatarGlow(
                    child: ShapeOfView(
                      height: 33,
                      width: 33,
                      shape: CircleShape(borderColor: Colors.lightBlueAccent, borderWidth: 1),
                      elevation: 8,
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/icons/png/circle-avator-default-img.png',
                        image: playerImage,
                        fit: BoxFit.cover,
                      ),
                    ),

                    endRadius: 40,
                    glowColor: Colors.cyan,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}