import 'package:flutter/material.dart';
import 'package:game_for_taksh/pages/actual_game.dart';
import 'package:game_for_taksh/pages/splash_screen.dart';

void main() {
  runApp(TaskListApp());
}

class TaskListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taksh Project',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/start': (context) => ActualGame(),
      },
      home: SplashScreen(),
    );
  }
}
