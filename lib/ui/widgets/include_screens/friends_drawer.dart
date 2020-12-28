import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:trump_card_game/helper/constantvalues/constants.dart';
import 'package:trump_card_game/model/responses/friends_res_model.dart';
import 'package:trump_card_game/ui/screens/gameplay.dart';
import 'package:flutter_animator/flutter_animator.dart';

import 'include_searching_players.dart';

Widget friendList(BuildContext context) {
  return StreamBuilder(
    stream: apiBloc.friendsRes,
    builder: (context, AsyncSnapshot<FriendsResModel> snapshot) {
      if (snapshot.hasData) {
        return searchableUsersWidget(context, snapshot.data);
      } else if (snapshot.hasError) {
        return Text(snapshot.error.toString());
      }
      return Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.grey[600],
        child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
            )),
      );
    },
  );
}

Widget searchableUsersWidget(BuildContext context, FriendsResModel data) {
  List<Response> dataList = data.response;

  ValueNotifier<List<Response>> filtered = ValueNotifier<List<Response>>([]);
  //TextEditingController searchController = TextEditingController();
  //FocusNode searchFocus = FocusNode();
  bool searching = false;
  return ValueListenableBuilder<List>(
      valueListenable: filtered,
      builder: (context, value, _) {
        return Container(
          child: Stack(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 60),
                  color: Colors.grey[700],
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      itemCount: searching ? filtered.value.length : dataList.length,
                      itemBuilder: (context, index) {
                        //final item = searching ? filtered.value[index] : dataList[index].fullname;
                        return GestureDetector(
                          child: SlideInLeft(
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
                                      backgroundImage: NetworkImage(dataList[index].photo),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(8, 6, 0, 3),
                                          child: Text(
                                            dataList[index].fullname,
                                            style: TextStyle(color: Colors.white, fontSize: 15),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8),
                                          child: dataList[index].liveStatus == 1? Text('Online',
                                              style: TextStyle(color: Colors.greenAccent[400], fontSize: 13, letterSpacing: .3))
                                              : Text('Offline', style: TextStyle(color: Colors.white60, fontSize: 13, letterSpacing: .3)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            preferences: AnimationPreferences(
                                duration: const Duration(milliseconds: 1300),
                                autoPlay: AnimationPlayStates.Forward),
                          ),

                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => IncludeSearchingForPlayer(),
                            );

                            /*Navigator.push(context,
                              CupertinoPageRoute(
                                builder: (context) => new Gameplay(
                                  name: dataList[index].fullname,
                                  friendId: dataList[index].freindId,),
                              ),
                            );*/
                          },
                        );
                      }),
                ),
              ),

              Container(
                height: 50,
                margin: EdgeInsets.fromLTRB(12, 2, 12, 5),
                padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(30),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.search,
                        color: Colors.white.withAlpha(120),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.white70),
                        decoration: InputDecoration(
                          hintText: "Friend ID or Name",
                          hintStyle: TextStyle(
                            color: Colors.white.withAlpha(120),
                          ),
                          border: InputBorder.none,
                        ),
                        onChanged: (text) {
                          if (text.length > 0) {
                            searching = true;
                            filtered.value = [];
                            dataList.forEach((user) {
                              if (user.fullname.toString().toLowerCase().contains(text.toLowerCase()) ||
                                  user.freindId.contains(text)) {
                                filtered.value.add(user);
                              }
                            });
                          } else {
                            searching = false;
                            filtered.value = [];
                          }
                        },
                      ),
                    ),

                    //close icon
                    /*searching
                        ? IconButton(
                            icon: new Icon(
                              Icons.clear,
                              color: Colors.white.withAlpha(90),
                              size: 20,
                            ),
                            onPressed: () {
                              searchController.clear();
                              searching = false;
                              filtered.value = [];
                              if (searchFocus.hasFocus) searchFocus.unfocus();
                            },
                          )
                        : SizedBox(),*/
                  ],
                ),
              ),
            ],
          ),
        );
      },
  );
}

