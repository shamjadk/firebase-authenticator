// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:demo/controller/provider_state/login_provider_state.dart';
import 'package:demo/core/router_controller.dart';
import 'package:demo/core/utils/popup_message.dart';
import 'package:demo/view/screens/home_screen.dart';
import 'package:demo/view/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginNotifier extends Notifier<LoginProviderState> {
  @override
  LoginProviderState build() {
    return const LoginProviderState();
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
      if (user.user != null) {
        RouterController.pushAndReplace(context: context, screen: HomeScreen());
      }
      log(user.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        popupMessage(context: context, message: "No user found");
      }else if(e.code == 'invalid-credential'){
        popupMessage(context: context, message: "Invalid credentials");
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

  Future<void> logout({required BuildContext context}) async {
    state.copyWith(isLoading: true);
    await _auth.signOut();
    RouterController.pushAndRemoveUntil(context: context, screen: LoginScreen());
    state.copyWith(isLoading: false, userDetails: null);
  }
}

final loginProvider = NotifierProvider<LoginNotifier, LoginProviderState>(
  () => LoginNotifier(),
);
