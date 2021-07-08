import 'package:clash_of_cardz_flutter/ui/widgets/custom/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:clash_of_cardz_flutter/bloc/api_bloc.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/base_application_fun.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/common_fun.dart';
import 'package:clash_of_cardz_flutter/model/responses/cms_res_model.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/card_shape_background.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/loading_sports_frosted_glass.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/colorize.dart';

class Cards extends StatelessWidget {
  Cards({this.xApiKey, this.memberId});
  final String xApiKey;
  final String memberId;

  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    setScreenOrientationToLandscape();
    apiBloc.fetchCmsRes(xApiKey, 'games');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
        stream: apiBloc.cmsResModel,
        builder: (context, AsyncSnapshot<CmsResModel> snapshot) {
          if (snapshot.hasData) {
            return Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: AssetImage("assets/images/bg_img13.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: buildUI(snapshot.data.response),
            );
          } else if (!snapshot.hasData) {
            return frostedGlassWithProgressBarWidget(context);
          } else return NoDataFound();
        },
      ),
    );
  }

  Widget buildUI(Response response) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: Row(
              children: [
                FloatingActionButton(
                  tooltip: 'Back to previous screen',
                  backgroundColor: Colors.amber[900],
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    onTapAudio('button');
                    Navigator.pop(context);
                  },
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 4.0),
                  child: ColorizeAnimatedTextKit(
                    onTap: () {
                      //print("Tap Event");
                    },

                    text: ["GAMES"],
                    textStyle: TextStyle(
                        fontSize: 35.0,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Rapier'
                    ),
                    colors: [
                      Colors.grey[700],
                      Colors.amber[900],
                      Colors.grey[700],
                    ],
                    textAlign: TextAlign.center,
                    alignment: AlignmentDirectional.center,
                    // or Alignment.topLeft
                    isRepeatingAnimation: true,
                    repeatForever: true,
                    speed: Duration(milliseconds: 1000),
                  ),
                ),
              ],
            ),
          ),
        ),

        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 50.0,
            vertical: 24.0,
          ),
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: response.cmsMeta.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(15, 5, 5, 16),
                  //width: MediaQuery.of(context).size.width * 0.3,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ClipPath(
                          clipper: CharacterCardBackgroundClipper(),
                          child: Container(
                            height: 280,
                            width: 220,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.orange.shade400, Colors.deepOrange],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment(50, -0.9),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            //response.cmsMeta[index].
                            //child: Lottie.asset('assets/animations/lottiefiles/confused_robot-bot-3d.json', width: 250, height: 290),
                            child: Image.network(response.cmsMeta[index].image, width: 250, height: 290),
                          )
                      ),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            margin: EdgeInsets.only(bottom: 20, left: 20),
                            child: ColorizeAnimatedTextKit(
                              onTap: () {
                                //print("Tap Event");
                              },
                              text: [response.cmsMeta[index].title],
                              textStyle: TextStyle(
                                letterSpacing: 1,
                                  fontSize: 30.0,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Rapier'
                              ),
                              colors: [
                                Colors.black54,
                                Colors.white60,
                                Colors.black54,
                              ],
                              textAlign: TextAlign.center,
                              alignment: AlignmentDirectional.center,
                              // or Alignment.topLeft
                              isRepeatingAnimation: true,
                              repeatForever: true,
                              speed: Duration(milliseconds: 200),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
