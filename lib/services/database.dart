import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseMethods {
  Future addUser(String userId, Map<String, dynamic> userInfoMap) async {
    try {
      await FirebaseFirestore.instance
          .collection("User")
          .doc(userId)
          .set(userInfoMap);
      print('User Added succesfuul');
    } catch (e) {
      print("Error adding user : $e");
    }
  }
}
