import 'package:carousel_slider/carousel_slider.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/no_data_found.dart';
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
      backgroundColor: Color(0xFF364B5A),
      body: StreamBuilder(
        stream: apiBloc.cmsResModel,
        builder: (context, AsyncSnapshot<CmsResModel> snapshot) {
          if (snapshot.hasData) {
            return buildUI(snapshot.data.response);
          } else if (!snapshot.hasData) {
            return frostedGlassWithProgressBarWidget(context);
          } else
            return NoDataFound();
        },
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
      child: Stack(
        children: [
          Column(
            children: <Widget>[
              CarouselSlider(
                items: imageSliders,
                options: CarouselOptions(viewportFraction: 1.0, enlargeCenterPage: true, height: MediaQuery.of(context).size.height - 55),
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
                      child: FloatingActionButton(
                        mini: true,
                        tooltip: 'Back to previous screen',
                        backgroundColor: Colors.cyanAccent,
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
                    ...Iterable<int>.generate(response.cmsMeta.length).map(
                          (int pageIndex) => Flexible(
                        child: Container(
                          width: 35,
                          height: 35,
                          alignment: Alignment.center,
                          child: FloatingActionButton(
                            tooltip: 'Next',
                            backgroundColor: Colors.cyanAccent[200],
                            child: Text(
                              "${pageIndex + 1}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'neuropol_x_rg',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                              ),
                            ),
                            onPressed: () {
                              onTapAudio('button');
                              _controller.animateToPage(pageIndex);
                            },
                          ),
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      alignment: Alignment.center,
                      child: FloatingActionButton(
                        mini: true,
                        tooltip: 'Previous',
                        backgroundColor: Colors.cyanAccent,
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
                  ],
                ),
              )
            ],
          ),

          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 30,
              height: 30,
              margin: EdgeInsets.all(12),
              child: FloatingActionButton(
                mini: true,
                tooltip: 'Previous',
                backgroundColor: Colors.orange,
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {
                  onTapAudio('button');
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
