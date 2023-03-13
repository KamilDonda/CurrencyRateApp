import 'package:flutter/material.dart';

class CustomTypography {
  static const TextStyle currencyStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static const TextStyle dateStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: Color(0xFF737373),
  );

  static const TextStyle headerStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: Color(0xFF4F4F4F),
  );

  static TextStyle appbarStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  static TextStyle codeStyle = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    letterSpacing: 0.5,
  );

  static TextStyle currencyNameStyle = const TextStyle(
    fontStyle: FontStyle.italic,
    letterSpacing: 0.5,
    color: Colors.grey,
    fontSize: 13,
  );

  static TextStyle currencyValueStyle = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 22,
    letterSpacing: 0.5,
  );

  static TextStyle updateStyle = const TextStyle(
    fontStyle: FontStyle.italic,
    fontSize: 12,
    letterSpacing: 0.5,
    color: Color(0xFF4F4F4F),
  );
}
