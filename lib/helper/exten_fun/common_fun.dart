/*import 'package:assets_audio_player/assets_audio_player.dart';

void playAssetAudio(String audioName) {
  final assetsAudioPlayer = AssetsAudioPlayer();
  assetsAudioPlayer.open(
    Audio("assets/audios/$audioName"),
  );
}

playUrlAudio(String url) async {
  try {
    final assetsAudioPlayer = AssetsAudioPlayer();
    await assetsAudioPlayer.open(
      Audio.network(url),
    );
  } catch (t) {
//mp3 unreachable
  }
}*/

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/flutter_toast.dart';

import '../shared_preference_data.dart';

String convertStrToDoubleStr(String value) => value.isNotEmpty ? double.parse(value).toStringAsFixed(2).toString() : '0';

String getFirstWordFromText(String txt) {
  return (txt + " ").split(" ")[0]; //add " " to string to be sure there is something to split
}

void showToast(BuildContext context, String message) {
  Toast.show(message, context,
      duration: Toast.lengthLong,
      gravity: Toast.bottom,
      backgroundColor: Colors.black87.withOpacity(0.5),
      textStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 14,
        fontFamily: 'montserrat',
        shadows: [
          Shadow(color: Colors.white),
        ],
      ));
}

String getRandomBgImgFromAsset() {
  var list = [
    'assets/images/bg_img13.png',
    'assets/images/bg_img12.png',
    'assets/images/bg_img6.png',
    'assets/images/bg_img3.png',
    'assets/images/bg_img11.png',
    'assets/images/bg_img7.png',
    'assets/images/bg_img8.png',
  ];
  // generate a random index based on the list length
  // and use it to retrieve the element
  return list[Random().nextInt(list.length)];;
}

Widget showToastWithReturnWidget(BuildContext context, String message) {
  Toast.show(message, context,
      duration: Toast.lengthLong,
      gravity: Toast.bottom,
      backgroundColor: Colors.black87.withOpacity(0.5),
      textStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
        fontFamily: 'montserrat',
        shadows: [
          Shadow(color: Colors.white),
        ],
      ));

  return SizedBox.shrink();
}

void onTapAudio(String audioType) async {
  SharedPreferenceHelper().getSfxOnOffState().then((isSFXOn) {
    if (isSFXOn) {
      /* //AudioPlayer instance;
      AudioCache audioCache = AudioCache(prefix: "assets/audios/", fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));
      switch(audioType) {
        case "click": {audioCache.play("");}
        break;

        case "button": {audioCache.play("");}
        break;

        case "icon": {audioCache.play(''); }
        break;

        case "pvp_screen": {audioCache.play('');}
        break;

        case "match_win": { audioCache.play(''); }
        break;

        case "match_lost": { audioCache.play('');  }
        break;

        case "game_win": { audioCache.play(''); }
        break;

        case "game_lost": { audioCache.play(''); }
        break;

        case "a": { }
        break;

        case "a": { }
        break;

        case "a": { }
        break;

        case "a": { }
        break;

        case "a": { }
        break;

        case "a": { }
        break;

        default: {
          audioCache.play(''); }
        break;
      }*/
    }
  });
}