import 'package:flutter/material.dart';
import 'package:task_manager/dashboard.dart';
import 'data/preferences_service.dart';
import 'login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesService.init();

  /*await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/

  await Firebase.initializeApp(
      // Replace with actual values
      options: const FirebaseOptions(
    apiKey: "AIzaSyCb6DJU-LM6Mk-douboBKndqscS3eDUzFE",
    appId: "1:884655194332:android:a591971dd7002a58d7f419",
    messagingSenderId: "884655194332",
    projectId: "fluttertaskmanager-bd819",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schedule & Task Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const LoginPage(),
      home: AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          String? userUid = snapshot.data?.uid;
          PreferencesService.saveString('currentUserUId', userUid!);
          // User is logged in
          // return DashboardPage(username: "Kakaka", email: "lalala@gmail.com");
          return const DashboardPage();
        } else {
          // Clear all data
          PreferencesService.clear();

          // User is NOT logged in
          return const LoginPage();
        }
      },
    );
  }
}
