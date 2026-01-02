// ignore_for_file: use_build_context_synchronously

import 'package:demo/controller/provider_state/signup_provider_state.dart';
import 'package:demo/core/router_controller.dart';
import 'package:demo/core/utils/popup_message.dart';
import 'package:demo/view/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupNotifier extends Notifier<SignupProviderState> {
  @override
  SignupProviderState build() => const SignupProviderState();

  final _auth = FirebaseAuth.instance;

  Future<void> signup({
    required BuildContext context,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      if (password != confirmPassword) {
        popupMessage(context: context, message: "Passwords don't match");
        return;
      } else {
        state = state.copyWith(isLoading: true);

        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        RouterController.pushAndReplace(context: context, screen: LoginScreen());
        popupMessage(context: context, message: "Log in now");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        popupMessage(
          context: context,
          message: "The password provided is too weak",
        );
      } else if (e.code == 'email-already-in-use') {
        popupMessage(
          context: context,
          message: "The account already exists for that email",
        );
      } else {
        popupMessage(context: context, message: "Signup failed");
      }
    } catch (e) {
      popupMessage(context: context, message: "Signup failed");
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final signupProvider = NotifierProvider<SignupNotifier, SignupProviderState>(
  () => SignupNotifier(),
);
