import 'package:chat_app_bloc/components/custom_buttom.dart';
import 'package:chat_app_bloc/components/custom_text_form_feild.dart';
import 'package:chat_app_bloc/constant.dart';
import 'package:chat_app_bloc/screens/bloc/bloc/auth_bloc.dart';
import 'package:chat_app_bloc/screens/chat_page.dart';
import 'package:chat_app_bloc/screens/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app_bloc/screens/register_page.dart';
import 'package:chat_app_bloc/shared/show_snak_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  static String id = 'Login Page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey();

  String? email, password;

  bool ispassword = true;

  bool isloading = false;

  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginloadingState) {
          isloading = true;
        } else if (state is LoginSuccessState) {
          showSnakBar(context, state.errMessage, state.color);
          BlocProvider.of<ChatCubit>(context).getMessage();
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          isloading = false;
        } else if (state is LoginFailuarState) {
          showSnakBar(context, state.errMessage, state.color);
          isloading = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isloading,
        child: Scaffold(
          backgroundColor: kPrimatrColor,
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Klogo,
                          height: 100,
                        ),
                        const Text(
                          'Scholar Chat',
                          style: TextStyle(
                            fontSize: 28,
                            fontFamily: 'Pacifico',
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Row(
                          children: const [
                            Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormFeild(
                          prefixIcon: Icon(Icons.email),
                          onChange: (data) {
                            email = data;
                          },
                          hintText: 'Email',
                          label: 'Email',
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextFormFeild(
                          prefixIcon: Icon(Icons.lock),
                          obscureText: ispassword,
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                ispassword = !ispassword;
                              });
                            },
                            child: Icon(
                              ispassword
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_outlined,
                              color: Colors.white,
                            ),
                          ),
                          onChange: (data) {
                            password = data;
                          },
                          hintText: 'Password',
                          label: 'Password',
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomButtom(
                          text: 'LOGIN',
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                                  email: email!, password: password!));
                            } else {}
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'don\'t have and account?   ',
                              style: TextStyle(
                                //fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, RegisterPage.id);
                              },
                              child: const Text(
                                'Register Now',
                                style: TextStyle(
                                  //fontSize: 10,
                                  color: Color(0xff97AEC7),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
