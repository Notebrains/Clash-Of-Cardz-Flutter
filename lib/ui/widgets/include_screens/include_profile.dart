import 'package:clash_of_cardz_flutter/ui/widgets/libraries/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:clash_of_cardz_flutter/helper/constantvalues/constants.dart';
import 'package:clash_of_cardz_flutter/model/responses/profile_res_model.dart';
import 'package:clash_of_cardz_flutter/ui/screens/old_screen/statistics.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/views/view_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animator/flutter_animator.dart';

class IncludeProfile extends StatelessWidget {
  ProfileResModel data;
  String xApiKey;
  String memberId;

  IncludeProfile(ProfileResModel data, String xApiKey, String memberId) {
    this.data = data;
    this.xApiKey = xApiKey;
    this.memberId = memberId;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: SlideInLeft(
              child: Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlueAccent),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color(0xFF2A4A66),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Shimmer.fromColors(
                        baseColor: Colors.lightBlueAccent,
                        highlightColor: Colors.white,
                        child: Text(
                          'EXPERIENCE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'montserrat',
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      ),
                    ),

                    Container(
                      width: 70,
                      height: 70,
                      margin: EdgeInsets.only(top: 12, bottom: 12),
                      decoration: Views.boxDecorationWidgetForPngImage(data.response[0].image, 4.0, Colors.lightBlueAccent, 5.0, 5.0, 3.0),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/icons/png/NoImageFound.png',
                        image: data.response[0].image ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        data.response[0].fullname ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14.0,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[100]),
                      ),
                    ),

                    Text(
                      'Id: ${data.response[0].memberid}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12.0,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'montserrat',
                          fontWeight: FontWeight.normal,
                          color: Colors.blue[100]),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        "Playing since\n ${data.response[0].joinedOn}",
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 12.0, fontStyle: FontStyle.normal, fontFamily: 'montserrat', color: Colors.blue[100]),
                      ),
                    ),

                    /*Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        "20y, Female, Kol-IND",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal, fontFamily: 'montserrat', color: Colors.black),
                      ),
                    ),*/

                    //Statistics button
                    InkWell(
                      child: Container(
                        width: 170,
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(6),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                          color: Colors.blue[100],
                          width: 1,
                        ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text('View Statistics',
                            style: TextStyle(fontSize: 14, color: Colors.blue[100], fontWeight: FontWeight.normal),),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => Statistics(
                              xApiKey: xApiKey,
                              memberId: memberId,
                            ),
                          ),
                        );
                      },
                    ),

                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/svg/back_black.svg',
                        color: Colors.blue[200],
                        width: 25,
                        height: 25,
                      ),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop(context);
                      },
                    )
                  ],
                ),
              ),
              preferences: AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
            ),
          ),
          Expanded(
            flex: 1,
            child: SlideInRight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                iconSize: 55,
                                icon: SvgPicture.asset('assets/icons/svg/podium.svg'),
                                onPressed: () {},
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  data.response[0].rank.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: 'montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.lightBlue),
                                ),
                              ),
                              Text(
                                "RANK",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightBlueAccent),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              padding: EdgeInsets.only(left: 16),
                              iconSize: 75,
                              icon: Image.asset('assets/icons/png/coins.png'),
                              onPressed: () {},
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                data.response[0].points ?? '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightBlue),
                              ),
                            ),
                            Text(
                              "POINTS",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlueAccent),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 50,
                              icon: SvgPicture.asset('assets/icons/svg/victory.svg'),
                              onPressed: () {},
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                data.response[0].matchPlayed ?? '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightBlue),
                              ),
                            ),
                            Text(
                              "MATCH",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlueAccent),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 50,
                              icon: SvgPicture.asset('assets/icons/svg/won.svg'),
                              onPressed: () {},
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(45, 0, 45, 0),
                              child: Text(
                                data.response[0].win ?? '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightBlue),
                              ),
                            ),
                            Text(
                              "WON",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlueAccent),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 50,
                              icon: SvgPicture.asset('assets/icons/svg/lost.svg'),
                              onPressed: () {},
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                data.response[0].loss ?? '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightBlue),
                              ),
                            ),
                            Text(
                              "LOSE",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlueAccent),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              preferences: AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
            ),
          ),
        ],
      ),
    );
  }
}
