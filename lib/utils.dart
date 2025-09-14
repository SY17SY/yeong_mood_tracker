import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void showFirebaseErrorSnack(BuildContext context, Object? error) {
  final snackBar = SnackBar(
    showCloseIcon: true,
    closeIconColor: Colors.white,
    content: Text(
      (error as FirebaseException).message ?? "Something went wrong.",
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
