import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tharwati/utils/helpers/show_snack_bar.dart';

import '../constants/text_strings.dart';

void handleAuthError(FirebaseAuthException e, BuildContext context) {
  String message;
  switch (e.code) {
    // registration errors
    case 'email-already-in-use':
      message = MyTexts.emailAlreadyUsed;
      break;
    case 'invalid-email':
      message = MyTexts.invalidEmail;
      break;
    case 'operation-not-allowed':
      message = 'Email/password accounts are not enabled.';
      break;
    case 'weak-password':
      message = MyTexts.weakPassword;
      break;
    // login errors
    case 'user-not-found':
      message = MyTexts.userNotExist;
      break;
    case 'wrong-password':
      message = MyTexts.incorrectPass;
      break;
    case 'user-disabled':
      message = 'This user has been disabled.';
      break;
    default:
      message = 'An unexpected error occurred. Please try again later.';
  }

  showSnackBar(message, Colors.red, context);
}
