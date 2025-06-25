import 'package:e_library/config/colors.dart';
import 'package:e_library/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    TextEditingController username = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    RxBool isShowPassword = true.obs;

    return Column(
      children: [
        const SizedBox(height: 20),
        InkWell(
          onTap: () {
            authController.pickProfileImage();
          },
          child: Obx(() {
            return CircleAvatar(
              radius: 70,
              backgroundImage: authController.selectedProfileImage.value != null
                  ? FileImage(authController.selectedProfileImage.value!)
                  : null, // Show the selected profile image or null if not selected
              child: authController.selectedProfileImage.value == null
                  ? Center(
                      child: authController.isProfileImageUploading.value
                          ? const CircularProgressIndicator(
                              color: MyColors.backgroundColor,
                            )
                          : const Icon(
                              Icons.camera_alt,
                            ),
                    )
                  : null, // Show the CircularProgressIndicator or Icon only if no image is selected
            );
          }),
        ),
        const SizedBox(height: 40),
        TextField(
          controller: username,
          decoration: const InputDecoration(
            hintText: "Full Name",
            prefixIcon: Icon(
              Icons.person,
            ),
          ),
        ),
        const SizedBox(height: 30),
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
            obscureText: isShowPassword.value,
            controller: password,
            decoration: InputDecoration(
                hintText: "Passowrd",
                prefixIcon: const Icon(
                  Icons.password_outlined,
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                      isShowPassword.value = !isShowPassword.value;
                    },
                    icon: isShowPassword.value
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility))),
          ),
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
                        authController.signupWithEmailPassword(
                          email.text,
                          password.text,
                          username.text,
                          authController.pickedProfileImage,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primaryColor,
                      ),
                      child: Text(
                        "Signup",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: MyColors.backgroundColor,
                            ),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
