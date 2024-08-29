import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:thaijourney/page/login_signup/login_signup.dart';
import 'package:thaijourney/util/transition_route.dart';

class LogoutSession {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.refFromURL(
      'https://thaijourney-4881b-default-rtdb.asia-southeast1.firebasedatabase.app');

  Future<void> signOut() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _databaseReference.child('users/${user.uid}').update({
        'active': false,
        'lastLogout': DateTime.now().toIso8601String(),
      });

      await _auth.signOut();
    }
  }

  void showSignOutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Sign Out'),
              onPressed: () async {
                signOut();
                if (context.mounted) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushAndRemoveUntil(
                    SlideRoute(page: LoginSignUpPage()),
                    (Route<dynamic> route) => false,
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
