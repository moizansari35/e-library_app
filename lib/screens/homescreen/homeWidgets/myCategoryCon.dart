import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyCategoryContainer extends StatelessWidget {
  final String iconName;
  final String btnName;
  const MyCategoryContainer(
      {super.key, required this.iconName, required this.btnName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.surface),
          child: Row(
            children: [
              SvgPicture.asset(iconName),
              const SizedBox(width: 10),
              Text(btnName),
            ],
          ),
        ),
      ),
    );
  }
}
