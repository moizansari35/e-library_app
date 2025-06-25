import 'package:e_library/screens/homescreen/homeScreen.dart';
import 'package:e_library/screens/welcomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final auth = FirebaseAuth.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    funSplashController();
  }

  void funSplashController() {
    Future.delayed(const Duration(seconds: 4), () {
      if (auth.currentUser != null) {
        Get.offAll(() => const HomeScreen());
      } else {
        Get.offAll(() => const WelcomeScreen());
      }
    });
  }
}
// import 'package:e_library/controllers/BookController.dart';
// import 'package:e_library/screens/homescreen/homeScreen.dart';
// import 'package:e_library/screens/welcomeScreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';

// class SplashController extends GetxController {
//   final FirebaseAuth auth = FirebaseAuth.instance;

//   @override
//   void onInit() {
//     super.onInit();
//     initializeControllers();
//     handleSplashLogic();
//   }

//   void initializeControllers() {
//     Get.lazyPut(() => BookController());
//   }

//   void handleSplashLogic() {
//     Future.delayed(Duration(seconds: 4), () {
//       if (auth.currentUser != null) {
//         Get.offAll(() => HomeScreen());
//       } else {
//         Get.offAll(() => WelcomeScreen());
//       }
//     });
//   }
// }
