import 'package:meta/meta.dart';
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
      emit(LoginSuccessState());
    } on Exception catch (e) {
      emit(LoginFailuarState());
    }
  }
}
