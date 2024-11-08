import 'package:flutter/material.dart';
import 'package:task_manager/models/task.dart';

import '../../const/app_color.dart';
import 'add_new_task.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  // Dummy list of tasks
  /* List<Map<String, String>> tasks = [
    {"title": "Task 1", "dueDate": "Tue, 23 10:00pm"},
    {"title": "Task 2", "dueDate": "Wed, 24 8:45am"},
    {"title": "Task 3", "dueDate": "Fri, 26 12:00pm"},
    {"title": "Task 4", "dueDate": "Sun, 27 10:00am"},
  ];*/

  List<Task> dummyTasks = [
    Task(
        title: "Task 1",
        dateReminder: "2024/11/03",
        timeReminder: "08.00",
        note: "Ngoding"),
    Task(
        title: "Task 2",
        dateReminder: "2024/11/04",
        timeReminder: "09.00",
        note: "Ngoding Huhu"),
    Task(
        title: "Task 3",
        dateReminder: "2024/11/05",
        timeReminder: "10.00",
        note: "Ngoding Hehe"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkPrimaryColor,
        title: const Text('Tasks'),
      ),
      backgroundColor: whiteColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the Home page
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AddNewTaskPage(isEditTask: false)),
          );
        },
        backgroundColor: darkPrimaryColor,
        child: const Icon(Icons.add, size: 30),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dummyTasks.length,
        itemBuilder: (context, index) {
          return buildTaskCard(dummyTasks[index]);
        },
      ),
    );
  }

  Widget buildTaskCard(Task task) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Due: ${task.dateReminder} ${task.timeReminder}',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            /*Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.brown[900]),
                  onPressed: () {
                    // Edit task logic here
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddNewTaskPage(isEditTask: true,)),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.brown[900]),
                  onPressed: () {
                    // Delete task logic here
                  },
                ),
              ],
            ),*/
          ],
        ),
      ),
    );
  }
}
