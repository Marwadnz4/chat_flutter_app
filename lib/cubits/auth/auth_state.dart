abstract class AuthState {}

class AuthInitial extends AuthState {}

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {
  final String email;
  RegisterSuccessState(
    this.email,
  );
}

class RegisterFailureState extends AuthState {
  final String errorMessage;
  RegisterFailureState(
    this.errorMessage,
  );
}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final String email;
  LoginSuccessState(
    this.email,
  );
}

class LoginFailureState extends AuthState {
  final String errorMessage;
  LoginFailureState(
    this.errorMessage,
  );
}
