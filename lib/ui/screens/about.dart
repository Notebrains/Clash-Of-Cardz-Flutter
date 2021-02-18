import 'package:flutter/material.dart';
import 'package:clash_of_cardz_flutter/bloc/api_bloc.dart';
import 'package:clash_of_cardz_flutter/helper/constantvalues/constants.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/base_application_fun.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/common_fun.dart';
import 'package:clash_of_cardz_flutter/model/responses/cms_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/statistics_res_model.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/frosted_glass.dart';

class AboutScreen extends StatelessWidget{
  String xApiKey = '';
  AboutScreen(String xApiKey) {
    this.xApiKey = xApiKey;
  }

  @override
  Widget build(BuildContext context) {
    apiBloc.fetchCmsRes(xApiKey, 'about-us');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/bg_img11.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: StreamBuilder(
            stream: apiBloc.cmsResModel,
            builder: (context, AsyncSnapshot<CmsResModel> snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.response.cmsMeta.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(15, 5, 5, 16),
                              //width: MediaQuery.of(context).size.width * 0.3,
                              child: Column(
                                children: [
                                  Text(snapshot.data.response.cmsMeta[index].title, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                                  Image.network(snapshot.data.response.cmsMeta[index].image),
                                  Text(parseHtmlString(snapshot.data.response.cmsMeta[index].content), style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),),
                                  SizedBox(height: 16),
                                ],
                              ),
                            );
                          }),
                    ),

                    Container(
                      margin: EdgeInsets.fromLTRB(16, 16, 0, 0, ),
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: FloatingActionButton(
                          tooltip: 'Back to previous screen',
                          backgroundColor: Colors.deepOrangeAccent,
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            onTapAudio('button');
                            Navigator.of(context, rootNavigator: true).pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                );
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