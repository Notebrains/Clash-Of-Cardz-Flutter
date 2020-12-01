import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:trump_card_game/model/responses/leaderboard_res_model.dart';
import 'package:trump_card_game/ui/screens/gameplay.dart';

Widget friendList(BuildContext context) {

  return  StreamBuilder(
    //stream: apiBloc.friendsRes,
    stream: apiBloc.leaderboardRes,
    builder: (context, AsyncSnapshot<LeaderboardResModel> snapshot) {
      if (snapshot.hasData) {
        return buildList(context, snapshot.data);
      } else if (snapshot.hasError) {
        return Text(snapshot.error.toString());
      }
      return Container(
        height: 250,
        child: Center(child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
        )),
      );
    },
  );
}

Widget buildList(BuildContext context, LeaderboardResModel data) {
  return Container(
    child: Stack(
      children: <Widget>[
        Container(
          color: Colors.grey[700],
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: ListView.builder(
              itemCount: data.response.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(18, 5, 5, 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(35)),
                          ),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(data.response[index].photo),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 0, 2),
                                child: Text(
                                  data.response[index].fullname,
                                  style: TextStyle(color: Colors.white, fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(data.response[index].points, style: TextStyle(color: Colors.white70, fontSize: 13, letterSpacing: .3)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context,
                      CupertinoPageRoute(
                        builder: (context) => new Gameplay(name: data.response[index].fullname, memberId: data.response[index].memberid,),
                      ),
                    );
                  },
                );
              }),
        ),
      ],
    ),
  );
}
