import 'package:flutter/material.dart';
import 'package:siqma_field/siqma_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final codeAccessController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    codeAccessController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff10122a),
      body: Center(
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
                label: 'Email',
                controller: emailController,
                borderColor: Color.fromARGB(30, 229, 231, 235),
                fontStyle: TextStyle(color: Color(0xffE5E7EB)),
              ),
              SizedBox(height: 16),
              SiqmaField(
                label: 'Code Access',
                controller: codeAccessController,
                borderColor: Color.fromARGB(30, 229, 231, 235),
                fontStyle: TextStyle(color: Color(0xffE5E7EB)),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Color(0xff343c60),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(color: Color(0xffE5E7EB), fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
