import 'package:flutter/material.dart';
import 'package:trump_card_game/helper/constantvalues/constants.dart';
import 'package:trump_card_game/model/responses/profile_res_model.dart';
import 'package:trump_card_game/ui/screens/statistics.dart';
import 'package:trump_card_game/ui/widgets/views/view_widgets.dart';
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
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey[300],
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'PROFILE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 35.0,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'montserrat',
                          color: Colors.grey[800],
                        ),
                      ),
                    ),

                    Container(
                      width: 70,
                      height: 70,
                      margin: EdgeInsets.all(5),
                      decoration: Views.boxDecorationWidgetForPngImage(data.response[0].photo??'', 4.0, Colors.grey, 5.0, 5.0, 3.0),
                      child: FadeInImage.assetNetwork(
                          placeholder: 'assets/icons/png/NoImageFound.png',
                          image: data.response[0].photo??'',
                          fit: BoxFit.cover,
                        ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        data.response[0].fullname??'',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal, fontFamily: 'montserrat', fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),

                    Text(
                      data.response[0].memberid,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal, fontFamily: 'montserrat', fontWeight: FontWeight.bold, color: Colors.black),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        "Since: 1st Jan, 2002",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal, fontFamily: 'montserrat', color: Colors.black),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        "20y, Female, Kol-IND",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal, fontFamily: 'montserrat', color: Colors.black),
                      ),
                    ),

                    //Statistics button
                    Container(
                      width: 170,
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      child: RaisedButton(
                        elevation: 5,
                        child: const Text('View Statistics', style: TextStyle(fontSize: 16)),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Statistics(xApiKey, memberId)));
                        },
                      ),
                    ),

                    IconButton(
                      iconSize: 35,
                      icon: SvgPicture.asset('assets/icons/svg/back_black.svg'),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop(context);
                      },
                    )
                  ],
                ),
              ),
              preferences:
              AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
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
                                  style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal, fontFamily: 'montserrat', fontWeight: FontWeight.bold, color: Colors.black54),
                                ),
                              ),
                              Text(
                                "RANK",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal, fontFamily: 'montserrat', fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                padding: EdgeInsets.all(12),
                                iconSize: 40,
                                icon: SvgPicture.asset('assets/icons/svg/coin.svg'),
                                onPressed: () {},
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  data.response[0].points??'',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal, fontFamily: 'montserrat', fontWeight: FontWeight.bold, color: Colors.black54),
                                ),
                              ),
                              Text(
                                "POINTS",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal, fontFamily: 'montserrat', fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                            ],
                          ),
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
                                data.response[0].matchPlayed??'',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal, fontFamily: 'montserrat', fontWeight: FontWeight.bold, color: Colors.black54),
                              ),
                            ),
                            Text(
                              "MATCH",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal, fontFamily: 'montserrat', fontWeight: FontWeight.bold, color: Colors.black),
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
                                data.response[0].win??'',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal, fontFamily: 'montserrat', fontWeight: FontWeight.bold, color: Colors.black54),
                              ),
                            ),
                            Text(
                              "WON",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal, fontFamily: 'montserrat', fontWeight: FontWeight.bold, color: Colors.black),
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
                                data.response[0].loss??'',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal, fontFamily: 'montserrat', fontWeight: FontWeight.bold, color: Colors.black54),
                              ),
                            ),
                            Text(
                              "LOSE",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal, fontFamily: 'montserrat', fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              preferences:
              AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
            ),
          ),
        ],
      ),
    );
  }
}
