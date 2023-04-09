part of 'auth_bloc.dart';

//@immutable
abstract class AuthState {}

class AuthInitialState extends AuthState {}

// Login State

class LoginloadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  String errMessage;
  Color color;
  LoginSuccessState({required this.errMessage, required this.color});
}

class LoginFailuarState extends AuthState {
  String errMessage;
  Color color;
  LoginFailuarState({required this.errMessage, required this.color});
}

// Register State
class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {
  String errMessage;
  Color color;
  RegisterSuccessState({required this.errMessage, required this.color});
}

class RegisterFailuarState extends AuthState {
  String errMessage;
  Color color;
  RegisterFailuarState({required this.errMessage, required this.color});
}
