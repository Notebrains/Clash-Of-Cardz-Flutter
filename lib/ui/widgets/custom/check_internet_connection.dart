import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

OfflineBuilder checkNetConWidget() => OfflineBuilder(
  connectivityBuilder: (BuildContext context,
      ConnectivityResult connectivity, Widget child) {
    final bool connected = connectivity != ConnectivityResult.none;
    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        Positioned(
          left: 0.0,
          right: 0.0,
          height: 32.0,
          child: AnimatedContainer(
            height: 40,
            duration: const Duration(milliseconds: 300),
            color: connected ? Colors.green : Colors.red,
            child: connected
                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "YOU ARE ONLINE",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "YOU ARE OFFLINE",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 8.0,
                ),
                SizedBox(
                  width: 12.0,
                  height: 12.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  },
  child: Center(
    child: Text("ONLINE Or OFFLINE Checking"),
  ),
);