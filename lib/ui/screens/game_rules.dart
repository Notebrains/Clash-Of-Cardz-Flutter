import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:clash_of_cardz_flutter/bloc/api_bloc.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/base_application_fun.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/common_fun.dart';
import 'package:clash_of_cardz_flutter/model/responses/cms_res_model.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/frosted_glass.dart';

List<String> imgList = [];

class GameRule extends StatefulWidget {
  GameRule({this.xApiKey, this.memberId});

  final String xApiKey;
  final String memberId;

  @override
  State<StatefulWidget> createState() {
    return _GameRuleState();
  }
}

class _GameRuleState extends State<GameRule> {
  BuildContext context;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    setScreenOrientationToLandscape();
    apiBloc.fetchCmsRes(widget.xApiKey, 'about-us');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/bg_img13.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder(
          stream: apiBloc.cmsResModel,
          builder: (context, AsyncSnapshot<CmsResModel> snapshot) {
            if (snapshot.hasData) {
              return buildUI(snapshot.data.response);
            } else if (!snapshot.hasData) {
              return frostedGlassWithProgressBarWidget(context);
            } else
              return Center(
                child: Text("No Data Found", style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 30)),
              );
          },
        ),
      ),
    );
  }

  List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                child: Stack(
                  children: <Widget>[
                    FadeInImage.assetNetwork(
                      fit: BoxFit.fill,
                      placeholder: 'assets/animations/gifs/loading_text.gif',
                      image: item ?? '',
                      width: double.infinity - 60,
                    ),
                  ],
                ),
              ),
            ),
          ))
      .toList();

  Widget buildUI(Response response) {
    for(int i =0 ; i< response.cmsMeta.length; i++){
      imgList.add(response.cmsMeta[i].image);
    }

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          CarouselSlider(
            items: imageSliders,
            options: CarouselOptions(viewportFraction: 1.0, enlargeCenterPage: true, height: MediaQuery.of(context).size.height - 68),
            carouselController: _controller,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  alignment: Alignment.center,
                  child: new SizedBox(
                    child: FloatingActionButton(
                      tooltip: 'Back to previous screen',
                      backgroundColor: Colors.grey[300],
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        onTapAudio('button');
                        _controller.previousPage();
                      },
                    ),
                  ),
                ),
                ...Iterable<int>.generate(response.cmsMeta.length).map(
                  (int pageIndex) => Flexible(
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      child: new SizedBox(
                        child: FloatingActionButton(
                          tooltip: 'Next',
                          backgroundColor: Colors.grey[300],
                          child: Text(
                            "${pageIndex + 1}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'neuropol_x_rg',
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          onPressed: () {
                            onTapAudio('button');
                            _controller.animateToPage(pageIndex);
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  alignment: Alignment.center,
                  child: new SizedBox(
                    child: FloatingActionButton(
                      tooltip: 'Previous',
                      backgroundColor: Colors.grey[300],
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        onTapAudio('button');
                        _controller.nextPage();
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
