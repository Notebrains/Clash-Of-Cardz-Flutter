import 'package:clash_of_cardz_flutter/ui/widgets/custom/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:clash_of_cardz_flutter/bloc/api_bloc.dart';
import 'package:clash_of_cardz_flutter/model/responses/profile_res_model.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/loading_sports_frosted_glass.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/include_screens/include_profile.dart';

class Profile extends StatelessWidget {
  // This widget is the root of your application.

  Profile({this.xApiKey, this.memberId});
  final String xApiKey;
  final String memberId;

  @override
  Widget build(BuildContext context) {
    apiBloc.fetchProfileRes(xApiKey, memberId);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Color(0xFF22425E),
        child: StreamBuilder(
          stream: apiBloc.profileRes,
          builder: (context, AsyncSnapshot<ProfileResModel> snapshot) {
            if (snapshot.hasData && snapshot.data.response.length>0) {
              return IncludeProfile(snapshot.data, xApiKey, memberId);
            }  else if (!snapshot.hasData) {
              return frostedGlassWithProgressBarWidget(context);
            } else return NoDataFound();
          },
        ),
      ),
    );
  }
}
