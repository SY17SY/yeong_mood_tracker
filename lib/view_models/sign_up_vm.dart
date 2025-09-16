import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeong_mood_tracker/repos/auth_repo.dart';
import 'package:yeong_mood_tracker/utils.dart';
import 'package:yeong_mood_tracker/view_models/user_vm.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepository);
  }

  Future<void> emailSignUp({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final credential = await _repository.emailSignUp(email, password);
      await ref.read(userProvider.notifier).createUser(credential, name: name);
    });

    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      // context.go();
    }
  }
}

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
