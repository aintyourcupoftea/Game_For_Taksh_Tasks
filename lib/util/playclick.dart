import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class SoundUtil {
  static Future<void> playSound() async {
    final ByteData soundDataBytes =
        await rootBundle.load('lib/assets/sfx/click.wav');
    final Soundpool pool = Soundpool.fromOptions(); // Create Soundpool instance
    final int soundId = await pool.load(soundDataBytes); // Load the sound

    // Play the sound and get the streamId
    final int streamId =
        await pool.play(soundId); // Play the sound and get the streamId

    // Adjust the volume of the sound using the streamId
    pool.setVolume(
        streamId: streamId,
        volume: 0.5); // Adjust the volume here (value between 0.0 and 1.0)
  }
}
