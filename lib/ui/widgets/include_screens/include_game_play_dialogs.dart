
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';

void showWrongSelectionDialog(BuildContext context, String selectedAttrName) {
  BuildContext dialogContext;
  showDialog(
    context: context,
    barrierDismissible: true,
    useSafeArea: true,
    builder: (BuildContext context) {
      dialogContext = context;
      return Dialog(
        backgroundColor: Colors.transparent,
        child: FadeInUp(
          child: Column(
            children: [
              Center(
                child: Lottie.asset('assets/animations/lottiefiles/cries.json',
                    width: getScreenWidth(context),
                    height: getScreenHeight(context) * 0.7,
                    repeat: true,
                    animate: true),
              ),

              Expanded(
                child: Text(
                  'Please select attribute $selectedAttrName',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'neuropol_x_rg',
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          preferences: AnimationPreferences(duration: const Duration(milliseconds: 300), autoPlay: AnimationPlayStates.Forward),
        ),
      );
    },
  );


  Timer(Duration(milliseconds: 1000), () {
    Navigator.pop(dialogContext);
  });
}