
import 'package:flutter/material.dart';
import 'package:clash_of_cardz_flutter/ui/screens/old_screen/old_home.dart';

// how to use it: Navigator.push(context, _pageRouteBuilder());
PageRouteBuilder _pageRouteBuilder() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return OldHomeScreen();
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // return SlideTransition(
      //   position: animation.drive(
      //     Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset.zero),
      //   ),
      //   child: SlideTransition(
      //     position: Tween<Offset>(
      //       begin: Offset.zero,
      //       end: Offset(0.0, 1.0),
      //     ).animate(secondaryAnimation),
      //     child: child,
      //   ),
      // );
      // return ScaleTransition(
      //   scale: animation.drive(
      //     Tween<double>(begin: 0.0, end: 1.0).chain(
      //       CurveTween(
      //         curve: Interval(0.0, 0.5, curve: Curves.elasticIn),
      //       ),
      //     ),
      //   ),
      //   child: ScaleTransition(
      //     scale: Tween<double>(begin: 1.5, end: 1.0).animate(
      //       CurvedAnimation(
      //         parent: animation,
      //         curve: Interval(0.5, 1.0, curve: Curves.elasticInOut),
      //       ),
      //     ),
      //     child: child,
      //   ),
      // );
      return ScaleTransition(
        scale: CurvedAnimation(parent: animation, curve: Curves.elasticInOut),
        child: child,
      );
    },
    transitionDuration: const Duration(seconds: 1),
  );
}