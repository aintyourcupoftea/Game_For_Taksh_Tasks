import 'package:audioplayers/audioplayers.dart';

class AudioUtil {
  static final player = AudioPlayer();

  static void playRizz() async {
    await player.play(DeviceFileSource('lib/assets/sfx/bg.mp3'));
    await player.setReleaseMode(ReleaseMode.loop);
    await player.setVolume(0.15);
  }

  static void muteRizz() {
    player.setVolume(0);
  }
}
