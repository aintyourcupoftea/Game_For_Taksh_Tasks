import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '/util/playclick.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse('https://www.khojcommunity.com/about-1');

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
                fontFamily: "Merriweather",
              ),
            ),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                SoundUtil.playSound();
                Navigator.pushNamed(context, "/start");
              },
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Begin',
                        style: TextStyle(fontFamily: "FMBolyarPro"),
                      ),
                      Icon(Icons.play_arrow_rounded),
                    ],
                  )),
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
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Merriweather",
                  fontWeight: FontWeight.w400),
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
