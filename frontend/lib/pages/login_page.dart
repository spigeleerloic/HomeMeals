import 'package:flutter/material.dart';
import 'package:frontend/components/custom_button.dart';
import 'package:frontend/components/custom_text_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> SignIn(BuildContext context) async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      if (!context.mounted) {
        Navigator.pop(context);
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
      Uri.parse("http://localhost:8080/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // set the CSRF token also
      },
      body: jsonEncode(<String, String>{
        'username': usernameController.text,
        'password': passwordController.text,
      }),
    );

    if (!context.mounted) {
        Navigator.pop(context);
    }

    if (response.statusCode == 200) {
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('Error'),
              content: Text("Invalid username or password"),
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
              Text("Welcome to the Login page, please connect to your account"),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot password?",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25,),

              CustomButton(onTap: () => SignIn(context), text: "Sign-in",),
              const SizedBox(height: 25,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not registered yet ?"),
                  const SizedBox(width: 5,),
                  GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/register');
                  },
                  child: Text("Register now",
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
