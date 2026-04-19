import 'package:flutter/material.dart';

import 'package:news_app/core/l10n/strings.dart';
import 'package:news_app/core/theme/app_theme_data.dart';
import 'package:news_app/app/app_shell.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      builder: (context, child) => child ?? const SizedBox.shrink(),
      theme: AppThemeData.light(),
      home: const AppShell(),
    );
  }
}

