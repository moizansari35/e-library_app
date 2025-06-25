import 'package:e_library/config/colors.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String btnTitle;
  final String icon;
  final VoidCallback onTap;
  const MainButton({
    super.key,
    required this.btnTitle,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: MediaQuery.sizeOf(context).height * 8 / 100,
          decoration: BoxDecoration(
            color: MyColors.primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(icon),
              const SizedBox(
                width: 20,
              ),
              Text(
                btnTitle,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: MyColors.backgroundColor, letterSpacing: 1.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
