import 'package:flutter/material.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:trump_card_game/model/responses/profile_res_model.dart';
import 'package:trump_card_game/ui/widgets/custom/frosted_glass.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_profile.dart';

class Profile extends StatelessWidget {
  // This widget is the root of your application.

  Profile({this.xApiKey, this.memberId});
  final String xApiKey;
  final String memberId;

  @override
  Widget build(BuildContext context) {
    apiBloc.fetchProfileRes(xApiKey, memberId);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/bg_img4.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: StreamBuilder(
            stream: apiBloc.profileRes,
            builder: (context, AsyncSnapshot<ProfileResModel> snapshot) {
              if (snapshot.hasData && snapshot.data.response.length>0) {
                return IncludeProfile(snapshot.data, xApiKey, memberId);
              }  else if (!snapshot.hasData) {
                return frostedGlassWithProgressBarWidget(context);
              } else return Center(
                child: Text("No Data Found",
                    style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 30)
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
