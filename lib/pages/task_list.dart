import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'task_tile.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<bool> taskStatus =
      List.filled(3, false); // List to track checked status of tasks
  int score = 0;
  int fullScore = 3; // Add a variable to track the full score

  void _updateScore(bool isChecked, int index) {
    setState(() {
      // Update the checked status of the task
      taskStatus[index] = isChecked;
      // Recalculate the score based on the updated taskStatus list
      score = taskStatus.where((status) => status).length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Taksh Task List'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                TaskTile(
                  taskNumber: 1,
                  title: 'Task 1',
                  instructions: ['Do XYZ', 'Do ABC'],
                  onChanged: (isChecked) =>
                      _updateScore(isChecked, 0), // Update score for task 1
                  codeSnippets: ["cd clone"],
                  isEnabled: true, // First task is always enabled
                ),
                TaskTile(
                  taskNumber: 2,
                  title: 'Task 2',
                  instructions: ['Do XYZ', 'Do ABC'],
                  onChanged: (isChecked) =>
                      _updateScore(isChecked, 1), // Update score for task 2
                  codeSnippets: ["cd clone"],
                  isEnabled:
                      taskStatus[0], // Enable task 2 only if task 1 is checked
                ),
                TaskTile(
                  taskNumber: 3,
                  title: 'Task 3',
                  instructions: ['Do XYZ', 'Do ABC'],
                  onChanged: (isChecked) =>
                      _updateScore(isChecked, 2), // Update score for task 3
                  codeSnippets: ["cd clone"],
                  isEnabled:
                      taskStatus[1], // Enable task 3 only if task 2 is checked
                ),
                // Add more TaskTiles as needed
              ],
            ),
          ),
          if (score > 0) // Show message only if score is greater than 0
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _getMessage(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Score: $score/$fullScore', // Displaying score as "Score: x/y"
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }

  String _getMessage() {
    double percentage = score / fullScore * 100;
    if (percentage >= 100) {
      return "You're a rockstar!";
    } else if (percentage >= 90) {
      return "Wonderful! Keep it up!";
    } else if (percentage >= 70) {
      return "Yes, keep going! You're doing wonderful!";
    } else if (percentage >= 30) {
      return "You can do it! Keep pushing!";
    } else {
      return ""; // Empty message if score is below 30%
    }
  }
}
