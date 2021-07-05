

import 'package:gapless_audio_loop/gapless_audio_loop.dart';

class Globals {
  static GaplessAudioLoop audioPlayerInstance;

  static GaplessAudioLoop getAudioPlayerInstance() {
    //print('isMusicOn : $isAudioOn');
    return audioPlayerInstance;
  }

  static setAudioPlayerInstance(GaplessAudioLoop instance) {
    audioPlayerInstance = instance;
    getAudioPlayerInstance(); // this can be replaced with any static method
  }
}
