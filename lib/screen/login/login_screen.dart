
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../model/login_model.dart';
import '../../widgets/custom_bottun.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/temp.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenWidth = MediaQuery.sizeOf(context).width;
    final ScreenHeight = MediaQuery.sizeOf(context).height;
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFF90A38A),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Login successful!"),
                backgroundColor: Colors.green,
              ),
            );
            context.read<AuthBloc>().add(UserSaved());
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>DashboardPage()), (context)=>false);
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Login Failed: ${state.error}"),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Stack(
          children: [
            Container(
              width: ScreenWidth,
              height: ScreenHeight,
              color: const Color(0xFF90A38A),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset("assets/images/vector.png"),
                      ],
                    ),
                  ),
                  Positioned(
                    top: ScreenHeight * (150 / 812),
                    left: ScreenWidth * (30 / 375),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Hi Admin",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Sign in to continue",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: ScreenWidth * 0.7,
                      height: ScreenHeight * 0.2,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: ScreenHeight * 0.35,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenWidth * 0.08, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Mobile Number/Email",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color:  Color(0xFF90A38A),),
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                        const SizedBox(height: 25),
                        const Text(
                          "Password",
                          style: TextStyle(
                            color: Color(0xff625D5D),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "••••••••••",
                            hintStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color:  Color(0xFF90A38A),),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.visibility_off, color: Colors.grey),
                              onPressed: () {},
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color:  Color(0xFF90A38A),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            if (state is LoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return GestureDetector(
                              onTap: () {
                                context.read<LoginBloc>().add(
                                  TryLogin(
                                    user: LoginModel(
                                      username: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: ScreenWidth,
                                height: 50,
                                decoration: BoxDecoration(
                                  // gradient: const LinearGradient(
                                  //   colors: [
                                  //     Color(0xFF446CBA),
                                  //     Color(0xFF6487C9),
                                  //   ],),
                                  color: const Color(0xFF90A38A),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "SIGN IN",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(Icons.arrow_forward, color: Colors.white),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: ScreenHeight * 0.05),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}