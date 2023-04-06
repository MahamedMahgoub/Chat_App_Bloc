import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

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
