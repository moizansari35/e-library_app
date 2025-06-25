import 'package:e_library/Widgets/mainButton.dart';
import 'package:e_library/config/colors.dart';
import 'package:e_library/controllers/auth_controller.dart';
import 'package:e_library/screens/Auth%20Screens/AuthScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 65 / 100,
            decoration: const BoxDecoration(color: primaryColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "Assets/Images/e-library.png",
                  width: MediaQuery.sizeOf(context).width / 200 * 100,
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                    child: Text(
                  "E-LIBRARY",
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                )),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          "Here you can find treasure of Books that can be downloaded too. Enjoy !",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Disclaimer",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: MyColors.blackColor,
                        )),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "The content in this E-Library app is for informational and educational purposes only. We do not guarantee its accuracy or completeness. Users are responsible for verifying information. We are not liable for any damages or losses from using this app. Use at your own risk.",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
          MainButton(
              icon: "Assets/Icons/google.png",
              btnTitle: "LOGIN WITH GOOGLE",
              onTap: () {
                authController.signinWithGoogle();
              }),
          TextButton(
              onPressed: () {
                Get.to(() => const AuthScreen());
              },
              child: Text("Or Continue With Email and Password",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: MyColors.primaryColor,
                      ))),
        ],
      ),
    );
  }
}
