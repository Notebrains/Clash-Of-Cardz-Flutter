import 'package:clash_of_cardz_flutter/ui/widgets/custom/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:clash_of_cardz_flutter/bloc/api_bloc.dart';
import 'package:clash_of_cardz_flutter/model/responses/statistics_res_model.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/frosted_glass.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/include_screens/include_statistics_screen.dart';

class Statistics extends StatelessWidget {
  final String xApiKey;
  final String memberId;

  const Statistics({Key key, this.xApiKey, this.memberId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    apiBloc.fetchStatisticsRes(xApiKey, memberId);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:  Color(0xFF405768),
      body: StreamBuilder(
        stream: apiBloc.statisticsRes,
        builder: (context, AsyncSnapshot<StatisticsResModel> snapshot) {
          if (snapshot.hasData && snapshot.data.response.length > 0) {
            return buildStatisticsScreen(snapshot.data);
          } else if (!snapshot.hasData) {
            return frostedGlassWithProgressBarWidget(context);
          } else return NoDataFound();
        },
      ),
    );
  }
}
