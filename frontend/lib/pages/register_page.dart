import 'package:flutter/material.dart';
import 'package:frontend/components/custom_button.dart';
import 'package:frontend/components/custom_text_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> register(BuildContext context) async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      if (!context.mounted) {
        Navigator.pop(context);
        return;
      }
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('Error'),
              content: Text('Please enter both username and password.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
      );
    }

    final response = await http.post(
      Uri.parse("http://localhost:8080/register"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': usernameController.text,
        'password': passwordController.text,
      }),
    );
    if (!context.mounted) {
      Navigator.pop(context);
      return;
    }

    if (response.statusCode == 200) {
      Navigator.pushReplacementNamed(context, "/login");
    } else {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('Error'),
              content: Text(
                "Error creating user, user may be already registered",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Ok"),
                ),
              ],
            ),
      );
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              // logo
              const SizedBox(height: 25),
              Icon(Icons.verified_user_rounded, size: 100),
              // login message
              const SizedBox(height: 25),
              Text(
                "Welcome to the registration page, please create an account",
              ),
              const SizedBox(height: 25),

              CustomTextField(
                controller: usernameController,
                hintText: 'username123',
                obscureText: false,
              ),
              const SizedBox(height: 25),

              CustomTextField(
                controller: passwordController,
                hintText: '*******',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              CustomButton(onTap: () => register(context), text: "Register"),

              const SizedBox(height: 25,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account ?"),
                  const SizedBox(width: 5,),
                  GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text("Sign in",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold
                    ),)
                  ),

                ],
              )

              //
            ],
          ),
        ),
      ),
    );
  }
}
