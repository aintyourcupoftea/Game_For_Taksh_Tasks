import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:soundpool/soundpool.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse('https://www.khojcommunity.com/about-1');

    Future<void> _playSound() async {
      final ByteData soundDataBytes =
          await rootBundle.load('lib/assets/sfx/click.wav');
      final Soundpool pool =
          Soundpool.fromOptions(); // Create Soundpool instance
      final int soundId = await pool.load(soundDataBytes); // Load the sound

      // Play the sound and get the streamId
      final int streamId =
          await pool.play(soundId); // Play the sound and get the streamId

      // Adjust the volume of the sound using the streamId
      pool.setVolume(
          streamId: streamId,
          volume: 0.5); // Adjust the volume here (value between 0.0 and 1.0)
    }

    Future<void> onLaunchUrl() async {
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Project: Exploring LocalSend",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                _playSound();
                Navigator.pushNamed(context, "/task_list");
              },
              child: Text('Get Started'),
              color: Colors.black,
              textColor: Colors.white,
              hoverElevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Made with ❤️ by ',
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => onLaunchUrl(),
                  text: 'Taksh',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: "FMBolyarPro"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
