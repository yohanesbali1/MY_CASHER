import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme textTheme(Color textColor) {
    return TextTheme(
      // h1
      displayLarge: GoogleFonts.montserrat(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: textColor,
      ),

      // h2
      displayMedium: GoogleFonts.montserrat(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: textColor,
      ),

      // h3
      headlineLarge: GoogleFonts.montserrat(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: textColor,
      ),

      // h4
      titleLarge: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: textColor,
      ),

      // p
      bodyLarge: GoogleFonts.montserrat(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: textColor,
      ),

      bodyMedium: GoogleFonts.montserrat(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: textColor,
      ),

      // label & button
      labelLarge: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: textColor,
      ),

      labelMedium: GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: textColor,
      ),

      labelSmall: GoogleFonts.montserrat(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: textColor,
      ),
    );
  }
}
