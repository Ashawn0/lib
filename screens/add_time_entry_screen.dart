import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/models/time_entry.dart';
import 'package:time_tracker_app/providers/time_entry_provider.dart';

class AddTimeEntryScreen extends StatefulWidget {
  @override
  _AddTimeEntryScreenState createState() => _AddTimeEntryScreenState();
}

class _AddTimeEntryScreenState extends State<AddTimeEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  String projectId = 'Project 1';
  String taskId = 'Task 1';
  double totalTime = 0.0;
  DateTime date = DateTime.now();
  String notes = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Time Entry'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            DropdownButtonFormField<String>(
              value: projectId,
              onChanged: (newValue) => setState(() => projectId = newValue!),
              items: ['Project 1', 'Project 2', 'Project 3']
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              decoration: InputDecoration(labelText: 'Project'),
            ),
            DropdownButtonFormField<String>(
              value: taskId,
              onChanged: (newValue) => setState(() => taskId = newValue!),
              items: ['Task 1', 'Task 2', 'Task 3']
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              decoration: InputDecoration(labelText: 'Task'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Total Time (hours)'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (value) =>
                  value == null || double.tryParse(value) == null ? 'Invalid input' : null,
              onSaved: (value) => totalTime = double.parse(value!),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Notes'),
              onSaved: (value) => notes = value ?? '',
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Provider.of<TimeEntryProvider>(context, listen: false).addTimeEntry(TimeEntry(
                    id: DateTime.now().toString(),
                    projectId: projectId,
                    taskId: taskId,
                    totalTime: totalTime,
                    date: date,
                    notes: notes,
                  ));
                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}