import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/core/widgets/app_state_messages.dart';
import 'package:news_app/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/news_bloc.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/presentation/navigation/article_details_navigator.dart';
import 'package:news_app/features/news/presentation/bloc/news_filters_cubit.dart';
import 'package:news_app/features/news/presentation/widgets/articles_list_view.dart';
import 'package:news_app/features/news/presentation/widgets/news_loading_view.dart';

class NewsBody extends StatelessWidget {
  const NewsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const NewsLoadingView(),
          loaded: (articles) => LoadedNewsBody(articles: articles),
          empty: (message) => AppRefreshMessage(
            icon: Icons.newspaper,
            message: message,
            onRefresh: context.read<NewsFiltersCubit>().submit,
          ),
          error: (message) => AppRetryMessage(
            message: message,
            onRetry: context.read<NewsFiltersCubit>().submit,
          ),
        );
      },
    );
  }
}

class LoadedNewsBody extends StatelessWidget {
  final List<Article> articles;
  static const ArticleDetailsNavigator _detailsNavigator =
      ArticleDetailsNavigator();

  const LoadedNewsBody({super.key, required this.articles});

  void _toggleFavorite(BuildContext context, Article article) {
    context.read<FavoritesBloc>().add(FavoritesEvent.toggled(article: article));
  }

  @override
  Widget build(BuildContext context) {
    final favoritesState = context.watch<FavoritesBloc>().state;
    final favoriteUrls = favoritesState.maybeWhen(
      loaded: (favorites) => favorites.map((e) => e.url).toSet(),
      updated: (favorites, _) => favorites.map((e) => e.url).toSet(),
      orElse: () => <String>{},
    );

    return RefreshIndicator(
      onRefresh: () async => context.read<NewsFiltersCubit>().refresh(),
      child: ArticlesListView(
        articles: articles,
        isFavorite: (article) => favoriteUrls.contains(article.url),
        onOpenDetails: (article) => _detailsNavigator.open(context, article),
        onToggleFavorite: (article) => _toggleFavorite(context, article),
      ),
    );
  }
}
