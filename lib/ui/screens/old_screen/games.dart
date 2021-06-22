import 'package:clash_of_cardz_flutter/ui/widgets/custom/no_data_found.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/player_info_back_btn.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:clash_of_cardz_flutter/bloc/api_bloc.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/base_application_fun.dart';
import 'package:clash_of_cardz_flutter/model/responses/cms_res_model.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/card_shape_background.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/frosted_glass.dart';
import 'package:flutter_animator/flutter_animator.dart';

class Games extends StatelessWidget {
  final String xApiKey;
  final String memberId;

  Games({this.xApiKey, this.memberId});


  @override
  Widget build(BuildContext context) {
    setScreenOrientationToLandscape();
    apiBloc.fetchCmsRes(xApiKey, 'games');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF364B5A),
      body: StreamBuilder(
        stream: apiBloc.cmsResModel,
        builder: (context, AsyncSnapshot<CmsResModel> snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PlayerInfoBackBtn(),

                buildUI(context, snapshot.data.response),
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

  Widget buildUI(BuildContext context, Response response) {
    return Container(
      color: Color(0xFF314453),
      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
      height: MediaQuery.of(context).size.height - 70,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: response.cmsMeta.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.fromLTRB(15, 16, 5, 24),
              //width: MediaQuery.of(context).size.width * 0.3,
              child: ClipPath(
                clipper: CharacterCardBackgroundClipper(),
                child: Container(
                  height: 280,
                  width: 190,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.orange.shade400, Colors.deepOrange],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RotateInDownLeft(
                        child: Pulse(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 28),
                            child: Image.network(response.cmsMeta[index].image, width: 210),
                          ),
                          preferences: AnimationPreferences(duration: const Duration(milliseconds: 2000), autoPlay: AnimationPlayStates.Loop),
                        ),
                      ),

                      Shimmer.fromColors(
                        baseColor: Colors.white70,
                        highlightColor: Colors.deepOrange,
                        child: Text(response.cmsMeta[index].title.toUpperCase() ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, fontFamily: 'montserrat', color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
