import 'package:flutter/material.dart';

import 'package:news_app/core/theme/app_theme.dart';

class StateMessage extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String? title;
  final String message;
  final VoidCallback onPressed;
  final String buttonLabel;
  final Color? buttonBackgroundColor;
  final Color? buttonForegroundColor;

  const StateMessage({
    super.key,
    required this.icon,
    this.iconColor,
    this.title,
    required this.message,
    required this.onPressed,
    required this.buttonLabel,
    this.buttonBackgroundColor,
    this.buttonForegroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(spacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 64,
              color: iconColor ?? Colors.grey[400],
            ),
            Padding(padding: EdgeInsets.only(top: spacing.md)),
            if (title != null) ...[
              Text(
                title!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Padding(padding: EdgeInsets.only(top: spacing.sm)),
            ],
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
            ),
            Padding(padding: EdgeInsets.only(top: spacing.lg)),
            ElevatedButton.icon(
              onPressed: onPressed,
              icon: const Icon(Icons.refresh),
              label: Text(buttonLabel),
              style: (buttonBackgroundColor != null ||
                      buttonForegroundColor != null)
                  ? ElevatedButton.styleFrom(
                      backgroundColor: buttonBackgroundColor,
                      foregroundColor: buttonForegroundColor,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

