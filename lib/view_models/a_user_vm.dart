import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeong_mood_tracker/models/a_user_model.dart';
import 'package:yeong_mood_tracker/repos/b_auth_repo.dart';
import 'package:yeong_mood_tracker/repos/a_user_repo.dart';

class UserViewModel extends AsyncNotifier<void> {
  late final UserRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(userRepository);
  }

  Future<void> createUser(
    UserCredential credential, {
    required String name,
  }) async {
    final user = UserModel(
      uid: credential.user!.uid,
      name: name,
      email: credential.user!.email ?? "example@gmail.com",
      followings: 0,
      followers: 0,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    await _repository.createUser(user);
  }

  Future<List<UserModel>> searchUsers(String keyword) async {
    final uid = ref.read(authRepository).user!.uid;
    return _repository.searchUsers(uid, keyword);
  }
}

final userProvider = AsyncNotifierProvider<UserViewModel, void>(
  () => UserViewModel(),
);
