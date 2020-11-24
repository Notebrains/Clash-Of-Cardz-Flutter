import 'package:flutter/material.dart';
import 'package:trump_card_game/bloc/api_bloc.dart';
import 'package:trump_card_game/model/responses/statistics_res_model.dart';
import 'package:trump_card_game/ui/widgets/custom/frosted_glass.dart';
import 'package:trump_card_game/ui/widgets/include_screens/include_statistics_screen.dart';

class Statistics extends StatelessWidget {
  // This widget is the root of your application.
  final List<String> entries = <String>['A', 'B', 'C', 'C', 'C', 'C', 'C', 'C', 'C', 'C', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    apiBloc.fetchStatisticsRes('ZGHrDz4prqsu4BcApPaQYaGgq', 'MEM000002');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/bg_img13.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: StreamBuilder(
            stream: apiBloc.statisticsRes,
            builder: (context, AsyncSnapshot<StatisticsResModel> snapshot) {
              if (snapshot.hasData && snapshot.data.response.length>0) {
                return buildStatisticsScreen(snapshot.data);
              } else if (!snapshot.hasData) {
                return Text("No Data Found",
                    style: TextStyle(color: Colors.white24)
                );
              }
              return frostedGlassWithProgressBarWidget(context);
            },
          ),
        ),
      ),
    );
  }
}
