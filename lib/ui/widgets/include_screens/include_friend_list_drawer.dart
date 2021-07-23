import 'dart:ui';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/horizontal_progress_indicator.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/no_data_found.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/include_screens/include_searching_for_friend.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clash_of_cardz_flutter/bloc/api_bloc.dart';
import 'package:clash_of_cardz_flutter/model/responses/friends_res_model.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:shape_of_view/shape_of_view.dart';


Widget friendList(BuildContext context, String xApiKey, String memberId, String gameCat1, String gameCat2, String gameCat3,
    String gameCat4, String cardsToPlay, String playerType, String playerName, String playerImg) {
  return StreamBuilder(
    stream: apiBloc.friendsRes,
    builder: (context, AsyncSnapshot<FriendsResModel> snapshot) {
      if (snapshot.hasData && snapshot.data.status != 0) {
        return searchableUsersWidget(context, snapshot.data, xApiKey, memberId, gameCat1, gameCat2, gameCat3, gameCat4, cardsToPlay,
            playerType, playerName, playerImg);
      } else return Container(
          height: 10,
          color: Color(0xFF364B5A),
          child: HorizontalProgressIndicator(),
        );
    },
  );
}

Widget searchableUsersWidget(BuildContext context, FriendsResModel data, String xApiKey, String memberId, String gameCat1, String gameCat2,
    String gameCat3, String gameCat4, String cardsToPlay, String playerType, String playerName, String playerImg) {
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
          Container(
            padding: EdgeInsets.only(top: 55),
            color: Color(0xFF253845),
            height: MediaQuery.of(context).size.height - 43,
            width: double.infinity,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                ),
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
                            ShapeOfView(
                              height: 40,
                              width: 40,
                              shape: CircleShape(borderColor: Colors.cyanAccent, borderWidth: 1.0),
                              elevation: 8,
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/icons/png/circle-avator-default-img.png',
                                image: dataList[index].photo,
                                fit: BoxFit.cover,
                              ),
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 6, 0, 3),
                                  child: Text(
                                    dataList[index].fullname,
                                    style: TextStyle(color: Colors.white, fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: dataList[index].liveStatus == 1
                                      ? Text('Online',
                                          style: TextStyle(color: Colors.cyanAccent, fontSize: 11, letterSpacing: .3),)
                                      : Text('Offline', style: TextStyle(color: Colors.white60, fontSize: 11, letterSpacing: .3),),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
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
                          dataList[index].photo, playerName, playerImg
                        );
                      },
                    ),
                    preferences:
                        AnimationPreferences(duration: const Duration(milliseconds: 1300), autoPlay: AnimationPlayStates.Forward),
                  );
                }),
          ),

          Container(
            height: 43,
            margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(30),
              borderRadius: BorderRadius.all(
                Radius.circular(6),
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

void sendNotificationToOtherPlayerByApi(BuildContext context, String xApiKey, String memberId,  String gameCat1, String gameCat2,
    String gameCat3, String gameCat4, String cardsToPlay, String playerType, String friendId, String friendName, String friendImage,
    String playerName, String playerImg,
    ) {

  //Friend id = Who is sending notification
  //Receiver id = who is receiving notification
  //wants to play a game with you for 14 cards Cricket
  apiBloc.sendNotificationToFriendApi(xApiKey, 'Clash Of Cardz', '$playerName wants to play $gameCat2 match - $cardsToPlay cards', friendId, gameCat1,
      gameCat2, gameCat3, gameCat4, 'vs Friends', playerType, cardsToPlay, friendId, friendName, friendImage);

  //print('---- friend Id: $friendId, memberId: $memberId, gameCat2: $gameCat2, cardsToPlay: $cardsToPlay');

  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) => IncludeSearchingForFriend(
      gameCat1: gameCat1,
      gameCat2: gameCat2,
      gameCat3: gameCat3,
      gameCat4: gameCat4,
      playerType: playerType,
      gameType: 'vs Friends',
      cardsToPlay: cardsToPlay,
      xApiKey: xApiKey,
      p1FullName: playerName,
      p1MemberId: memberId,
      p1Photo: playerImg,
    ),),);
}
