import 'dart:async';
import 'dart:ui';

import 'package:clash_of_cardz_flutter/ui/styles/size_config.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/outlined_btn_gradient_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/base_application_fun.dart';

Widget gamePlayTimerUi(
  BuildContext context, {
  Function(bool isTimeEnded) onTimeEnd,
}) {
  return Container(
    height: getScreenHeight(context) / 6.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0.0, top: 0),
          child: TweenAnimationBuilder<Duration>(
              duration: Duration(minutes: 5),
              tween: Tween(begin: Duration(minutes: 5), end: Duration.zero),
              onEnd: () {
                onTimeEnd(true);
              },
              builder: (BuildContext context, Duration value, Widget child) {
                //adding 0 at first if min or sec show in single digit
                final minutes = (value.inMinutes).toString().padLeft(2, "0");
                final seconds = (value.inSeconds % 60).toString().padLeft(2, "0");
                return Row(
                  children: [
                    SlideInLeft(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          width: 50,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFF263A47),
                            border: Border.all(
                              color: Color(0xFF263A47),
                              width: 5,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey[500],
                                blurRadius: 8.0,
                                offset: Offset(0.0, 8.0),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              '$minutes',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                shadows: [
                                  Shadow(color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      preferences:
                          AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                    ),
                    SlideInDown(
                      child: Container(
                        width: 20,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFF263A47),
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey[500],
                              blurRadius: 8.0,
                              offset: Offset(0.0, 8.0),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              ':',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 31,
                                shadows: [
                                  Shadow(color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      preferences:
                          AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                    ),
                    SlideInRight(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          width: 50,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFF263A47),
                            border: Border.all(
                              color: Color(0xFF263A47),
                              width: 5,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey[500],
                                blurRadius: 8.0,
                                offset: Offset(0.0, 8.0),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              '$seconds',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                shadows: [
                                  Shadow(color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      preferences:
                          AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
                    ),
                  ],
                );
              }),
        ),
      ],
    ),
  );
}

BuildContext showWinLossIncludeDialog(
    BuildContext context, bool isWon, String lottieFileName, String message, String photoUrl, int animHideTime) {
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
          child: Stack(
            children: <Widget>[
              Center(
                child: Lottie.asset('assets/animations/lottiefiles/$lottieFileName', height: 290, width: 290, repeat: false, animate: true),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: FadeInImage.assetNetwork(
                        placeholder: isWon ? 'assets/icons/png/circle-avator-default-img.png' : '',
                        image: photoUrl ?? '',
                        fit: BoxFit.fill,
                        width: 65,
                        height: 65,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        message,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 13,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'neuropol_x_rg',
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          preferences: AnimationPreferences(duration: const Duration(milliseconds: 800), autoPlay: AnimationPlayStates.Forward),
        ),
      );
    },
  );

  return dialogContext;
}

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
                    width: getScreenWidth(context), height: getScreenHeight(context) * 0.7, repeat: true, animate: true),
              ),
              Expanded(
                child: Text(
                  'Please select attribute $selectedAttrName',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'neuropol_x_rg', fontWeight: FontWeight.bold),
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

void showSurrenderDialog(BuildContext context, {Function() onOkTap}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    useSafeArea: true,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: ZoomIn(
          child: Center(
            child: Container(
              width: SizeConfig.widthMultiplier * 160,
              height: SizeConfig.heightMultiplier * 35,
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
                          decoration: BoxDecoration(color: Colors.grey.shade400.withOpacity(0.1)),
                          child: FadeInUp(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 40),
                                    child: Lottie.asset('assets/animations/lottiefiles/minion-surrender.json',
                                        width: getScreenWidth(context), height: getScreenHeight(context) * 0.6, repeat: true, animate: true),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'SURRENDER !',
                                        textAlign: TextAlign.center,
                                        style:
                                        TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'montserrat', fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 25),
                                        child: Text(
                                          'Do you really want to surrender! \n You will loose some points you are about to win.',
                                          textAlign: TextAlign.center,
                                          style:
                                          TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'montserrat', fontWeight: FontWeight.bold),
                                        ),
                                      ),


                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Pulse(
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 12, top: 40),
                                              child: OutlinedBtnGradientBorder(
                                                onPressed: () {
                                                  Navigator.pop(context);

                                                },
                                                height: 25,
                                                width: 100,
                                                child:  Text(
                                                  "CANCEL",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontStyle: FontStyle.normal,
                                                      fontFamily: 'montserrat',
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.blue.shade100),
                                                ),
                                              ),
                                            ),
                                            preferences:
                                            AnimationPreferences(duration: const Duration(milliseconds: 2500), autoPlay: AnimationPlayStates.Loop),
                                          ),
                                          Pulse(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 12, top: 40),
                                              child: OutlinedBtnGradientBorder(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  onOkTap();
                                                },
                                                height: 25,
                                                width: 100,
                                                child:  Text(
                                                  "YES",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontStyle: FontStyle.normal,
                                                      fontFamily: 'montserrat',
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.blue.shade100),
                                                ),
                                              ),
                                            ),
                                            preferences:
                                            AnimationPreferences(duration: const Duration(milliseconds: 2500), autoPlay: AnimationPlayStates.Loop),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            preferences:
                                AnimationPreferences(duration: const Duration(milliseconds: 300), autoPlay: AnimationPlayStates.Forward),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          preferences: AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
        ),
      );
    },
  );
}

void showGameExitDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    useSafeArea: true,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: ZoomIn(
          child: Center(
            child: Container(
              width: SizeConfig.widthMultiplier * 150,
              height: SizeConfig.heightMultiplier * 30,
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
                          decoration: BoxDecoration(color: Color(0xFF364B5A)),
                          child: FadeInUp(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(20),
                                    color: Colors.grey.shade200.withOpacity(0.1),
                                    child: Lottie.asset('assets/animations/lottiefiles/no-data-found-sad-face.json', repeat: true, animate: true),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Clash Of Cardz',
                                        textAlign: TextAlign.center,
                                        style:
                                        TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'montserrat', fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 25),
                                        child: Text(
                                          'Do you really want to exit the game?',
                                          textAlign: TextAlign.center,
                                          style:
                                          TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'montserrat', fontWeight: FontWeight.bold),
                                        ),
                                      ),


                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Pulse(
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 12, top: 40),
                                              child: OutlinedBtnGradientBorder(
                                                onPressed: () {
                                                  Navigator.pop(context);

                                                },
                                                height: 25,
                                                width: 100,
                                                child:  Text(
                                                  "Continue",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontStyle: FontStyle.normal,
                                                      fontFamily: 'montserrat',
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.blue.shade100),
                                                ),
                                              ),
                                            ),
                                            preferences:
                                            AnimationPreferences(duration: const Duration(milliseconds: 2500), autoPlay: AnimationPlayStates.Loop),
                                          ),
                                          Pulse(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 12, top: 40),
                                              child: OutlinedBtnGradientBorder(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
                                                },
                                                height: 25,
                                                width: 100,
                                                child:  Text(
                                                  "Quit",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontStyle: FontStyle.normal,
                                                      fontFamily: 'montserrat',
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.blue.shade100),
                                                ),
                                              ),
                                            ),
                                            preferences:
                                            AnimationPreferences(duration: const Duration(milliseconds: 2500), autoPlay: AnimationPlayStates.Loop),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            preferences:
                                AnimationPreferences(duration: const Duration(milliseconds: 300), autoPlay: AnimationPlayStates.Forward),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          preferences: AnimationPreferences(duration: const Duration(milliseconds: 1500), autoPlay: AnimationPlayStates.Forward),
        ),
      );
    },
  );
}
