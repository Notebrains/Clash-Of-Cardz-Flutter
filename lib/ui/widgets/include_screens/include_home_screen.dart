import 'package:flutter/material.dart';
import 'package:trump_card_game/helper/shared_preference_data.dart';
import 'package:trump_card_game/model/responses/profile_res_model.dart';
import 'package:flutter_animator/flutter_animator.dart';

Widget buildHomeScreenPlayerInfo(ProfileResModel model){
  savePlayerInfoIntoPref(model);

  return SlideInDown(
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 50,
              alignment: AlignmentDirectional.topStart,
              margin: EdgeInsets.all(8.0),
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                    height: 55.0,
                    child: OverflowBox(
                      alignment: AlignmentDirectional.topStart,
                      maxWidth: 250.0,
                      maxHeight: 55.0,
                      child: Container(
                        padding: new EdgeInsets.fromLTRB(30.0, 8.0, 30.0, 8.0),
                        margin: EdgeInsets.fromLTRB(30.0, 8.0, 8.0, 8.0),
                        child: new Text(model.response[0].fullname,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900)),
                        decoration: new BoxDecoration(
                          borderRadius:
                          new BorderRadius.all(Radius.circular(30.0)),
                          color: Colors.grey[800],
                          border: Border.all(
                              color: Colors.orangeAccent, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage:
                    NetworkImage(model.response[0].photo),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              alignment: AlignmentDirectional.topEnd,
              margin: EdgeInsets.all(8.0),
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    width: 20.0,
                    height: 50.0,
                    child: OverflowBox(
                      alignment: AlignmentDirectional.topEnd,
                      maxWidth: 250.0,
                      maxHeight: 50,
                      child: Container(
                        padding:
                        new EdgeInsets.fromLTRB(30.0, 8.0, 30.0, 8.0),
                        margin: EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
                        child: Text(model.response[0].coins,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900)),
                        decoration: new BoxDecoration(
                          borderRadius:
                          new BorderRadius.all(Radius.circular(30.0)),
                          color: Colors.grey[800],
                          border: Border.all(
                              color: Colors.orangeAccent, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage:
                    AssetImage('assets/icons/png/ic_points.png'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      preferences:
      AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
  );
}

void savePlayerInfoIntoPref(ProfileResModel model) {
  SharedPreferenceHelper().getUserApiKey().then(
        (xApiKey) =>
            SharedPreferenceHelper().saveUserProfileData(
                xApiKey.toString(),
                model.response[0].memberid,
                model.response[0].fullname,
                model.response[0].photo,
                model.response[0].points,
                model.response[0].coins,
                model.response[0].win,
                model.response[0].loss,
                model.response[0].matchPlayed,
                model.response[0].redeem,
                model.response[0].rank.toString()
            ),
  );
}