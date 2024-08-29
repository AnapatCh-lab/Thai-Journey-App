import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterUser {
  // Update the database reference URL to include the correct region
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.refFromURL(
    'https://thaijourney-4881b-default-rtdb.asia-southeast1.firebasedatabase.app',
  );

  Future<User?> registerUser(
    String fname,
    String lname,
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      // Create user with Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      // Check if user was successfully created
      if (user != null) {
        // Store additional user information in Realtime Database
        await _databaseReference.child('sessions/${user.uid}').set({
          'email': user.email,
          'fname': fname,
          'lname': lname,
          'profilepic': '',
          'createdAt': DateTime.now().toIso8601String(),
          'active': true,
        });

        // Show success message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(AppLocalizations.of(context)!.register_success)),
          );
        }
      }
      return user;
    } catch (e) {
      // Show error message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register: $e')),
        );
      }
    }
    return null;
  }
}
