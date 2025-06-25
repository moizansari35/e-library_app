import 'package:e_library/config/colors.dart';
import 'package:e_library/const/const.dart';
import 'package:e_library/controllers/auth_controller.dart';

import 'package:e_library/screens/profile%20screen/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = AuthController();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(
          Icons.dashboard,
          color: MyColors.whiteColor,
          size: 30,
        ),
        Text(
          "E-LIBRARY",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: MyColors.whiteColor),
        ),
        InkWell(
          onTap: () => Get.to(Profilescreen()),
          child: CircleAvatar(
            radius: 25,
            backgroundColor: MyColors.whiteColor,
            backgroundImage: NetworkImage(
              "${authController.auth.currentUser!.photoURL ?? defaultProfile}",
            ),
          ),
        ),
      ],
    );
  }
}
