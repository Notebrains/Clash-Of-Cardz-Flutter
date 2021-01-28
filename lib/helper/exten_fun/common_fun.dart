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

import 'package:flutter/material.dart';
import 'package:trump_card_game/ui/widgets/libraries/flutter_toast.dart';

String getFirstWordFromText(String txt)
{
  return (txt+" ").split(" ")[0]; //add " " to string to be sure there is something to split
}

void showToast(BuildContext context, String message){
  Toast.show(message, context, duration: Toast.lengthLong, gravity:  Toast.bottom,
      backgroundColor: Colors.black87.withOpacity(0.5),
      textStyle:  TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
        fontFamily: 'montserrat',
        shadows: [
          Shadow(color: Colors.white),
        ],
      ));
}
