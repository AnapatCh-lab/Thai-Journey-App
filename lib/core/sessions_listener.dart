import 'package:firebase_database/firebase_database.dart';

class SessionListener {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.refFromURL(
      'https://thaijourney-4881b-default-rtdb.asia-southeast1.firebasedatabase.app');

  Stream<dynamic> getUserSession(String uid) {
    return _databaseReference.child('session/$uid').onValue;
  }
}
