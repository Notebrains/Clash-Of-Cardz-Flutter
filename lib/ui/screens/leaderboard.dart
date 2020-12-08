import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:trump_card_game/helper/constantvalues/constants.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:trump_card_game/model/responses/leaderboard_res_model.dart';
import 'package:trump_card_game/ui/widgets/custom/frosted_glass.dart';

class Leaderboard extends StatelessWidget {
   List<Response> listData;

  @override
  Widget build(BuildContext context) {
    setScreenOrientationToLandscape();
    apiBloc.fetchLeaderboardRes("ZGHrDz4prqsu4BcApPaQYaGgq");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/bg_img11.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: StreamBuilder(
            stream: apiBloc.leaderboardRes,
            builder: (context, AsyncSnapshot<LeaderboardResModel> snapshot) {
              if (snapshot.hasData) {
                return _buildLeaderboardScreen(snapshot.data);
              } else if (!snapshot.hasData) {
                return frostedGlassWithProgressBarWidget(context);
              } else return Center(
                child: Text("No Data Found",
                    style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 30)
                ),
              );
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Column topPlayerCards(String image, String points, String playerName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 33,
                height: 33,
                child: IconButton(
                  icon: SvgPicture.asset('assets/icons/svg/coin.svg'),
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text(
                  points,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
        ),
        Text(playerName, style: TextStyle(color: Colors.white)),
        IconButton(
          icon: SvgPicture.asset(
            image,
            width: 25,
            height: 25,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Row _buildLeaderboardScreen(LeaderboardResModel data) {
    listData = data.response;
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Text(
                  'LEADERBOARD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35.0,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'Rapier',
                    color: Colors.grey[700],
                  ),
                ),
              ),
              Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ClipRRect(
                      child: SizedBox(
                        width: 115,
                        height: 120,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.greenAccent[700],
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.blueGrey,
                                offset: Offset(5, 5),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: topPlayerCards(
                              'assets/icons/svg/madel_first.svg',
                              listData[0].points,
                              listData[0].fullname),
                        ),
                      ),
                      borderRadius: new BorderRadius.circular(8.0),
                    ),
                  ),
                  ClipRRect(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(listData[0].photo),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                        child: ClipRRect(
                          child: SizedBox(
                            width: 115,
                            height: 120,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.cyan[600],
                              ),
                              child: topPlayerCards(
                                  'assets/icons/svg/leaf_second.svg',
                                  listData[1].points,
                                  listData[1].fullname
                              ),
                            ),
                          ),
                          borderRadius: new BorderRadius.circular(8.0),
                        ),
                      ),
                      ClipRRect(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(listData[1].photo),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                        child: ClipRRect(
                          child: SizedBox(
                            width: 115,
                            height: 120,
                            child: DecoratedBox(
                              decoration:
                                  BoxDecoration(color: Colors.indigo[900]),
                              child: topPlayerCards(
                                  'assets/icons/svg/leaf_third.svg',
                                  listData[2].points,
                                  listData[2].fullname),
                            ),
                          ),
                          borderRadius: new BorderRadius.circular(8.0),
                        ),
                      ),
                      ClipRRect(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(listData[2].photo),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 12.0, 2.0, 0.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Rank',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'montserrat',
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Point/Name',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'montserrat',
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Text(
                          'Image',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'montserrat',
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.black,
                height: 1,
                thickness: 1,
              ),
              Expanded(
                child: buildList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container buildList() {
    return Container(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.fromLTRB(25.0, 2.0, 16.0, 8.0),
        itemCount: listData.length,
        itemBuilder: (context, index) {
          if (index < 3) return SizedBox();
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Text(
                          listData[index].rank.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'montserrat',
                            color: Colors.grey[700],
                          ),
                        ),
                        new Container(
                          height: 30.0,
                          width: 1.0,
                          color: Colors.black54,
                          margin: const EdgeInsets.only(left: 16.0, right: 0.0),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(18.0, 5.0, 5.0, 5.0),
                      child: Text(
                        listData[index].points + '\n' + listData[index].fullname,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'montserrat',
                          color: Colors.grey[900],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: 40,
                      height: 40,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(listData[index].photo),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.black,
                height: 1,
              ),
            ],
          );
        },
      ),
    );
  }
}
