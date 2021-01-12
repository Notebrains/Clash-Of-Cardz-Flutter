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

String getFirstWordFromText(String txt)
{
  return (txt+" ").split(" ")[0]; //add " " to string to be sure there is something to split
}
