import 'dart:async';
import 'dart:ui';

import 'package:clash_of_cardz_flutter/ui/widgets/custom/horizontal_progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clash_of_cardz_flutter/bloc/api_bloc.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/base_application_fun.dart';
import 'package:clash_of_cardz_flutter/model/responses/friends_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/match_making_res_model.dart';
import 'package:clash_of_cardz_flutter/ui/screens/gameplay.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:lottie/lottie.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/include_screens/include_waiting_for_friend.dart';

import 'include_searching_players.dart';

Widget friendList(BuildContext context, String xApiKey, String memberId, String gameCat1, String gameCat2, String gameCat3,
    String gameCat4, String cardsToPlay, String playerType) {
  return StreamBuilder(
    stream: apiBloc.friendsRes,
    builder: (context, AsyncSnapshot<FriendsResModel> snapshot) {
      if (snapshot.hasData && snapshot.data.status != 0) {
        return searchableUsersWidget(context, snapshot.data, xApiKey, memberId, gameCat1, gameCat2, gameCat3, gameCat4, cardsToPlay, playerType);
      } else return Container(
          color: Color(0xFF364B5A),
          child: HorizontalProgressIndicator(),
        );
    },
  );
}

Widget searchableUsersWidget(BuildContext context, FriendsResModel data, String xApiKey, String memberId, String gameCat1, String gameCat2,
    String gameCat3, String gameCat4, String cardsToPlay, String playerType) {
  List<Response> dataList = data.response;

  ValueNotifier<List<Response>> filtered = ValueNotifier<List<Response>>([]);
  //TextEditingController searchController = TextEditingController();
  //FocusNode searchFocus = FocusNode();
  bool searching = false;
  return ValueListenableBuilder<List>(
    valueListenable: filtered,
    builder: (context, value, _) {
      return Stack(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 60),
              color: Color(0xFF253845),
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  itemCount: searching ? filtered.value.length : dataList.length,
                  itemBuilder: (context, index) {
                    //final item = searching ? filtered.value[index] : dataList[index].fullname;
                    return SlideInLeft(
                      child: InkWell(
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
                                      child: dataList[index].liveStatus == 1
                                          ? Text('Online',
                                              style: TextStyle(color: Colors.greenAccent[400], fontSize: 13, letterSpacing: .3))
                                          : Text('Offline', style: TextStyle(color: Colors.white60, fontSize: 13, letterSpacing: .3)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          //showPlayerSearchingDialog(context);
                          /*Navigator.push(context,
                            CupertinoPageRoute(
                              builder: (context) => new Gameplay(
                                name: dataList[index].fullname,
                                friendId: dataList[index].freindId,),
                            ),
                          );*/

                          sendNotificationToOtherPlayerByApi(
                            context,
                            xApiKey,
                            memberId,
                            gameCat1,
                            gameCat2,
                            gameCat3,
                            gameCat4,
                            cardsToPlay,
                            playerType,
                            dataList[index].freindId,
                            dataList[index].fullname,
                            dataList[index].photo,
                          );
                        },
                      ),
                      preferences:
                          AnimationPreferences(duration: const Duration(milliseconds: 1300), autoPlay: AnimationPlayStates.Forward),
                    );
                  }),
            ),
          ),

          Container(
            height: 45,
            margin: EdgeInsets.fromLTRB(12, 2, 12, 5),
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(30),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      hintText: "Friend Id or Name",
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
                          if (user.fullname.toString().toLowerCase().contains(text.toLowerCase()) || user.freindId.contains(text)) {
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
      );
    },
  );
}

void sendNotificationToOtherPlayerByApi(BuildContext context, String xApiKey, String memberId, String gameCat1, String gameCat2,
    String gameCat3, String gameCat4, String cardsToPlay, String playerType, String friendId, String friendName, String friendImage) {
  apiBloc.sendNotificationToFriendApi(xApiKey, 'Battle with friends', '$friendName request to play match. Play Now', friendId, gameCat1,
      gameCat2, gameCat3, gameCat4, 'vs Friends', playerType, cardsToPlay, memberId, friendName, friendImage);

  showDialog(
    context: context,
    builder: (_) => IncludeWaitingForFriend(
      gameCat1: gameCat1,
      gameCat2: gameCat2,
      gameCat3: gameCat3,
      gameCat4: gameCat4,
      gameType: 'vs Friends',
      playerType: playerType,
      cardsToPlay: cardsToPlay,
      friendId: friendId,
      friendName: friendName,
      friendImage: friendImage,
      joinedPlayerType: 'joinedAsPlayer',
    ),
  );
}
