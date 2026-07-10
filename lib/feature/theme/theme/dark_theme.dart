import 'package:flutter/material.dart';
import 'package:my_casher/feature/theme/theme/app_text_theme.dart';

import 'app_colors.dart';

final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,

    primary: AppColors.primaryDark,
    onPrimary: Colors.black,

    secondary: Color(0xFF252836),
    onSecondary: Color(0xFFF0F0F0),

    error: Color(0xFFFF4757),
    onError: Colors.white,

    surface: Color(0xFF1A1D27),
    onSurface: Color(0xFFF0F0F0),
  ),

  scaffoldBackgroundColor: const Color(0xFF0F1117),

  cardColor: const Color(0xFF1A1D27),

  dividerColor: const Color.fromRGBO(255, 255, 255, .08),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1A1D27),
    foregroundColor: Color(0xFFF0F0F0),
    elevation: 0,
    centerTitle: true,
  ),

  fontFamily: 'Montserrat',

  textTheme: AppTextTheme.textTheme(const Color(0xFFF0F0F0)),
);
