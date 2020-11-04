import 'package:flutter/material.dart';

import 'circle_wheel_scroll_view.dart';

class CustomScrollPhysics extends CircleFixedExtentScrollPhysics {
  const CustomScrollPhysics ({ScrollPhysics parent}) : super(parent: parent);

  @override
  double get minFlingVelocity => double.infinity;

  @override
  double get maxFlingVelocity => double.infinity;

  @override
  double get minFlingDistance => double.infinity;

  @override
  CustomScrollPhysics applyTo(ScrollPhysics ancestor) {
    return CustomScrollPhysics (parent: buildParent(ancestor));
  }
}