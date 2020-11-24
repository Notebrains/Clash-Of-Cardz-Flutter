import 'package:flutter/material.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:trump_card_game/model/responses/profile_res_model.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_profile.dart';

class Profile extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    apiBloc.fetchProfileRes('ZGHrDz4prqsu4BcApPaQYaGgq', "MEM000001");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                return buildProfileScreen(snapshot.data);
              } else if (snapshot.hasError) {
                return Text(snapshot.data.message);
              }
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
