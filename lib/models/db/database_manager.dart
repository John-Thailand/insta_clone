import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:insta_clone/data_models/user.dart';

class DatabaseManager {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ユーザーが存在するか確認する
  Future<bool> searchUserInDb(auth.User firebaseUser) async {
    final query = await _db
        .collection('users')
        .where("userId", isEqualTo: firebaseUser.uid)
        .get();
    if (query.docChanges.length > 0) {
      return true;
    }
    return false;
  }

  // ユーザー情報を格納
  Future<void> insertUser(User user) async {
    await _db.collection("users").doc(user.userId).set(user.toMap());
  }

  Future<User> getUserInfoFromDbById(String userId) async {
    final query =
        await _db.collection("users").where("userId", isEqualTo: userId).get();
    return User.fromMap(query.docs[0].data());
  }
}
