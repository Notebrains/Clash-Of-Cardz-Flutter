import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trump_card_game/model/responses/statistics_res_model.dart';

Column buildStatisticsScreen(StatisticsResModel model ) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 4.0),
        child: Text(
          'Statistics',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 35.0,
            fontStyle: FontStyle.normal,
            fontFamily: 'Rapier',
            color: Colors.grey[700],
          ),
        ),
      ),
      Expanded(
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
          itemCount: model.response.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(5),
              decoration: new BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, stops: [0.1, 0.3, 1], colors: [Colors.grey[300], Colors.grey[50], Colors.grey[300]]),
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(3, 3),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: Stack(
                            children: <Widget>[
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(12.0, 5, 12, 5),
                                    child: SvgPicture.asset('assets/icons/svg/victory.svg',
                                        width: 22,
                                        height: 22),
                                  ),
                                  Text (isMatchWon(model.response[index].matchData[0].win) ? 'Victory' : 'Lost',
                                      style: TextStyle(color: isMatchWon(model.response[index].matchData[0].win) ? Colors.lightBlue : Colors.red,
                                          fontSize: 20,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: 'Rapier')),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 30,
                          padding: EdgeInsets.only(right: 8),
                          alignment: AlignmentDirectional.centerEnd,
                          child: Container(
                            child: new Text( model.response[index].gameCat + ' - ' +  model.response[index].noCard + ' cards', style: TextStyle(color: Colors.black54, fontSize: 20, fontStyle: FontStyle.normal, fontFamily: 'Rapier')),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.deepOrange,
                    height: 1,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          alignment: AlignmentDirectional.center,
                          margin: EdgeInsets.all(5.0),
                          child: Stack(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(model.response[index].matchData[0].photo),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 110,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(16, 1, 3, 1),
                                          child: Text(model.response[index].matchData[0].fullname,
                                              style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w900)),
                                        ),
                                        Container(
                                          height: 26,
                                          padding: const EdgeInsets.fromLTRB(16, 1, 3, 1),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/icons/svg/coin.svg',
                                                width: 16,
                                                height: 16,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 5),
                                                child: Text(model.response[index].matchData[0].coins, style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w700)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Image.asset (
                        'assets/icons/png/img_vs.png',
                        width: 45,
                        height: 45,
                        color: Colors.deepOrangeAccent,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          alignment: AlignmentDirectional.center,
                          margin: EdgeInsets.all(5.0),
                          child: Stack(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: 110,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(16, 1, 13, 1),
                                          child: Text(model.response[index].matchData[1].fullname, style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w900)),
                                        ),
                                        Container(
                                          height: 26,
                                          padding: const EdgeInsets.fromLTRB(16, 5, 13, 5),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/icons/svg/coin.svg',
                                                width: 16,
                                                height: 16,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 5),
                                                child: Text(model.response[index].matchData[1].coins, style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w700)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(model.response[index].matchData[1].photo),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}

bool isMatchWon(String win) {
  if(win == '1'){
    return true;
  }else{
    return false;
  }
}