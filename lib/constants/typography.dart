import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTypography {
  static TextStyle currencyStyle = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF4F4F4F),
  );

  static TextStyle currencyMeanStyle = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF343434),
  );

  static TextStyle dateStyle = GoogleFonts.lato(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: const Color(0xFF737373),
  );

  static TextStyle headerStyle = GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: Colors.black,
  );

  static TextStyle appbarStyle = GoogleFonts.lato(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  static TextStyle codeStyle = GoogleFonts.lato(
    fontWeight: FontWeight.w600,
    fontSize: 18,
    letterSpacing: 0.5,
  );

  static TextStyle currencyNameStyle = GoogleFonts.lato(
    fontStyle: FontStyle.italic,
    letterSpacing: 0.5,
    color: Colors.grey,
    fontSize: 15,
  );

  static TextStyle currencyNameHeaderStyle = GoogleFonts.lato(
    color: const Color(0xFF6B6B6B),
    fontSize: 17,
  );

  static TextStyle currencyValueStyle = GoogleFonts.lato(
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontSize: 32,
    letterSpacing: 0.5,
  );

  static TextStyle currencyValueStyle2 = currencyValueStyle.copyWith(
    fontSize: 30,
    color: const Color(0xFF6B6B6B),
    fontWeight: FontWeight.w400,
  );

  static TextStyle currencyValueHeaderStyle = GoogleFonts.lato(
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontSize: 28,
    letterSpacing: 0.5,
  );

  static TextStyle updateStyle = GoogleFonts.lato(
    fontStyle: FontStyle.italic,
    fontSize: 12,
    letterSpacing: 0.5,
    color: const Color(0xFF4F4F4F),
  );

  static TextStyle snackBarStyle = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: 0.5,
  );

  static TextStyle dataNotFoundStyle = GoogleFonts.lato(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF4F4F4F),
    letterSpacing: 0.5,
  );
}
