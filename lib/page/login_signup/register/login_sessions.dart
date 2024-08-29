import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class LoginSession {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.refFromURL(
      'https://thaijourney-4881b-default-rtdb.asia-southeast1.firebasedatabase.app');

  Future<User?> singInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        await _databaseReference.child('users/${user.uid}').set({
          'email': user.email,
          'lastLogin': DateTime.now().toIso8601String(),
          'active': true,
        });
      }
      return user;
    } catch (e) {
      ('Error signing in : $e');
      return null;
    }
  }
}
