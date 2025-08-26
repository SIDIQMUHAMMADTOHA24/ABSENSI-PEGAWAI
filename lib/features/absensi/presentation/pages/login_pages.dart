import 'package:absensi_pegawai/features/absensi/presentation/bloc/auth/auth_bloc.dart';
import 'package:absensi_pegawai/features/absensi/presentation/widgets/bottom_nav_bar_widget.dart';
import 'package:absensi_pegawai/features/absensi/presentation/widgets/nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siqma_field/siqma_field.dart';

class LoginPages extends StatefulWidget {
  const LoginPages({super.key});

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isVisible = true;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onVisible() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff10122a),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLogOut) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is AuthLogIn) {
            Nav.remove(context, BottomNavBarWidget());
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              if (state is AuthLoading) CupertinoActivityIndicator(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: MediaQuery.paddingOf(context).top + 40),
                      Text(
                        "Login",
                        style: TextStyle(
                          color: Color(0xffE5E7EB),
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 20),
                      SiqmaField(
                        label: 'Username',
                        controller: usernameController,
                        borderColor: Color.fromARGB(30, 229, 231, 235),
                        fontStyle: TextStyle(color: Color(0xffE5E7EB)),
                      ),
                      SizedBox(height: 16),
                      SiqmaField(
                        label: 'Password',
                        controller: passwordController,
                        obscureText: isVisible,
                        obscuringCharacter: "●",
                        borderColor: Color.fromARGB(30, 229, 231, 235),
                        fontStyle: TextStyle(color: Color(0xffE5E7EB)),
                        suffixIcon: GestureDetector(
                          onTap: onVisible,
                          child: Icon(
                            isVisible
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Material(
                        color: Color(0xff343c60),
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          onTap: () {
                            if (state is! AuthLoading) {
                              context.read<AuthBloc>().add(
                                LoginEvent(
                                  username: usernameController.text,
                                  password: passwordController.text,
                                ),
                              );
                            }
                          },
                          borderRadius: BorderRadius.circular(12),
                          focusColor: Color(0xff343c60),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Color(0xffE5E7EB),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
