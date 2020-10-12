import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vector_math/vector_math.dart' show radians, Vector3;

class SemiCircleMenu extends StatefulWidget {
  SemiCircleMenu({
    Key key,
  }) : super(key: key);

  @override
  _HomewidgettoslackState createState() => _HomewidgettoslackState();
}

class _HomewidgettoslackState extends State<SemiCircleMenu>
    with TickerProviderStateMixin {
  Animation<double> rotation;
  Animation<double> translationY;
  Animation<double> translationX;
  Animation<double> menuscale;
  AnimationController menuController;

  double _menuIconSize;

  @override
  void initState() {
    super.initState();
    menuController =
        AnimationController(duration: Duration(milliseconds: 900), vsync: this);
    rotation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: menuController,
        curve: Interval(
          0.0,
          0.7,
          curve: Curves.decelerate,
        ),
      ),
    );

    menuscale = Tween<double>(
      begin: 1.5,
      end: 0.0,
    ).animate(
      CurvedAnimation(parent: menuController, curve: Curves.fastOutSlowIn),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: false);
    _menuIconSize = ScreenUtil().setWidth(60);
    double _bigCurveHeight = ScreenUtil().setHeight(520);
    double _bigCurveWidth = ScreenUtil().setWidth(250);

    translationY = Tween<double>(
      begin: 0.0,
      end: ((_bigCurveHeight / 2) - (_menuIconSize / 2)),
    ).animate(
      CurvedAnimation(parent: menuController, curve: Curves.elasticOut),
    );

    translationX = Tween<double>(
      begin: 0.0,
      end: (_bigCurveWidth - (_menuIconSize / 2)),
    ).animate(
      CurvedAnimation(parent: menuController, curve: Curves.elasticOut),
    );

    return Container(
      color: Colors.blueGrey,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.centerLeft,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              Container(
                height: _bigCurveHeight,
                width: _bigCurveWidth,
                child: CustomPaint(
                  painter: CurvedblacklinePainter(strokeWidth: 2),
                ),
              ),
              Container(
                height: ScreenUtil().setHeight(350),
                width: ScreenUtil().setWidth(130),
                child: CustomPaint(
                  painter: CurvedblacklinePainter(
                      strokeWidth: ScreenUtil().setWidth(60)),
                ),
              ),
              Container(
                child: AnimatedBuilder(
                  animation: menuController,
                  builder: (context, widget) {
                    return Transform.rotate(
                      angle: radians(rotation.value),
                      child:
                      Stack(alignment: Alignment.center, children: <Widget>[
                        _buildButton(0,
                            color: Colors.red,
                            icon: FontAwesomeIcons.thumbtack),
                        _buildButton(45,
                            color: Colors.green,
                            icon: FontAwesomeIcons.sprayCan),
                        _buildButton(90,
                            color: Colors.orange, icon: FontAwesomeIcons.fire),
                        _buildButton(270,
                            color: Colors.pink, icon: FontAwesomeIcons.car),
                        _buildButton(315,
                            color: Colors.yellow, icon: FontAwesomeIcons.bolt),
                        _buildButton(425,
                            color: Colors.yellow, icon: FontAwesomeIcons.bolt),
                        _buildButton(555,
                            color: Colors.yellow, icon: FontAwesomeIcons.bolt),
                        Transform.scale(
                          scale: menuscale.value - 1,
                          child: FloatingActionButton(
                              heroTag: null,
                              child: Icon(FontAwesomeIcons.timesCircle),
                              onPressed: _close,
                              backgroundColor: Colors.red),
                        ),
                        Transform.scale(
                          scale: menuscale.value,
                          child: FloatingActionButton(
                              heroTag: null,
                              child: Icon(
                                FontAwesomeIcons.solidDotCircle,
                                color: Colors.red,
                              ),
                              onPressed: _open),
                        )
                      ]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildButton(double angle, {Color color, IconData icon}) {
    final double rad = radians(angle);
    return Transform(
        transform: Matrix4.identity()
          ..translate(
              (translationX.value) * cos(rad), (translationY.value) * sin(rad)),
        child: FloatingActionButton(
            heroTag: null,
            child: Icon(icon),
            backgroundColor: color,
            onPressed: _close,
            elevation: 0));
  }

  _open() {
    print('OPEN CLICKED');
    menuController.forward();
  }

  _close() {
    print('CLOSE CLICKED');
    menuController.reverse();
  }
}

class CurvedblacklinePainter extends CustomPainter {
  final double strokeWidth;

  CurvedblacklinePainter({@required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(-size.width / 2, size.height / 2),
            width: size.width * 3,
            height: size.height),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}