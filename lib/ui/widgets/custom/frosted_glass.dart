import 'dart:ui';
import 'package:flutter/material.dart';

Center frostedGlassWithProgressBarWidget(BuildContext context) => Center(
  child: Stack(
    children: <Widget>[
      new ConstrainedBox(
          constraints: const BoxConstraints.expand(),
      ),
      new Center(
        child: new ClipRect(
          child: new BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.grey.shade200.withOpacity(0.1)
              ),
              child: new Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  ),
);