import 'package:flutter/material.dart';

void snackBar(BuildContext context, String text, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: color,
    content: Text(text),
    behavior: SnackBarBehavior.floating,
    elevation: 8.0,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - 220,
      left: 20,
      right: 20,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    duration: Duration(seconds: 5),
  ));
}
