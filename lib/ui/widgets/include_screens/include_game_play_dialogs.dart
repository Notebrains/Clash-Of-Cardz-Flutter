
import 'dart:async';

import 'package:clash_of_cardz_flutter/ui/widgets/libraries/giffy_dialog/giffy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:clash_of_cardz_flutter/helper/exten_fun/base_application_fun.dart';
import 'package:clash_of_cardz_flutter/model/state_managements/gameplay_states_model.dart';


Widget gamePlayTimerUi(BuildContext context, {
Function(bool isTimeEnded) onTimeEnd,
}){
  return Container(
    height: getScreenHeight(context) / 6.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0.0, top: 0),
          child: TweenAnimationBuilder<Duration>(
              duration: Duration(minutes: 33),
              tween: Tween(begin: Duration(minutes: 33), end: Duration.zero),
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
                      preferences: AnimationPreferences(
                          duration: const Duration(milliseconds: 1500),
                          autoPlay: AnimationPlayStates.Forward),
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
                      preferences: AnimationPreferences(
                          duration: const Duration(milliseconds: 1500),
                          autoPlay: AnimationPlayStates.Forward),
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
                      preferences: AnimationPreferences(
                          duration: const Duration(milliseconds: 1500),
                          autoPlay: AnimationPlayStates.Forward),
                    ),
                  ],
                );
              }),
        ),
      ],
    ),
  );
}

BuildContext showTimesUpIncludeDialog(BuildContext context) {
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
          child: Center(
            child: Lottie.asset('assets/animations/lottiefiles/times-up.json', height: 290, width: 290, repeat: false, animate: true),
          ),
          preferences: AnimationPreferences(duration: const Duration(milliseconds: 800), autoPlay: AnimationPlayStates.Forward),
        ),
      );
    },
  );

  return dialogContext;
}


BuildContext showWinLossIncludeDialog(BuildContext context, bool isWon, String lottieFileName, String message,
    String photoUrl, int animHideTime) {
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
                child:
                Lottie.asset('assets/animations/lottiefiles/$lottieFileName', height: 290, width: 290, repeat: false, animate: true),
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


void showExitDialog(BuildContext context, {
  Function() onPressed,
}) {
  showDialog(
    //barrierColor: Color(0xEB20313E),
    context: context,
    builder: (_) => AssetGiffyDialog(
      image: Image.asset('assets/animations/gifs/surrender.gif'),
      title: Text(
        'SURRENDER',
        style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w800, fontFamily: 'montserrat', color: Color(0xFF263A47)),
      ),
      description: Text(
        'Do you really want to surrender! \n You will loose some points you are about to win.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, fontFamily: 'montserrat'),
      ),
      entryAnimation: EntryAnimation.TOP,
      buttonOkText: Text(
        'YES',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'montserrat'),
      ),
      buttonOkColor: Color(0xFF263A47),
      buttonCancelColor: Color(0xFF3A5A71),
      buttonCancelText: Text(
        'NO',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'montserrat'),
      ),
      onOkButtonPressed: () {
        onPressed();
        //SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      },
    ),
  );
}