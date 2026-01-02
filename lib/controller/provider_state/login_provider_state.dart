import 'package:firebase_auth/firebase_auth.dart';

class LoginProviderState {
  final bool isLoading;
  final UserCredential? userDetails;

  const LoginProviderState({this.isLoading = false, this.userDetails});

  LoginProviderState copyWith({bool? isLoading, UserCredential? userDetails}) {
    return LoginProviderState(
      isLoading: isLoading ?? this.isLoading,
      userDetails: userDetails,
    );
  }
}
