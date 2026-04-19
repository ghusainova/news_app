import 'package:flutter/material.dart';

import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/presentation/widgets/article_card.dart';

class ArticlesListView extends StatelessWidget {
  final List<Article> articles;
  final bool Function(Article article) isFavorite;
  final void Function(Article article) onOpenDetails;
  final void Function(Article article) onToggleFavorite;

  const ArticlesListView({
    super.key,
    required this.articles,
    required this.isFavorite,
    required this.onOpenDetails,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return ArticlesListItem(
          article: articles[index],
          isFavorite: isFavorite,
          onOpenDetails: onOpenDetails,
          onToggleFavorite: onToggleFavorite,
        );
      },
    );
  }
}

class ArticlesListItem extends StatelessWidget {
  final Article article;
  final bool Function(Article article) isFavorite;
  final void Function(Article article) onOpenDetails;
  final void Function(Article article) onToggleFavorite;

  const ArticlesListItem({
    super.key,
    required this.article,
    required this.isFavorite,
    required this.onOpenDetails,
    required this.onToggleFavorite,
  });

  void _handleOpen() => onOpenDetails(article);

  void _handleToggle() => onToggleFavorite(article);

  @override
  Widget build(BuildContext context) {
    return ArticleCard(
      article: article,
      isFavorite: isFavorite(article),
      onTap: _handleOpen,
      onFavoritePressed: _handleToggle,
    );
  }
}

