import 'package:flutter/material.dart';
import 'package:my_casher/feature/theme/theme/app_text_theme.dart';

import 'app_colors.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,

    primary: AppColors.primary,
    onPrimary: Colors.white,

    secondary: Color(0xFFEEF2F7),
    onSecondary: Color(0xFF374151),

    error: AppColors.error,
    onError: Colors.white,

    surface: Colors.white,
    onSurface: Color(0xFF111827),
  ),
  scaffoldBackgroundColor: const Color(0xFFF5F7FA),

  cardColor: Colors.white,

  dividerColor: const Color.fromRGBO(0, 0, 0, .08),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Color(0xFF111827),
    elevation: 0,
    centerTitle: true,
  ),

  textTheme: AppTextTheme.textTheme(const Color(0xFF111827)),
);
