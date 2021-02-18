import 'package:flutter/material.dart';
import 'package:clash_of_cardz_flutter/bloc/api_bloc.dart';
import 'package:clash_of_cardz_flutter/model/responses/statistics_res_model.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/frosted_glass.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/include_screens/include_statistics_screen.dart';

class Statistics extends StatelessWidget {
  String xApiKey;
  String memberId;

  Statistics(String xApiKey, String memberId){
    this.xApiKey = xApiKey;
    this.memberId = memberId;
  }

  @override
  Widget build(BuildContext context) {
    apiBloc.fetchStatisticsRes(xApiKey, memberId);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
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
              if (snapshot.hasData && snapshot.data.response.length > 0) {
                return buildStatisticsScreen(snapshot.data);
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
      ),
    );
  }
}
