import 'package:clash_of_cardz_flutter/helper/exten_fun/common_fun.dart';
import 'package:clash_of_cardz_flutter/ui/styles/size_config.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/outlined_btn_gradient_border.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/player_info_back_btn.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:clash_of_cardz_flutter/model/responses/statistics_res_model.dart';
import 'package:shape_of_view/shape_of_view.dart';

Widget buildStatisticsScreen(StatisticsResModel model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      PlayerInfoBackBtn(),
      Expanded(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(6),
          itemCount: model.response.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(4),
              child: OutlinedBtnGradientBorder(
                height: SizeConfig.heightMultiplier * 12,
                width: 200,
                onPressed: () {
                  onTapAudio('button');
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12.0, 10, 12, 8),
                              child: SvgPicture.asset('assets/icons/svg/victory.svg', width: 18, height: 18),
                            ),

                            Shimmer.fromColors(
                              baseColor: isMatchWon(model.response[index].matchData[0].win) ? Colors.greenAccent : Colors.orangeAccent,
                              highlightColor: Colors.lightBlueAccent,
                              child: Text(
                                isMatchWon(model.response[index].matchData[0].win) ? 'VICTORY' : 'LOST',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'montserrat',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),


                        Shimmer.fromColors(
                          baseColor: Colors.cyanAccent,
                          highlightColor: Colors.lightBlueAccent,
                          child: Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Text(
                              '${model.response[index].gameCat.toUpperCase()} - ${model.response[index].noCard.toUpperCase()} CARDS',
                              style: TextStyle(
                                color: Colors.blue[100],
                                fontSize: 13,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'montserrat',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),


                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Divider(
                        color: Colors.lightBlueAccent,
                        height: 1,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ShapeOfView(
                                height: 36,
                                width: 36,
                                shape: CircleShape(borderColor: Colors.lightBlueAccent, borderWidth: 1),
                                elevation: 8,
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/icons/png/circle-avator-default-img.png',
                                  image: model.response[index].matchData[0].photo,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 1, 3, 1),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(model.response[index].matchData[0].fullname,
                                        style: TextStyle(color: Colors.blue.shade200, fontSize: 14, fontWeight: FontWeight.normal)),

                                    Text(
                                      'Earned ${model.response[index].matchData[0].points} coins',
                                      style: TextStyle(color: Colors.blue.shade50, fontWeight: FontWeight.normal, fontSize: 11,),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/icons/png/img_vs.png',
                          width: 35,
                          height: 35,
                          color: Colors.orangeAccent,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 8, 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(model.response[index].matchData[1].fullname,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(color: Colors.blue.shade200, fontSize: 14, fontWeight: FontWeight.normal),
                                  ),
                                  Text('Earned ${model.response[index].matchData[1].points} point',
                                      style: TextStyle(color: Colors.blue.shade50, fontWeight: FontWeight.normal, fontSize: 11),
                                  ),
                                ],
                              ),
                            ),
                            ShapeOfView(
                              height: 36,
                              width: 36,
                              shape: CircleShape(borderColor: Colors.orangeAccent, borderWidth: 1),
                              elevation: 8,
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/icons/png/circle-avator-default-img.png',
                                image: model.response[index].matchData[1].photo,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}

bool isMatchWon(String win) {
  if (win == '1') {
    return true;
  } else {
    return false;
  }
}
