import 'package:clash_of_cardz_flutter/ui/widgets/custom/no_data_found.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/include_screens/player_info_back_btn.dart';
import 'package:flutter/material.dart';
import 'package:clash_of_cardz_flutter/bloc/api_bloc.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/base_application_fun.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/common_fun.dart';
import 'package:clash_of_cardz_flutter/model/responses/cms_res_model.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/frosted_glass.dart';

class AboutScreen extends StatelessWidget{
  String xApiKey = '';
  AboutScreen(String xApiKey) {
    this.xApiKey = xApiKey;
  }

  @override
  Widget build(BuildContext context) {
    apiBloc.fetchCmsRes(xApiKey, 'about-us');

    return Scaffold(
      backgroundColor: Color(0xFF364B5A),
      body: StreamBuilder(
        stream: apiBloc.cmsResModel,
        builder: (context, AsyncSnapshot<CmsResModel> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                PlayerInfoBackBtn(pageTitle: '',),

                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 5, 16, 16),
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.response.cmsMeta.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.fromLTRB(15, 5, 5, 16),
                            //width: MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              children: [
                                Text(snapshot.data.response.cmsMeta[index].title, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                                Image.network(snapshot.data.response.cmsMeta[index].image),
                                Text(parseHtmlString(snapshot.data.response.cmsMeta[index].content), style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
                                SizedBox(height: 16),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ],
            );
          } else if (!snapshot.hasData) {
            return frostedGlassWithProgressBarWidget(context);
          } else return NoDataFound();
        },
      ),
    );
  }
}