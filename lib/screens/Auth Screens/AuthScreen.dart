import 'package:e_library/screens/Auth%20Screens/AuthScreenBody.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Welcome to E-Library"),
                SizedBox(height: 60),
                AuthScreenBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
