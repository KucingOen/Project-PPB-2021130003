import 'package:firebase_database/firebase_database.dart';
import 'package:task_manager/models/schedule.dart';

import 'data/preferences_service.dart';
import 'models/task.dart';

class UserDbService {
  final databaseRef = FirebaseDatabase.instance.ref();

  String getUserUId() => PreferencesService.getString('currentUserUId');

  Future<bool> checkNodeUser() async {
   // final databaseRef = FirebaseDatabase.instance.ref();

    String userUId = getUserUId();
    final userRef = databaseRef.child('users').child(userUId);

    // Check if the node exists
    DataSnapshot snapshot = await userRef.get();

    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  /* Future<User> getCurrentUserData() async {
    try {
      final databaseRef = FirebaseDatabase.instance.ref();

      final userRef = databaseRef.child('users').child(userUid);

      // Check if the node exists
      DataSnapshot snapshot = await userRef.get();

      if (snapshot.exists) {
        // Node exists; retrieve child data
        String? fullName = snapshot.child('fullName').value as String?;
        await PreferencesService.saveString('currentUserUId', userUid);
        return 'Success.$fullName';
      } else {
        print("User does not exist.");
        throw Future.error({});
      }
    } catch(e) {
      print("Error getCurrentUserData() $e");
      rethrow;
    }
  }*/

  Future<String> addNewCourse({
    required Schedule newSchedule
  }) async {
    try {
      if(await checkNodeUser()) {
        String userUId = getUserUId();
        final userCoursesRef = databaseRef.child('users').child(userUId).child('courses');


       /* DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref('users/$userId');

        await userRef.set({"fullName": fullName, "email": email});*/



        // Define the data structure with sub-nodes
        Map<String, dynamic> newCourseData = newSchedule.toMap();

        // Add the new node under the existing parent node
        //await databaseRef.child(parentNode).child(newNodeId).set(newCourseData);
       // await userRef.set(newCourseData);

        // Use push() to add a new course to the list
        await userCoursesRef.push().set(newCourseData);
        return 'Success';
      } else {
        return 'Failed';
      }

    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Schedule>> getAllCourses() async {
    try {
      String userUId = getUserUId();
      final userCoursesRef = databaseRef.child('users').child(userUId).child('courses');

      final snapshot = await userCoursesRef.get();

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        print("data courses: $data");

        // Convert each entry to a Schedule model
        List<Schedule> coursesList = data.entries.map((entry) {
          return Schedule.fromMap(entry.value);
        }).toList();

        // Sort the list by the day field
        coursesList.sort((a, b) => a.hari.compareTo(b.hari));

        return coursesList;

      } else {
        // No data available
        return [];
      }

    } catch(e) {
      print(e.toString());
      return [];
    }
  }

  Future<String> addNewTask({
    required Task newTask
  }) async {
    try {
      if(await checkNodeUser()) {
        String userUId = getUserUId();
        final userTasksRef = databaseRef.child('users').child(userUId).child('tasks');

        // Define the data structure with sub-nodes
        Map<String, dynamic> newTaskData = newTask.toMap();
        await userTasksRef.push().set(newTaskData);
        return 'Success';
      } else {
        return 'Failed';
      }

    } catch (e) {
      return e.toString();
    }
  }
}