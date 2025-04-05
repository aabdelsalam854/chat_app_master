import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.onPressed,
    required this.image,
  });

  final VoidCallback onPressed;
  final String image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Image.asset(
        image,
        height: 50,
      ),
    );
  }
}
