part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  String errMessage;
  Color color;
  RegisterSuccessState({required this.errMessage, required this.color});
}

class RegisterFailuarState extends RegisterState {
  String errMessage;
  Color color;
  RegisterFailuarState({required this.errMessage, required this.color});
}
