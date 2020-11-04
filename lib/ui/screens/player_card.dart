import 'package:flutter/material.dart';
import 'package:trump_card_game/helper/exten_fun/common_fun.dart';
import 'package:trump_card_game/helper/exten_fun/internet_fun.dart';
import 'file:///E:/Downloads/MRIDAYA%20OFFICE/Flutter%20Projects/Clash-Of-Cardz-Flutter/lib/ui/widgets/test/semi_circle_menu.dart';

class PlayerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("PlayerCard"),
        ),
        body: PlayerCardStateFull(),
      ),
    );
  }
}

class PlayerCardStateFull extends StatefulWidget{
  PlayerCardStateFull({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PlayerCardState();
}

class PlayerCardState extends State<PlayerCardStateFull>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            children: [
              RaisedButton(
                onPressed: (){
                  //playAssetAudio("sword_sms.mp3");
                },
                child: const Text('Play Asset Audio',
                style: TextStyle(fontSize: 16),),
              ),
              RaisedButton(
                onPressed: (){
                  //playUrlAudio("https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3");
                },
                child: const Text('Play Url Audio',
                  style: TextStyle(fontSize: 16),),
              ),

              RaisedButton(
                onPressed: (){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext context) => SemiCircleMenu()));
                },
                child: const Text('Next',
                  style: TextStyle(fontSize: 16),),
              ),
            ],
          ),
        ),
    );
  }
}