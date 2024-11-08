import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:task_manager/login.dart';

import 'data/preferences_service.dart';

class AuthService {
  Future<String?> registration({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String? userId = result.user?.uid;

      if (userId != null) {
        DatabaseReference databaseReference =
            FirebaseDatabase.instance.ref('users/$userId');

        await databaseReference.set(
            {"fullName": fullName, "email": email, "courses": {}, "tasks": {}});
        return 'Success';
      } else {
        return 'Failed. Try Again';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential? userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String? userUid = userCredential.user?.uid;

      if (userUid != null) {
        final databaseRef = FirebaseDatabase.instance.ref();

        final userRef = databaseRef.child('users').child(userUid);

        // Check if the node exists
        DataSnapshot snapshot = await userRef.get();

        if (snapshot.exists) {
          // Node exists; retrieve child data
          String? fullName = snapshot.child('fullName').value as String?;
          await PreferencesService.saveString('currentUserUId', userUid);
          await PreferencesService.saveString('currentUserFullName', fullName!);
          await PreferencesService.saveString('currentUserEmail', email);
          // return 'Success.$fullName';
          return 'Success';
        } else {
          print("User does not exist.");
          return 'Failed. Try Again';
        }
      } else {
        return 'Failed. Try Again';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOutUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      await PreferencesService.clear();

      // Navigate to login screen only after sign-out completes
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      print("Error signing out: $e");
      // Optionally, show a message to the user
    }
  }
}
