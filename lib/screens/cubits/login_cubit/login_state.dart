part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginloadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  String errMessage;
  Color color;
  LoginSuccessState({required this.errMessage, required this.color});
}

class LoginFailuarState extends LoginState {
  String errMessage;
  Color color;
  LoginFailuarState({required this.errMessage, required this.color});
}
