import 'package:flutter/material.dart';
import 'package:task_manager/const/app_color.dart';
import 'package:task_manager/models/schedule.dart';

import '../../user_db_service.dart';

class AddNewCoursePage extends StatefulWidget {
  const AddNewCoursePage({super.key});

  @override
  State<AddNewCoursePage> createState() => _AddNewCoursePageState();
}

class _AddNewCoursePageState extends State<AddNewCoursePage> {
  String dropdownValue = 'Monday';
  int selectedDayIndex = 0;
  // List of dropdown items
  final List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday"
  ];

  final _formKey = GlobalKey<FormState>();
  TextEditingController courseNameController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController lecturerController = TextEditingController();

  TimeOfDay _selectedStartTime =
      const TimeOfDay(hour: 6, minute: 0); // Default to current time
  TimeOfDay _selectedEndTime =
      const TimeOfDay(hour: 6, minute: 0); // Default to current time

  // Function to show the time picker
  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime:
          _selectedStartTime, // Set the initial time to the current time
    );
    if (picked != null && picked != _selectedStartTime) {
      setState(() {
        _selectedStartTime = picked; // Update the selected time
      });
    }
  }

  // Function to show the time picker
  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedEndTime, // Set the initial time to the current time
    );
    if (picked != null && picked != _selectedEndTime) {
      setState(() {
        _selectedEndTime = picked; // Update the selected time
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: darkPrimaryColor,
          title: const Text('Add New Course'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: courseNameController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Course Name"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter course name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: Row(
                        children: [
                          const Text('Day :'),
                          const SizedBox(width: 20),
                          spinnerDay()
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: datePicker(isStartTime: true)),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: datePicker(isStartTime: false)),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: classController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: "Class"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter class';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: roomController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: "Room"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter room number';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: lecturerController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Lecturer"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter lecturer';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16.0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              Schedule schedule = Schedule(
                                  namaMatkul: courseNameController.text,
                                  hari: selectedDayIndex,
                                  jamMulai:
                                      "${_selectedStartTime.hour}.${_selectedStartTime.minute}",
                                  jamSelesai:
                                      "${_selectedEndTime.hour}.${_selectedEndTime.minute}",
                                  kelas: classController.text,
                                  ruang: roomController.text,
                                  dosen: lecturerController.text);

                              final message = await UserDbService()
                                  .addNewCourse(newSchedule: schedule);

                              if (message.contains('Success')) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Berhasil menyimpan data')),
                                );
                                // Success & Navigate back to schedule list page
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(message)),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please fill input')),
                              );
                            }
                          },
                          child: const Text('Save'),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }

  Widget spinnerDay() {
    return DropdownButtonHideUnderline(
        child: DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down_rounded),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      items: days.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          selectedDayIndex = days.indexOf(newValue);
        });
      },
    ));
  }

  Widget datePicker({required bool isStartTime}) {
    String dropdownValue;
    TimeOfDay selectedTime;
    if (isStartTime) {
      dropdownValue = 'Start Time';
      selectedTime = _selectedStartTime;
    } else {
      dropdownValue = 'End Time';
      selectedTime = _selectedEndTime;
    }

    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Text(
        "$dropdownValue :   ${selectedTime.format(context)}",
        // Show the selected time
        style: const TextStyle(fontSize: 14),
      ),
      const SizedBox(width: 20),
      ElevatedButton(
        onPressed: () => {
          if (isStartTime)
            {_selectStartTime(context)}
          else
            {_selectEndTime(context)}
        },
        // Show time picker on button press
        child: const Text('Pick Time'),
      ),
    ]);
  }
}
