import 'package:flutter/material.dart';

class MyMultiLineTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController tEcontroller;
  const MyMultiLineTextFormField({
    super.key,
    required this.hintText,
    required this.tEcontroller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: tEcontroller,
      maxLines: 5,
      decoration: InputDecoration(
        fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        filled: true,
        hintText: hintText,
      ),
    );
  }
}
