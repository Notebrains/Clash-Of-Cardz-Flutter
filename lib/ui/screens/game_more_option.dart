import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:trump_card_game/model/responses/friends_res_model.dart';
import 'package:trump_card_game/ui/screens/setting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trump_card_game/ui/widgets/include_screens/friends_drawer.dart';
import 'package:trump_card_game/ui/widgets/libraries/colorize.dart';
import 'package:trump_card_game/ui/widgets/libraries/semi_circle_listview/dart/circle_wheel_scroll_view.dart';
import 'package:trump_card_game/ui/widgets/views/view_widgets.dart';
import 'leaderboard.dart';

class GameMoreOption extends StatelessWidget {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  Widget _buildCircleItems(int i) {
    return Container(
        margin: EdgeInsets.only(left: 80),
        child: Row(
          children: [
            Container(
              width: 40,
              padding: EdgeInsets.all(5),
              //color: Colors.white,
              child: Center(
                child: Text(i.toString(),
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.w900)),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.orange, spreadRadius: 2, blurRadius: 3),
                ],
              ),
            ),
            Listener(
              onPointerDown: (e) {
                print('onPointerDown');
              },
              child: InkWell(
                onTap: () {
                  print('-----');
                },
                onDoubleTap: () {
                  print('-----');
                },
                onLongPress: () {
                  print('-----');
                },
                splashColor: Colors.yellow,
                highlightColor: Colors.blue.withOpacity(0.5),
                child: Container(
                  width: 120,
                  padding: EdgeInsets.all(5),
                  child: Center(
                    child: Text('Cricket'),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey, // assign key to Scaffold
      drawer: Drawer(
        child: new ListView(
          children: <Widget>[

            Container(
              height: 120,
              child: DrawerHeader(
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
                              onChanged: (String keyword) {

                              },
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

            StreamBuilder(
              stream: apiBloc.friendsRes,
              builder: (context, AsyncSnapshot<FriendsResModel> snapshot) {
                if (snapshot.hasData) {
                  return _buildFriendsScreen(context, snapshot.data);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(child: CircularProgressIndicator());
              },
            ),

          ],
        ),
      ),
      body: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/bg_img3.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              height: 150,
              child: ColorizeAnimatedTextKit(
                onTap: () {
                  //print("Tap Event");
                },
                text: ["CLASH OF CARDZ"],
                textStyle: TextStyle(
                  fontSize: 55.0,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Rapier',
                ),
                colors: [
                  Colors.grey[400],
                  Colors.deepOrange[400],
                  Colors.grey[400],
                ],
                textAlign: TextAlign.center,
                alignment: AlignmentDirectional.center,
                // or Alignment.topLeft
                isRepeatingAnimation: true,
                repeatForever: true,
                speed: Duration(milliseconds: 1000),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      //height: 260,
                      width: 250,
                      child: CircleListScrollView(
                        physics: CircleFixedExtentScrollPhysics(),
                        axis: Axis.vertical,
                        itemExtent: 40,
                        children: List.generate(15, _buildCircleItems),
                        radius: MediaQuery.of(context).size.width * 0.22,
                        renderChildrenOutsideViewport: false,
                        onSelectedItemChanged: (int index) =>
                            print('Current index: $index'),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      //height: 260,
                      width: 250,
                      child: CircleListScrollView(
                        physics: CircleFixedExtentScrollPhysics(),
                        axis: Axis.vertical,
                        itemExtent: 40,
                        children: List.generate(15, _buildCircleItems),
                        radius: MediaQuery.of(context).size.width * 0.22,
                        renderChildrenOutsideViewport: false,
                        onSelectedItemChanged: (int index) =>
                            print('Current index: $index'),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      //height: 260,
                      width: 50,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(5),
                              child: IconButton(
                                icon: Image.asset(
                                    'assets/icons/png/ic_refresh.png'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Leaderboard()));
                                },
                              ),
                              decoration:
                                  Views.boxDecorationWidgetForIconWithBgColor(
                                      Colors.teal[400],
                                      4.0,
                                      Colors.grey,
                                      5.0,
                                      5.0,
                                      3.0),
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(5),
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  'assets/icons/svg/back_black.svg',
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              decoration:
                                  Views.boxDecorationWidgetForIconWithBgColor(
                                      Colors.blue,
                                      4.0,
                                      Colors.grey,
                                      5.0,
                                      5.0,
                                      3.0),
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(5),
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  'assets/icons/svg/logout.svg',
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Setting()));
                                },
                              ),
                              decoration:
                                  Views.boxDecorationWidgetForIconWithBgColor(
                                      Colors.redAccent,
                                      4.0,
                                      Colors.grey,
                                      5.0,
                                      5.0,
                                      3.0),
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(5),
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  'assets/icons/svg/logout.svg',
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _drawerKey.currentState
                                      .openDrawer(); // open drawer
                                },
                              ),
                              decoration:
                                  Views.boxDecorationWidgetForIconWithBgColor(
                                      Colors.purple,
                                      4.0,
                                      Colors.grey,
                                      5.0,
                                      5.0,
                                      3.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildFriendsScreen(BuildContext context, FriendsResModel data) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.grey[700],
            padding: EdgeInsets.only(top: 8),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: ListView.builder(
                itemCount: 30,
                itemBuilder: (BuildContext context, int index) {
                  return userList(context, index);
                }),
          ),
        ],
      ),
    );
  }
}
