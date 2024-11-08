import 'package:flutter/material.dart';
import 'package:task_manager/const/app_color.dart';
import 'package:task_manager/models/schedule.dart';
import 'package:task_manager/user_db_service.dart';

import 'add_new_course.dart';

class ScheduleListPage extends StatefulWidget {
  const ScheduleListPage({super.key});

  @override
  State<ScheduleListPage> createState() => _ScheduleListPageState();
}

class _ScheduleListPageState extends State<ScheduleListPage> {
  final List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday"
  ];

  List<Schedule> dummySchedule = [
    Schedule(
        namaMatkul: 'Pemrograman Dasar',
        hari: 1,
        jamMulai: '09.00',
        jamSelesai: '10.30',
        kelas: 'A',
        ruang: 'E535',
        dosen: 'Tukiyem'),
    Schedule(
        namaMatkul: 'Pemrograman Lanjut',
        hari: 1,
        jamMulai: '09.00',
        jamSelesai: '10.30',
        kelas: 'A',
        ruang: 'E535',
        dosen: 'Tukiyem'),
    Schedule(
        namaMatkul: 'Pemrograman Mahir',
        hari: 2,
        jamMulai: '09.00',
        jamSelesai: '10.30',
        kelas: 'A',
        ruang: 'E535',
        dosen: 'Suminem'),
    Schedule(
        namaMatkul: 'Struktur Data',
        hari: 3,
        jamMulai: '09.00',
        jamSelesai: '10.30',
        kelas: 'A',
        ruang: 'E535',
        dosen: 'Tukiyem'),
    Schedule(
        namaMatkul: 'Pemrograman Dasar',
        hari: 4,
        jamMulai: '09.00',
        jamSelesai: '10.30',
        kelas: 'A',
        ruang: 'E535',
        dosen: 'Suminem'),
    Schedule(
        namaMatkul: 'Pemrograman Dasar',
        hari: 1,
        jamMulai: '09.00',
        jamSelesai: '10.30',
        kelas: 'A',
        ruang: 'E535',
        dosen: 'Tukiyem'),
    Schedule(
        namaMatkul: 'Pemrograman Lanjut',
        hari: 1,
        jamMulai: '09.00',
        jamSelesai: '10.30',
        kelas: 'A',
        ruang: 'E535',
        dosen: 'Tukiyem'),
    Schedule(
        namaMatkul: 'Pemrograman Mahir',
        hari: 2,
        jamMulai: '09.00',
        jamSelesai: '10.30',
        kelas: 'A',
        ruang: 'E535',
        dosen: 'Suminem'),
    Schedule(
        namaMatkul: 'Struktur Data',
        hari: 3,
        jamMulai: '09.00',
        jamSelesai: '10.30',
        kelas: 'A',
        ruang: 'E535',
        dosen: 'Tukiyem'),
    Schedule(
        namaMatkul: 'Pemrograman Dasar',
        hari: 4,
        jamMulai: '09.00',
        jamSelesai: '10.30',
        kelas: 'A',
        ruang: 'E535',
        dosen: 'Suminem'),
  ];
  List<Schedule> allCourses = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await UserDbService().getAllCourses();
    setState(() {
      allCourses = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: darkPrimaryColor,
          title: const Text('Schedule'),
        ),
        backgroundColor: whiteColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigate to the Home page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddNewCoursePage()),
            );
          },
          backgroundColor: darkPrimaryColor,
          child: const Icon(Icons.add, size: 30),
        ),
        body: ListView.builder(
          itemCount: allCourses.length,
          itemBuilder: (context, index) {
            return buildScheduleCard(allCourses[index]);
          },
        ));
  }

  Widget buildScheduleCard(Schedule item) {
    return Card(
      color: backgroundColor, // Dark card background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subject Name
            Text(
              item.namaMatkul,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryTextColor,
              ),
            ),
            const SizedBox(height: 8),
            // Time, Class, Room Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Time and Class
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${getDayByIndex(item.hari)}, ${item.jamMulai} - ${item.jamSelesai}',
                      style: TextStyle(
                        fontSize: 14,
                        color: secondaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Kelas: ${item.kelas}',
                      style: TextStyle(
                        fontSize: 14,
                        color: secondaryTextColor,
                      ),
                    ),
                  ],
                ),
                // Room Icon and Room Number
                Row(
                  children: [
                    Icon(
                      Icons.room_rounded,
                      color: accentColor,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      item.ruang,
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Professor Name
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: darkPrimaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  item.dosen,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getDayByIndex(int dayIndex) {
    return days[dayIndex];
  }
}
