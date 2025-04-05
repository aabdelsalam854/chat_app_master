import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  final String text;
  final double thickness;
  final Color color;

  const DividerWithText({
    super.key,
    required this.text,
    this.thickness = 1.5,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 30,
          child: Divider(
            color: color,
            thickness: thickness,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 30,
          child: Divider(
            color: color,
            thickness: thickness,
          ),
        ),
      ],
    );
  }
}
