import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/core/theme/app_theme.dart';
import 'package:news_app/features/news/presentation/bloc/news_filters_cubit.dart';
import 'package:news_app/features/news/presentation/widgets/news_category_dropdown.dart';
import 'package:news_app/features/news/presentation/widgets/news_search_field.dart';

class NewsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NewsAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(72 + 60);

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    return AppBar(
      toolbarHeight: 72,
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: spacing.sm),
        child: const NewsSearchField(),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BlocSelector<NewsFiltersCubit, NewsFiltersState, String?>(
          selector: (state) => state.category,
          builder: (context, selectedCategory) {
            return NewsCategoryDropdown(
              selectedCategory: selectedCategory,
              onChanged: (value) {
                context.read<NewsFiltersCubit>().setCategory(value);
                context.read<NewsFiltersCubit>().submit();
              },
            );
          },
        ),
      ),
    );
  }
}

