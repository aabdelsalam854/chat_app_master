import 'package:flutter/material.dart';

class CustomTitleText extends StatelessWidget {
  const CustomTitleText({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Text(title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
