import 'package:flutter/material.dart';
import 'package:trump_card_game/ui/screens/weather_screen.dart';

class Leaderboard extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Leaderboard'),
          centerTitle: true,
        ),
        body: WeatherScreen(),
      ),
    );
  }
}
