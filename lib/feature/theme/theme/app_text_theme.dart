import 'package:flutter/material.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme textTheme(Color textColor) {
    return TextTheme(
      // H1
      displayLarge: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 32,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: textColor,
      ),

      // H2
      displayMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 28,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: textColor,
      ),

      // H3
      headlineLarge: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 24,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: textColor,
      ),

      // H4
      titleLarge: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: textColor,
      ),

      // Body
      bodyLarge: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: textColor,
      ),

      bodyMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: textColor,
      ),

      // Label & Button
      labelLarge: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: textColor,
      ),

      labelMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: textColor,
      ),

      labelSmall: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: textColor,
      ),
    );
  }
}
