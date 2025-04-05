import 'package:chat_master/core/styles/app_color.dart';
import 'package:flutter/material.dart';


class DontHaveAnAccountSection extends StatelessWidget {
  const DontHaveAnAccountSection({
    super.key, required this.title, required this.buttonText, required this.onPressed,
  });
  final String title;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: TextStyle(
              color: AppColors.kCustomBottomColors,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
