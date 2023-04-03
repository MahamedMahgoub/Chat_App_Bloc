import 'package:chat_app_bloc/components/custom_buttom.dart';
import 'package:chat_app_bloc/components/custom_text_form_feild.dart';
import 'package:chat_app_bloc/constant.dart';
import 'package:chat_app_bloc/screens/chat_page.dart';
import 'package:chat_app_bloc/screens/register_page.dart';
import 'package:chat_app_bloc/shared/show_snak_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  String? email, password;

  bool ispassword = true;
  bool isloading = false;

  Widget build(BuildContext context) {
    return Scaffold(
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
                          setState(() {
                            isloading = true;
                          });

                          try {
                            await loginUser();
                            showSnakBar(context, 'Login Success', Colors.green);
                            Navigator.pushNamed(context, ChatPage.id,
                                arguments: email);
                          } on FirebaseAuthException catch (ex) {
                            if (ex.code == 'user-not-found') {
                              showSnakBar(context,
                                  'No user found for that email', Colors.red);
                            } else if (ex.code == 'wrong-password') {
                              showSnakBar(
                                  context, 'Wrong password', Colors.red);
                            }
                          } catch (ex) {
                            showSnakBar(context, 'there is Error', Colors.red);
                          }
                          setState(() {
                            isloading = false;
                          });
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
