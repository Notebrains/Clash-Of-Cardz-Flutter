import 'dart:async';

import 'package:flutter/material.dart';

import 'package:trump_card_game/ui/widgets/animations/spring_button.dart';

class MyHomePages extends StatefulWidget {
  MyHomePages() : super();

  final String title = "";

  @override
  _MyHomePageStates createState() => _MyHomePageStates();
}

class _MyHomePageStates extends State<MyHomePages> {
  Timer timer;
  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      counter--;
    });
  }

  Widget row(String text, Color color) {
    return Padding(
      padding: EdgeInsets.all(12.5),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
        ),
        child: Center(
          child: Text(
            'Text',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Center(
              child: Text(
                'Value',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SpringButton(
              SpringButtonType.WithOpacity,
              row(
                "Increment",
                Colors.deepPurpleAccent,
              ),
              onTapDown: (_) => incrementCounter(),
              onLongPress: () => timer = Timer.periodic(
                const Duration(milliseconds: 100),
                    (_) => incrementCounter(),
              ),
              onLongPressEnd: (_) {
                timer?.cancel();
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: SpringButton(
              SpringButtonType.OnlyScale,
              row(
                "Decrement",
                Colors.redAccent,
              ),
              onTapDown: (_) => decrementCounter(),
              onLongPress: () => timer = Timer.periodic(
                const Duration(milliseconds: 100),
                    (_) => decrementCounter(),
              ),
              onLongPressEnd: (_) {
                timer?.cancel();
              },
            ),
          ),
        ],
      ),
    );
  }
}