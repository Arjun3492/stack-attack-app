import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firestore {
  static FirebaseFirestore get db => FirebaseFirestore.instance;

  Future getUserInfoFromDb(User user) async {
    await db.collection("users").where("uid", isEqualTo: user.uid).get();
  }

  Future addUserInfoToDb(Map<String, dynamic> userInfo) async {
    await db.collection("users").add(userInfo);
  }
}
