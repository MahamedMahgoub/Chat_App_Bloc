import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginloadingState());
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email, password: event.password);
          emit(LoginSuccessState(
              errMessage: 'Login Success', color: Colors.green));
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'user-not-found') {
            emit(LoginFailuarState(
                errMessage: 'No user found for that email', color: Colors.red));
          } else if (ex.code == 'wrong-password') {
            emit(LoginFailuarState(
                errMessage: 'Wrong password', color: Colors.red));
          }
        } catch (ex) {
          emit(LoginFailuarState(
              errMessage: 'Something is Error', color: Colors.red));
        }
      }
    });
  }
}
