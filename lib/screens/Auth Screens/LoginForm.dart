import 'package:e_library/config/colors.dart';
import 'package:e_library/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ForgotPassword.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    RxBool isPasswordShow = false.obs;
    AuthController authController = Get.put(AuthController());
    return Column(
      children: [
        const SizedBox(height: 40),
        TextField(
          controller: email,
          decoration: const InputDecoration(
            hintText: "Email",
            prefixIcon: Icon(
              Icons.alternate_email_rounded,
            ),
          ),
        ),
        const SizedBox(height: 30),
        Obx(
          () => TextField(
            obscureText: !isPasswordShow
                .value, // Set to false to show password when isPasswordShow is true
            controller: password,
            decoration: InputDecoration(
              hintText: "Password",
              suffixIcon: IconButton(
                  onPressed: () {
                    // Toggle the visibility of the password
                    isPasswordShow.value = !isPasswordShow.value;
                  },
                  icon: isPasswordShow.value
                      ? const Icon(Icons
                          .visibility) // Show visibility icon when password is visibleIcon(Icons
                      : const Icon(Icons
                          .visibility_off) // Show visibility_off icon when password is hidden Icon(Icons

                  ),
              prefixIcon: const Icon(
                Icons.password_outlined,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            InkWell(
              onTap: () {
                Get.to(() => const ForgotPassword());
              },
              child: Text("Forgot Password ? ",
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.primary,
                  )),
            )
          ],
        ),
        const SizedBox(height: 60),
        Obx(
          () => authController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: MyColors.primaryColor,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        authController.loginWithEmailAndPassword(
                            email.text, password.text);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primaryColor,
                      ),
                      child: Text(
                        "Login",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: MyColors.backgroundColor,
                            ),
                      ),
                    )
                  ],
                ),
        )
      ],
    );
  }
}
