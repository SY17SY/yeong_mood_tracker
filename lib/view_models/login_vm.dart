import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeong_mood_tracker/repos/auth_repo.dart';
import 'package:yeong_mood_tracker/utils.dart';

class LoginViewModel extends AsyncNotifier<void> {
  late final AuthRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepository);
  }

  Future<void> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _repository.logIn(email, password),
    );

    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      // context.go();
    }
  }
}

final loginProvider = AsyncNotifierProvider<LoginViewModel, void>(
  () => LoginViewModel(),
);
