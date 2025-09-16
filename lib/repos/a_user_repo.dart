import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeong_mood_tracker/models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    await _db.collection("users").doc(user.uid).set(user.toJson());
  }

  Future<List<UserModel>> searchUsers(String uid, String keyword) async {
    final query = _db
        .collection("users")
        .where("name", isGreaterThanOrEqualTo: keyword)
        .where("name", isLessThanOrEqualTo: "$keyword\uf8ff");
    final QuerySnapshot<Map<String, dynamic>> snapshot = await query.get();
    final List<UserModel> users =
        snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();

    return users;
  }
}

final userRepository = Provider((ref) => UserRepository());
