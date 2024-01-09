import 'package:flutter/material.dart';
import 'package:sqlite_test/models/Task.dart';
import 'package:sqlite_test/services/sqlite_service.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

final _formKey = GlobalKey<FormState>();

class _AddTaskScreenState extends State<AddTaskScreen> {
  DateTime selectedDate = DateTime.now();

  DatabaseHelper? helper;
  String taskName = '';
  String description = '';

  // List<Map<String, dynamic>> data = [];

  // void getData() async {
  //   List<Map<String, dynamic>> userData = await DatabaseHelper.getSingleUser(int.parse(employeeId));
  //
  //   setState(() {
  //     data = userData;
  //   });
  // }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: ' Task Name', border: OutlineInputBorder()),
                    onSaved: (value) {
                      setState(() {
                        taskName = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Some value';
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text("${selectedDate.toLocal()}".split(' ')[0]),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: const Text('Select date'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text("${_selectedTime.format(context)}    "),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        onPressed: () => _selectTime(context),
                        child: const Text('Select Time'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLines: 3,
                    decoration: InputDecoration(
                        hintText: ' Description', border: OutlineInputBorder()),
                    onSaved: (value) {
                      setState(() {
                        description = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Some value';
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            _formKey.currentState!.save();
                            if (_formKey.currentState!.validate()) {
                              DatabaseHelper.insertUser(Task(
                                  taskName: taskName,
                                  date:selectedDate.toLocal().toString().split(' ')[0],
                                  time: _selectedTime.format(context).toString(),
                                  description: description));
      
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Task Added')));
                            }
                          },
                          child: Text('Submit')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context,Task(
                                taskName: taskName,
                                date:selectedDate.toLocal().toString().split(' ')[0],
                                time: _selectedTime.format(context).toString(),
                                description: description));
                          },
                          child: Text('Cancel')),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
