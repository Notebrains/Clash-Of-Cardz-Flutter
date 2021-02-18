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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/libraries/flutter_toast.dart';

import '../shared_preference_data.dart';

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

Widget showToastWithReturnWidget(BuildContext context, String message){
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

  return SizedBox.shrink();
}

void onTapAudio(String audioType) async{
  SharedPreferenceHelper().getSfxOnOffState().then((isSFXOn) {
    if (isSFXOn) {
     /* //AudioPlayer instance;
      AudioCache audioCache = AudioCache(prefix: "assets/audios/", fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));
      switch(audioType) {
        case "click": {audioCache.play("Mouse-Click-03-c-FesliyanStudios.com.mp3");}
        break;

        case "button": {audioCache.play("sfx-bat+hit+ball.mp3");}
        break;

        case "icon": {audioCache.play('button-33a.mp3'); }
        break;

        case "pvp_screen": {audioCache.play('sword_sms.mp3');}
        break;

        case "match_win": { audioCache.play('Ball+Hit+Cheer.mp3'); }
        break;

        case "match_lost": { audioCache.play('sfx-crowd-groan.mp3');  }
        break;

        case "game_win": { audioCache.play('Ball+Hit+Cheer.mp3'); }
        break;

        case "game_lost": { audioCache.play('sfx-boo2.mp3'); }
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
          audioCache.play('sfx-caughtball.mp3'); }
        break;
      }*/
    }
  });
}
