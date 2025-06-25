import 'package:e_library/config/colors.dart';
import 'package:e_library/controllers/book_controller.dart';
import 'package:e_library/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(SplashController());
    // Get.put(BookController());
    try {
      Get.put(SplashController());
      Get.put(BookController());
    } catch (e) {
      debugPrint("Error initializing controllers: $e");
    }
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: Center(
        child: Lottie.asset("Assets/Animation/Animation_1.json"),
      ),
    );
  }
}
