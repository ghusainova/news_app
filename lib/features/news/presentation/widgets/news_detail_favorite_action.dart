import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

class NewsDetailFavoriteAction extends StatelessWidget {
  final Article article;
  final bool isFavorite;

  const NewsDetailFavoriteAction({
    super.key,
    required this.article,
    required this.isFavorite,
  });

  void _toggleFavorite(BuildContext context) {
    context.read<FavoritesBloc>().add(FavoritesEvent.toggled(article: article));
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Theme.of(context).colorScheme.error : null,
      ),
      onPressed: () => _toggleFavorite(context),
    );
  }
}
