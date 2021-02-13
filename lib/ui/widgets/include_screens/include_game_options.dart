import 'package:flutter/material.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trump_card_game/helper/shared_preference_data.dart';
import 'package:trump_card_game/model/responses/game_option_res_model.dart';
import 'package:trump_card_game/ui/screens/autoplay.dart';
import 'package:trump_card_game/ui/screens/game_option_2.dart';
import 'package:trump_card_game/ui/screens/game_option_3.dart';
import 'package:trump_card_game/ui/widgets/custom/frosted_glass.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:trump_card_game/ui/widgets/libraries/shimmer.dart';

class IncludeGameOption extends StatefulWidget {
  @override
  _IncludeGameOptionState createState() => _IncludeGameOptionState();
}

class _IncludeGameOptionState extends State<IncludeGameOption> {
  var isSecondListVisible = false;
  var isThirdListVisible = false;
  List<Category_details> subcategory = [];
  List<Sub1category_details> subcategoryDetails = [];
  String categoryName = '';


  void _includeGameOptState() {
    setState(() {
      buildSecondList(subcategory);
    });
  }

  @override
  Widget build(BuildContext context) {
    SharedPreferenceHelper().getUserApiKey().then((xApiKey) => apiBloc.fetchGameOptionRes(xApiKey));

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: StreamBuilder(
            stream: apiBloc.gameCatRes,
            builder: (context, AsyncSnapshot<GameOptionResModel> snapshot) {
              if (snapshot.hasData) {
                return _buildFirstList(snapshot.data);
              } else if (!snapshot.hasData) {
                return frostedGlassWithProgressBarWidget(context);
              } else return Center(
                child: Text("No Data Found",
                    style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 30)
                ),
              );
            },
          ),
        ),

        Container(
          height: subcategory.length* 80.0,
          width: 1.5,
          color: Colors.indigo,
          margin: const EdgeInsets.only(left: 16, top: 20.0, bottom: 0.0),
        ),

        Expanded(
          flex: 3,
          child: buildSecondList(subcategory),
        ),
      ],
    );
  }

  Widget _buildFirstList(GameOptionResModel data) {
    //final List<String> listData1 = <String>['Sports', 'Superheroes', 'Cartoons', 'Cars', 'Technology'];
    return ListView.builder(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: EdgeInsets.fromLTRB(5.0, 12.0, 16.0, 5.0),
      itemCount: data.response.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(36)),
          ),
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: SlideInRight(
            child: GestureDetector(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Pulse(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.grey[350],
                          width: 5,
                        ),

                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Color(0x60000000),
                            blurRadius: 12.0,
                            offset: Offset(0.0, 12.0),
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                      ),
                      child: CircleAvatar(
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/icons/png/img_sports.png',
                          image: data.response[index].categoryIcon??'',
                        ),
                      ),
                    ),
                    preferences: AnimationPreferences(
                        duration: const Duration(milliseconds: 1500),
                        autoPlay: AnimationPlayStates.Loop),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 0, 2),
                    child: Shimmer.fromColors(
                      baseColor: Colors.black54,
                      highlightColor: Colors.orangeAccent,
                      child: Text(
                        data.response[index].categoryName,
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'neuropol_x_rg',
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              onTap: () {
                //print('Clicked on first screen');
                subcategoryDetails.clear();
                categoryName = data.response[index].categoryName;
                buildSecondList(data.response[index].categoryDetails);
                //print('subcategory.length----' + data.response[index].subcategory.length.toString());
                _includeGameOptState();


              },
            ),
            preferences: AnimationPreferences(
                duration: const Duration(milliseconds: 1000),
                autoPlay: AnimationPlayStates.Forward),
          ),
        );
      },
    );
  }

  Widget buildSecondList(List<Category_details> subcategoryList) {
    //final List<String> listData1 = <String>['Cricket', 'Football', 'Tennis', 'Basketball', 'Racing'];
    subcategory = List.from(subcategoryList);

    if (subcategory.length > 0) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.fromLTRB(5.0, 33.0, 16.0, 5.0),
        itemCount: subcategory.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return LightSpeedIn(
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(36)),
                ),
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.grey[350],
                          width: 5,
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Color(0x60000000),
                            blurRadius: 12.0,
                            offset: Offset(0.0, 12.0),
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                      ),
                      child: CircleAvatar(
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/icons/png/img_sports.png',
                          image: subcategory[index].sub1categoryIcon??'',
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 0, 2),
                      child: Shimmer.fromColors(
                        baseColor: Colors.black54,
                        highlightColor: Colors.orangeAccent,
                        child: Text(
                          subcategory[index].sub1categoryName,
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'neuropol_x_rg',
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameOptionTwo(gameCat1: categoryName, gameCat2: subcategory[index].sub1categoryName),
                    // Pass the arguments as part of the RouteSettings. The
                    // DetailScreen reads the arguments from these settings.
                    settings: RouteSettings(arguments: subcategory[index].sub1categoryDetails,),
                  ),
                );
              },
            ),
            preferences: AnimationPreferences(
                duration: const Duration(milliseconds: 500),
                autoPlay: AnimationPlayStates.Forward),
          );
        },
      );
    } else {
      return SizedBox();
    }
  }

}
