import 'package:flutter/material.dart';
import 'package:game_for_taksh/pages/splash_screen.dart';
import 'pages/task_list.dart';

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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/task_list': (context) => TaskListScreen(),
      },
      home: SplashScreen(),
    );
  }
}
