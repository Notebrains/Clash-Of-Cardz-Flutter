import 'package:flutter/material.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trump_card_game/model/responses/game_option_res_model.dart';
import 'package:trump_card_game/ui/screens/autoplay.dart';
import 'package:trump_card_game/ui/screens/game_more_option.dart';
import 'package:trump_card_game/ui/widgets/custom/frosted_glass.dart';
import 'package:flutter_animator/flutter_animator.dart';

class IncludeGameOption extends StatefulWidget {
  @override
  _IncludeGameOptionState createState() => _IncludeGameOptionState();
}

class _IncludeGameOptionState extends State<IncludeGameOption> {
  var isSecondListVisible = false;
  var isThirdListVisible = false;
  List<Subcategory> subcategory = List<Subcategory>();
  List<Subcategory_details> subcategoryDetails = List<Subcategory_details>();

  void _includeGameOptState() {
    setState(() {
      buildSecondList(subcategory);
      buildThirdList(subcategoryDetails);
    });
  }

  @override
  Widget build(BuildContext context) {
    apiBloc.fetchGameOptionRes('ZGHrDz4prqsu4BcApPaQYaGgq');
    return Row(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: 1.5,
          color: Colors.indigo,
          margin: const EdgeInsets.only(left: 16, top: 50.0, bottom: 50.0),
        ),

        Expanded(
          flex: 3,
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
          flex: 4,
          child: buildSecondList(subcategory),
        ),

        Container(
          height: subcategoryDetails.length* 70.0,
          width: 1.5,
          color: Colors.indigo,
          margin: const EdgeInsets.only(left: 16, top: 64.0, bottom: 40.0),
        ),

        Expanded(
          flex: 6,
          child: buildThirdList(subcategoryDetails),
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.grey[350],
                      width: 5,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                  child: CircleAvatar(
                    child: SvgPicture.asset('assets/icons/svg/cricket.svg'),
                    //backgroundColor: Colors.black38,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 0, 2),
                  child: GestureDetector(
                    child: Text(
                      data.response[index].categoryName,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontFamily: 'neuropol_x_rg',
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onTap: () {
                      //print('Clicked on first screen');
                      subcategoryDetails.clear();
                      buildSecondList(data.response[index].subcategory);
                      //print('subcategory.length----' + data.response[index].subcategory.length.toString());
                      _includeGameOptState();
                    },
                  ),
                ),
              ],
            ),
            preferences: AnimationPreferences(
                duration: const Duration(milliseconds: 1000),
                autoPlay: AnimationPlayStates.Forward),
          ),
        );
      },
    );
  }

  Widget buildSecondList(List<Subcategory> subcategoryList) {
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
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(36)),
              ),
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.grey[350],
                        width: 5,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                    ),
                    child: CircleAvatar(
                      child: SvgPicture.asset('assets/icons/svg/cricket.svg'),
                      //backgroundColor: Colors.black38,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 16, 0, 2),
                    child: GestureDetector(
                      child: Text(
                        subcategory[index].subcategoryName,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontFamily: 'neuropol_x_rg',
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      onTap: () {
                        //print('Clicked on 2nd screen');
                        buildThirdList(subcategory[index].subcategoryDetails);
                        _includeGameOptState();
                      },
                    ),
                  ),
                ],
              ),
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

  Widget buildThirdList(List<Subcategory_details> subcategoryDetailsList) {
    //final List<String> listData1 = <String>['Player vs Player', 'Play With Friend', 'Play With Random', 'Tournament', 'Play With Computer'];
    subcategoryDetails = List.from(subcategoryDetailsList);
    //print('subcategoryDetails.length----' + subcategoryDetails.length.toString());

    if (subcategory.length > 0) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.fromLTRB(5.0, 33.0, 16.0, 5.0),
        itemCount: subcategoryDetails.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return BounceInRight(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(36)),
              ),
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.grey[350],
                        width: 5,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                    ),
                    child: CircleAvatar(
                      child: SvgPicture.asset('assets/icons/svg/cricket.svg'),
                      //backgroundColor: Colors.black38,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 16, 0, 2),
                    child: GestureDetector(
                      child: Text(
                        subcategoryDetails[index].gametypeName,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontFamily: 'neuropol_x_rg',
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      onTap: () {
                        print('Clicked on 3rd screen ${subcategoryDetails[index].gametypeName}');

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GameMoreOption(gameType: subcategoryDetails[index].gametypeName),
                            // Pass the arguments as part of the RouteSettings. The
                            // DetailScreen reads the arguments from these settings.
                            settings: RouteSettings(
                              arguments: subcategoryDetails,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            preferences: AnimationPreferences(
                duration: const Duration(milliseconds: 1000),
                autoPlay: AnimationPlayStates.Forward),
          );
        },
      );
    } else {
      return SizedBox();
    }
  }
}
