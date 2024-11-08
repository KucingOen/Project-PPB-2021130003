import 'package:flutter/material.dart';
import 'package:task_manager/auth_service.dart';
import 'package:task_manager/const/app_color.dart';
import 'package:task_manager/features/reminder/reminder_settings.dart';
import 'package:task_manager/features/schedule/schedule_list.dart';
import 'package:task_manager/features/task/add_new_task.dart';

import 'data/preferences_service.dart';
import 'features/task/task_list.dart';

class DashboardPage extends StatefulWidget {
  /*final String username;
  final String email;
  const DashboardPage({super.key, required this.username, required this.email});*/
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkPrimaryColor,
        title: const Text('Dashboard'),
        //  automaticallyImplyLeading: false, // Disable the back button
      ),
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Info Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // Profile picture
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('images/ic_profile.png'),
                    ),
                    const SizedBox(width: 20),
                    // User name and email
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // 'Hi, ${widget.username}!',
                          'Hi, ${PreferencesService.getString("currentUserFullName")}!',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        InkWell(
                          onTap: () {
                            AuthService().signOutUser(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text("Logout"),
                          ),
                        )

                        /*Text(
                          PreferencesService.getString("currentUserEmail"),
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),*/
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Grid of Options
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: [
                    buildOptionCard(
                        icon: Icons.calendar_month_rounded,
                        title: 'Schedule',
                        color: Colors.purple[100],
                        onTap: () {
                          // Navigate to schedule list page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ScheduleListPage()),
                          );
                        }),
                    buildOptionCard(
                        icon: Icons.view_list_rounded,
                        title: 'All Tasks',
                        color: Colors.blue[100],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TaskListPage()),
                          );
                        }),
                    buildOptionCard(
                        icon: Icons.add_task_rounded,
                        title: 'Add New Task',
                        color: Colors.pink[100],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddNewTaskPage(
                                      isEditTask: false,
                                    )),
                          );
                        }),
                    buildOptionCard(
                        icon: Icons.circle_notifications_rounded,
                        title: 'Reminder Settings',
                        color: Colors.purple[200],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ReminderSettingsPage()),
                          );
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build option cards
  Widget buildOptionCard(
      {required IconData icon,
      required String title,
      required Color? color,
      required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Circular icon container
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 30,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            // Text below icon
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
