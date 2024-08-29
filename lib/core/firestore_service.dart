import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thaijourney/page/login_signup/login_signup.dart';
import 'package:thaijourney/util/transition_route.dart';

class FirestoreService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerUser({
    required String fname,
    required String lname,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      // Create a new user with Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      // Save the user's information to Firestore
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'fname': fname,
          'lname': lname,
          'email': email,
        });

        // Navigate to the login page or any other action
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            SlideRoute(page: LoginSignUpPage()),
          );
        }
        
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase Authentication errors
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Registration failed')),
        );
      }
      
    } catch (e) {
      // Handle other errors
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred, please try again later.')),
        );
      }
      
    }
  }
}
