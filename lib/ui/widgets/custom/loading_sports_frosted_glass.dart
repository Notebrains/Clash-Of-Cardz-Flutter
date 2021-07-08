import 'dart:ui';
import 'package:clash_of_cardz_flutter/ui/styles/size_config.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Center frostedGlassWithProgressBarWidget(BuildContext context) => Center(
      child: Stack(
        children: <Widget>[
          ConstrainedBox(
            constraints: const BoxConstraints.expand(),
          ),
          Center(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF405B6F),
                  ),
                  child: Center(
                    child: Lottie.asset('assets/animations/lottiefiles/sports-loading.json',
                        height: SizeConfig.heightMultiplier * 32, width: SizeConfig.heightMultiplier * 32, repeat: true, animate: true),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
