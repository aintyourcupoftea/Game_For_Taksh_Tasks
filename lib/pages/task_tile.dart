import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TaskTile extends StatefulWidget {
  final int taskNumber;
  final String title;
  final List<String> instructions;
  final List<String>? codeSnippets; // Making codeSnippets nullable
  final ValueChanged<bool> onChanged;
  final bool isEnabled; // Flag to enable/disable the task

  TaskTile({
    required this.taskNumber,
    required this.title,
    required this.instructions,
    this.codeSnippets,
    required this.onChanged,
    required this.isEnabled,
  });

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              '${widget.taskNumber}. ${widget.title}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              if (widget.isEnabled) {
                setState(() {
                  isChecked = !isChecked;
                  widget.onChanged(isChecked);
                });
              }
            },
            trailing: Checkbox(
              value: isChecked,
              onChanged: (value) {
                if (widget.isEnabled) {
                  setState(() {
                    isChecked = value!;
                    widget.onChanged(value);
                  });
                }
              },
            ),
          ),
          if (isChecked)
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Instructions:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  for (String instruction in widget.instructions)
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                      child: Text('- $instruction'),
                    ),
                  SizedBox(height: 16),
                  if (widget.codeSnippets != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Code Snippets:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        for (String codeSnippet in widget.codeSnippets!)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              padding: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SelectableText(
                                      codeSnippet,
                                      style:
                                          TextStyle(fontFamily: 'RobotoMono'),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.content_copy),
                                    onPressed: () {
                                      Clipboard.setData(
                                          ClipboardData(text: codeSnippet));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Code copied to clipboard')));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
