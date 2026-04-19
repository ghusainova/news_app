import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/article.dart';
import '../../../favorites/presentation/bloc/favorites_bloc.dart';
import 'package:news_app/core/l10n/strings.dart';
import 'package:news_app/core/theme/app_theme.dart';
import 'package:news_app/features/news/presentation/widgets/news_detail_favorite_action.dart';

class NewsDetailPage extends StatelessWidget {
  final Article article;

  const NewsDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final favoritesState = context.watch<FavoritesBloc>().state;
    final isFavorite = favoritesState.maybeWhen(
      loaded: (favorites) => favorites.any((fav) => fav.url == article.url),
      updated: (favorites, _) => favorites.any((fav) => fav.url == article.url),
      orElse: () => false,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.newsDetailsTitle),
        actions: [
          NewsDetailFavoriteAction(article: article, isFavorite: isFavorite),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(context.radii.sm),
                child: Image.network(
                  article.imageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 200,
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            Padding(
              padding: EdgeInsets.only(top: context.spacing.md),
              child: Text(
                article.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: context.spacing.sm),
              child: Text(
                article.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: context.spacing.md),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16),
                  Padding(
                    padding: EdgeInsets.only(left: context.spacing.xs),
                    child: Text(
                      article.publishedAt == null
                          ? ''
                          : DateFormat('MMM d, yyyy HH:mm')
                              .format(article.publishedAt!),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
            if (article.sourceName.isNotEmpty) ...[
              Padding(
                padding: EdgeInsets.only(top: context.spacing.sm),
                child: Row(
                  children: [
                    const Icon(Icons.source, size: 16),
                    Padding(
                      padding: EdgeInsets.only(left: context.spacing.xs),
                      child: Text(
                        article.sourceName,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
