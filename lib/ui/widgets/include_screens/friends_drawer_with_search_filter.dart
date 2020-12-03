import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:trump_card_game/model/responses/friends_res_model.dart';
import 'package:trump_card_game/ui/screens/gameplay.dart';

class IncludeFriendList extends StatefulWidget {
  @override
  _IncludeFriendListState createState() => _IncludeFriendListState();
}

class _IncludeFriendListState extends State<IncludeFriendList> {
  var _searchEdit = new TextEditingController();
  BuildContext context;
  bool _isSearch = true;
  String _searchText = "";

  List<Response> _socialListItems;
  List<Response> _searchListItems;

  @override
  void initState() {
    super.initState();
    friendList(context);
  }

  _IncludeFriendListState() {
    _searchEdit.addListener(() {
      if (_searchEdit.text.isEmpty) {
        setState(() {
          _isSearch = true;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearch = false;
          _searchText = _searchEdit.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Search List"),
      ),
      body: new Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: new Column(
          children: <Widget>[_searchBox(), _isSearch ? _listView() : _searchListView()],
        ),
      ),
    );
  }

  Widget _searchBox() {
    return new Container(
      decoration: BoxDecoration(border: Border.all(width: 1.0)),
      child: new TextField(
        controller: _searchEdit,
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: new TextStyle(color: Colors.grey[300]),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _listView() {
    return new Flexible(
      child: new ListView.builder(
          itemCount: _socialListItems.length,
          itemBuilder: (BuildContext context, int index) {
            return buildList(context, _socialListItems);
          }),
    );
  }

  Widget _searchListView() {
    _searchListItems = new List<Response>();
    for (int i = 0; i < _socialListItems.length; i++) {
      var item = _socialListItems[i];

      if (item.fullname.toLowerCase().contains(_searchText.toLowerCase())) {
        _searchListItems.add(item);
      }
    }
    return _searchAddList();
  }

  Widget _searchAddList() {
    return new Flexible(
      child: new ListView.builder(
          itemCount: _searchListItems.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              color: Colors.cyan[100],
              elevation: 5.0,
              child: new Container(
                  margin: EdgeInsets.all(15.0),
                  child: buildList(context, _searchListItems)),
            );
          }),
    );
  }

  Widget friendList(BuildContext context) {
    _socialListItems = new List<Response>();

    return StreamBuilder(
      //stream: apiBloc.friendsRes,
      stream: apiBloc.friendsRes,
      builder: (context, AsyncSnapshot<FriendsResModel> snapshot) {
        if (snapshot.hasData) {
          _socialListItems = List.from(snapshot.data.response);
          //buildList(context, snapshot.data);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Container(
          height: 250,
          child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
              )),
        );
      },
    );
  }

  Widget buildList(BuildContext context, List<Response> searchListItems) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.grey[700],
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: ListView.builder(
                itemCount: searchListItems.length,
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
                              backgroundImage: NetworkImage(searchListItems[index].photo),
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
                                    searchListItems[index].fullname,
                                    style: TextStyle(color: Colors.white, fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text(searchListItems[index].matchPlayed,
                                      style: TextStyle(color: Colors.white70, fontSize: 13, letterSpacing: .3)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => new Gameplay(
                            name: searchListItems[index].fullname,
                            friendId: searchListItems[index].freindId,
                          ),
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
}


Widget buildFriendDrawer(){
  BuildContext context;
  return  Drawer(
    child: new ListView(
      children: <Widget>[
        Container(
          height: 115,
          child: DrawerHeader(
            margin: EdgeInsets.all(0),
            child: Column(
              children: [
                Text(
                  'Friends',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'neuropol_x_rg',
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(30),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Friend ID or Name",
                            hintStyle: TextStyle(
                              color: Colors.white.withAlpha(120),
                            ),
                            border: InputBorder.none,
                          ),
                          onChanged: (String keyword) {},
                        ),
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.white.withAlpha(120),
                      )
                    ],
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.grey[700],
            ),
          ),
        ),
        //building friend list ui in drawer
        friendList(context),
      ],
    ),
  );
}


Widget friendList(BuildContext context) {
  return  StreamBuilder(
    stream: apiBloc.friendsRes,
    builder: (context, AsyncSnapshot<FriendsResModel> snapshot) {
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

Widget buildList(BuildContext context, FriendsResModel data) {
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
                                child: Text('Match played: ' + data.response[index].matchPlayed,
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                        letterSpacing: .3)),
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
                        builder: (context) => new Gameplay(
                          name: data.response[index].fullname,
                          friendId: data.response[index].freindId,),
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
