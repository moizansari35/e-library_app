import 'package:e_library/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Row(
        children: [
          const Icon(
            Icons.arrow_back_ios,
            color: MyColors.whiteColor,
          ),
          Text(
            "Back",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: MyColors.whiteColor,
                ),
          ),
        ],
      ),
    );
  }
}
