import 'package:flutter/material.dart';

import 'package:news_app/core/l10n/strings.dart';
import 'package:news_app/core/widgets/state_message.dart';

class AppRetryMessage extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const AppRetryMessage({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return StateMessage(
      icon: Icons.error_outline,
      iconColor: Colors.red[400],
      title: AppStrings.loadErrorTitle,
      message: message,
      onPressed: onRetry,
      buttonLabel: AppStrings.retry,
      buttonBackgroundColor: Colors.red[400],
      buttonForegroundColor: Colors.white,
    );
  }
}

class AppRefreshMessage extends StatelessWidget {
  final IconData icon;
  final String message;
  final VoidCallback onRefresh;

  const AppRefreshMessage({
    super.key,
    required this.icon,
    required this.message,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return StateMessage(
      icon: icon,
      message: message,
      onPressed: onRefresh,
      buttonLabel: AppStrings.refresh,
    );
  }
}

