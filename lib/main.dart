import 'package:flutter/material.dart';
import 'package:trump_card_game/ui/screens/player_card.dart';
import 'package:trump_card_game/ui/screens/splash.dart';

void main() => runApp(MyRootApp());

class MyRootApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PlayerCard(),
    );
  }
}