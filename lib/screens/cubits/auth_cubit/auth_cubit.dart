import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  // Login Logic
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

  // Register Logic

  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(RegisterLoadingState());
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterSuccessState(
          errMessage: 'Register Success', color: Colors.green));
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
        emit(RegisterFailuarState(
            errMessage: 'Week Password', color: Colors.red));
      } else if (ex.code == 'email-already-in-use') {
        emit(RegisterFailuarState(
            errMessage: 'email already in use', color: Colors.red));
      }
    } on Exception catch (e) {
      emit(RegisterFailuarState(
          errMessage: 'Something is Error', color: Colors.red));
    }
  }
}
