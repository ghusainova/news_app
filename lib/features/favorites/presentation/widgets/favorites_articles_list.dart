import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/presentation/navigation/article_details_navigator.dart';
import 'package:news_app/features/news/presentation/widgets/articles_list_view.dart';

class FavoritesArticlesList extends StatelessWidget {
  final List<Article> favorites;
  static const ArticleDetailsNavigator _detailsNavigator =
      ArticleDetailsNavigator();

  const FavoritesArticlesList({super.key, required this.favorites});

  void _toggleFavorite(BuildContext context, Article article) {
    context.read<FavoritesBloc>().add(FavoritesEvent.toggled(article: article));
  }

  @override
  Widget build(BuildContext context) {
    return ArticlesListView(
      articles: favorites,
      isFavorite: (_) => true,
      onOpenDetails: (article) => _detailsNavigator.open(context, article),
      onToggleFavorite: (article) => _toggleFavorite(context, article),
    );
  }
}
