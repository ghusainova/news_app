import 'package:flutter/material.dart';

import 'package:news_app/core/theme/app_theme.dart';

class AppThemeData {
  static const Color _seedColor = Colors.indigo;

  static ThemeData light() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _seedColor),
      useMaterial3: true,
      extensions: const [
        AppSpacing.standard(),
        AppRadii.standard(),
      ],
    );
  }
}

