import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/core/widgets/app_state_messages.dart';
import 'package:news_app/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:news_app/features/favorites/presentation/widgets/favorites_articles_list.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  void _requestFavorites(BuildContext context) {
    context.read<FavoritesBloc>().add(const FavoritesEvent.requested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (favorites) => FavoritesArticlesList(favorites: favorites),
          updated: (favorites, _) => FavoritesArticlesList(favorites: favorites),
          empty: (message) => AppRefreshMessage(
            icon: Icons.favorite_border,
            message: message,
            onRefresh: () => _requestFavorites(context),
          ),
          error: (message) => AppRetryMessage(
            message: message,
            onRetry: () => _requestFavorites(context),
          ),
        );
      },
    );
  }
}
