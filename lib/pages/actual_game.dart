import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '/util/playclick.dart';
import '/util/playrizz.dart';

class ActualGame extends StatefulWidget {
  ActualGame({Key? key}) : super(key: key);

  @override
  State<ActualGame> createState() => _ActualGameState();
}

class _ActualGameState extends State<ActualGame> {
  bool isChecked = false;
  bool isExpanded = false;
  bool isMuted = false;
  int score = 0;
  int totalScore = 5;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      AudioUtil.playRizz();
      print(score);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          child: Center(
            child: Text(
              "Score: $score/$totalScore",
              style: TextStyle(
                fontFamily: "Merriweather",
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.black),
          height: 80,
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            AudioUtil.muteRizz();
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: isMuted ? Icon(Icons.music_note) : Icon(Icons.music_off),
            onPressed: () {
              if (isMuted) {
                isMuted = false;
                SoundUtil.playSound();
                AudioUtil.playRizz();
              } else {
                isMuted = true;
                AudioUtil.muteRizz();
              }
              setState(() {});
            },
          )
        ],
        title:
            Text('Instructions', style: TextStyle(fontFamily: "FMBolyarPro")),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          elevation: isExpanded ? 0 : 10,
          color: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          child: ExpansionTile(
            trailing: Checkbox(
              activeColor: Colors.lightGreen,
              checkColor: Colors.black,
              visualDensity: VisualDensity.compact,
              value: isChecked,
              onChanged: (bool? value) {
                if (!isMuted) {
                  SoundUtil.playSound();
                }
                if (isChecked == true) {
                  score--;
                  print(score);
                }
                if (isChecked == false) {
                  score++;
                  print(score);
                }
                setState(() {
                  isChecked = !isChecked;
                });
              },
            ),
            leading: isExpanded
                ? Icon(Icons.expand_less_rounded, color: Colors.white)
                : Icon(Icons.expand_more_rounded, color: Colors.white),
// Icon indicating expansion
            shape: const Border(),
            collapsedBackgroundColor: Colors.black,
            tilePadding: EdgeInsets.all(12),
            onExpansionChanged: (value) {
              setState(() {
                isExpanded = value;
              });
            },
            title: Text(
              "Step 1: Download LocalSend",
              style: TextStyle(fontFamily: "Merriweather", color: Colors.white),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    Text(
                      "How to download:",
                      style: TextStyle(
                        fontFamily: "Merriweather",
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: "Merriweather",
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: "Head to ",
                          ),
                          TextSpan(
                            text: "LocalSend.org",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                _launchURL('https://LocalSend.org/download');
                              },
                          ),
                          TextSpan(
                            text:
                                " to download the app for both sending and receiving devices.",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
