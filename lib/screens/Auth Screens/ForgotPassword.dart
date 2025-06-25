//import 'package:e_library/controllers/AuthController.dart';
import 'package:flutter/material.dart';
//import 'package:get/get.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    //AuthController authController = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter your email id and we will send you reset password link on email",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                hintText: "Enter Email id",
                fillColor: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: const Text("Reset Now")),
          ],
        ),
      ),
    );
  }
}
