import 'package:clash_of_cardz_flutter/ui/styles/size_config.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/no_data_found.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/outlined_btn_gradient_border.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/include_screens/player_info_back_btn.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:clash_of_cardz_flutter/bloc/api_bloc.dart';
import 'package:clash_of_cardz_flutter/helper/constantvalues/constants.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/base_application_fun.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/common_fun.dart';
import 'package:clash_of_cardz_flutter/model/responses/leaderboard_res_model.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/loading_sports_frosted_glass.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/animated_text_kit/animated_text_kit.dart';
import 'package:shape_of_view/shape_of_view.dart';

class Leaderboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setScreenOrientationToLandscape();
    apiBloc.fetchLeaderboardRes("ZGHrDz4prqsu4BcApPaQYaGgq");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF364B5A),
      body: StreamBuilder(
        stream: apiBloc.leaderboardRes,
        builder: (context, AsyncSnapshot<LeaderboardResModel> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                PlayerInfoBackBtn(
                  pageTitle: 'LEADERBOARD',
                ),

              _buildUi(snapshot.data),
              ],
            );
          } else if (!snapshot.hasData) {
            return frostedGlassWithProgressBarWidget(context);
          } else
            return NoDataFound();
        },
      ),
    );
  }

  Widget _buildUi(LeaderboardResModel model) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(6),
        itemCount: model.response.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(5),
            child: OutlinedBtnGradientBorder(
              height: SizeConfig.heightMultiplier * 5.9,
              width: null,
              thickness: 1.5,
              gradColor1: Colors.lightBlueAccent.withOpacity(0.4),
              gradColor2: Colors.cyanAccent.withOpacity(0.6),
              onPressed: () {
                onTapAudio('button');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        Text(
                          '   ${model.response[index].rank}.   ',
                          style: TextStyle(color: Colors.blue.shade50, fontSize: 16, fontWeight: FontWeight.bold),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(right: 26, left: 24),
                          child: ShapeOfView(
                            height: 32,
                            width: 32,
                            shape: CircleShape(borderColor: Colors.lightBlueAccent, borderWidth: 1),
                            elevation: 8,
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/icons/png/circle-avator-default-img.png',
                              image: model.response[index].photo,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Shimmer.fromColors(
                          baseColor: Colors.blue.shade50,
                          highlightColor: Colors.cyanAccent,
                          child: Text(
                            model.response[index].fullname.toUpperCase(),
                            style: TextStyle( fontSize: 14, fontWeight: FontWeight.normal),
                          ),
                        ),

                      ],
                    ),
                  ),

                  Expanded(
                    flex: 4,
                    child: SvgPicture.asset(getImg(model.response[index].rank),
                    height: 25,
                    width: 25,
                  ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/png/coins.png',
                          height: 35,
                          width: 35,
                        ),


                        Shimmer.fromColors(
                          baseColor: Colors.orange.shade100,
                          highlightColor: Colors.white,
                          child: Text(
                            model.response[index].points,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String getImg(int rank) {
    String imgAsset = '';
    switch(rank){
      case 1:
        imgAsset = 'assets/icons/svg/first.svg';
        break;

        case 2:
          imgAsset = 'assets/icons/svg/leaf_second.svg';
        break;

        case 3:
          imgAsset = 'assets/icons/svg/leaf_third.svg';
        break;

      default:
        imgAsset = '';
        break;
    }
    return imgAsset;
  }
}
