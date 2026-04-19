import 'package:flutter/material.dart';

import 'package:news_app/core/l10n/strings.dart';
import 'package:news_app/core/theme/app_theme.dart';
import 'package:news_app/features/news/presentation/widgets/news_category.dart';

class NewsCategoryDropdown extends StatelessWidget {
  final String? selectedCategory;
  final ValueChanged<String?> onChanged;

  const NewsCategoryDropdown({
    super.key,
    required this.selectedCategory,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final radii = context.radii;
    final spacing = context.spacing;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spacing.md, vertical: spacing.sm),
      child: Align(
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth > 600 ? 600.0 : constraints.maxWidth;
            return ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: DropdownButtonFormField<String>(
                initialValue: selectedCategory,
                hint: const Text(AppStrings.selectCategory),
                items: [
                  const DropdownMenuItem<String>(
                    value: null,
                    child: Text(AppStrings.allCategories),
                  ),
                  for (final category in NewsCategories.all)
                    DropdownMenuItem<String>(
                      value: category.apiValue,
                      child: Text(category.label),
                    ),
                ],
                onChanged: onChanged,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radii.md),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radii.md),
                    borderSide: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radii.md),
                    borderSide: BorderSide(color: colorScheme.outline, width: 1.5),
                  ),
                  filled: true,
                  fillColor: colorScheme.surface,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

