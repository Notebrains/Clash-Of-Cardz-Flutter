import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/services.dart';

void setDeviceOrientationToLandscape() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}

void playAssetAudio(String audioName) {
  final assetsAudioPlayer = AssetsAudioPlayer();
  assetsAudioPlayer.open(
    Audio("assets/audios/$audioName"),
  );
}

Future<void> playUrlAudio(String url) async {
  try {
    final assetsAudioPlayer = AssetsAudioPlayer();
    await assetsAudioPlayer.open(
      Audio.network(url),
    );
  } catch (t) {
//mp3 unreachable
  }
}
