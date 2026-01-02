import 'package:firebase_auth/firebase_auth.dart';

class LoginState {
  final bool isLoading;
  final UserCredential? userDetails;

  const LoginState({this.isLoading = false, this.userDetails});

  LoginState copyWith({bool? isLoading, UserCredential? userDetails}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      userDetails: userDetails,
    );
  }
}
