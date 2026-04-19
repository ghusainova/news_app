import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/core/l10n/strings.dart';
import 'package:news_app/core/theme/app_theme.dart';
import 'package:news_app/features/news/presentation/bloc/news_filters_cubit.dart';

class NewsSearchField extends StatefulWidget {
  const NewsSearchField({super.key});

  @override
  State<NewsSearchField> createState() => _NewsSearchFieldState();
}

class _NewsSearchFieldState extends State<NewsSearchField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: context.read<NewsFiltersCubit>().state.query,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final radii = context.radii;
    final colorScheme = Theme.of(context).colorScheme;

    final cubit = context.read<NewsFiltersCubit>();

    return BlocListener<NewsFiltersCubit, NewsFiltersState>(
      listenWhen: (prev, next) => prev.query != next.query,
      listener: (context, state) {
        if (_controller.text == state.query) return;
        _controller.value = TextEditingValue(
          text: state.query,
          selection: TextSelection.collapsed(offset: state.query.length),
        );
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(height: 44),
        child: TextField(
          controller: _controller,
          textInputAction: TextInputAction.search,
          onChanged: cubit.setQuery,
          onSubmitted: (_) => cubit.submit(),
          maxLines: 1,
          decoration: InputDecoration(
            hintText: AppStrings.searchNews,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: BlocBuilder<NewsFiltersCubit, NewsFiltersState>(
              buildWhen: (prev, next) => prev.query != next.query,
              builder: (context, state) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (state.query.trim().isNotEmpty)
                      IconButton(
                        tooltip: 'Clear',
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          cubit.setQuery('');
                          _controller.clear();
                          cubit.submit();
                        },
                      ),
                    IconButton(
                      tooltip: AppStrings.searchAction,
                      icon: const Icon(Icons.send),
                      onPressed: cubit.submit,
                    ),
                  ],
                );
              },
            ),
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
      ),
    );
  }
}

