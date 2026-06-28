import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme textTheme(Color textColor) {
    return GoogleFonts.notoSansTextTheme().copyWith(
      // h1
      displayLarge: GoogleFonts.notoSans(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: textColor,
      ),

      // h2
      displayMedium: GoogleFonts.notoSans(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: textColor,
      ),

      // h3
      headlineLarge: GoogleFonts.notoSans(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: textColor,
      ),

      // h4
      titleLarge: GoogleFonts.notoSans(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: textColor,
      ),

      // p
      bodyLarge: GoogleFonts.notoSans(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: textColor,
      ),

      bodyMedium: GoogleFonts.notoSans(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: textColor,
      ),

      // label & button
      labelLarge: GoogleFonts.notoSans(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: textColor,
      ),

      labelMedium: GoogleFonts.notoSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: textColor,
      ),

      labelSmall: GoogleFonts.notoSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: textColor,
      ),
    );
  }
}
