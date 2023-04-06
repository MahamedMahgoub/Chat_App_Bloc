import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloc/bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginloadingState());
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccessState(errMessage: 'Login Success', color: Colors.green));
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFailuarState(
            errMessage: 'No user found for that email', color: Colors.red));
      } else if (ex.code == 'wrong-password') {
        emit(
            LoginFailuarState(errMessage: 'Wrong password', color: Colors.red));
      }
    } catch (ex) {
      emit(LoginFailuarState(
          errMessage: 'Something is Error', color: Colors.red));
    }
  }
}
