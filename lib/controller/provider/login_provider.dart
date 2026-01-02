// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:demo/controller/provider_state/login_provider_state.dart';
import 'package:demo/core/utils/popup_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginNotifier extends Notifier<LoginState> {
  @override
  LoginState build() {
    return const LoginState();
  }

  final _auth = FirebaseAuth.instance;

  Future<void> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      state = state.copyWith(isLoading: true);

      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      state.copyWith(userDetails: user);
      log(user.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        popupMessage(context: context, message: "No user found");
      } else if (e.code == 'wrong-password') {
        popupMessage(context: context, message: "Invalid password");
      } else {
        popupMessage(context: context, message: "Login failed");
      }
    } catch (e) {
      popupMessage(context: context, message: "Login failed");
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final loginProvider = NotifierProvider<LoginNotifier, LoginState>(
  () => LoginNotifier(),
);
