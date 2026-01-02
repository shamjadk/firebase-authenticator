class SignupProviderState {
  final bool isLoading;

  const SignupProviderState({this.isLoading = false});

  SignupProviderState copyWith({bool? isLoading}) {
    return SignupProviderState(isLoading: isLoading ?? this.isLoading);
  }
}
