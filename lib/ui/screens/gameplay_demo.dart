import 'package:flutter/material.dart';

class GameplayDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Gameplay"),
        ),
        body: GameplayStateFull(),
      ),
    );
  }
}

class GameplayStateFull extends StatefulWidget{
  GameplayStateFull({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => GameplayState();
}

class GameplayState extends State<GameplayStateFull>{
  @override
  Widget build(BuildContext context) {
    return Row(
        
    );
  }
}
