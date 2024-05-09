import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_for_taksh/main.dart';
import 'package:game_for_taksh/pages/task_list.dart';
import 'package:url_launcher/url_launcher.dart';

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
                SystemSound.play(SystemSoundType.alert);
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
