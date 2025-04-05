import 'package:flutter/material.dart';

class TextButtonStyle {
  TextButtonStyle._();
  static TextButtonThemeData light = TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0XFFDCDEDE), width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
  );

  static TextButtonThemeData dark = TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xFF444444), width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: const Color(0xFF2B2B2B),
      foregroundColor: Colors.white,
    ),
  );
}
