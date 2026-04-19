import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/presentation/pages/news_detail_page.dart';

class ArticleDetailsNavigator {
  const ArticleDetailsNavigator();

  void open(BuildContext context, Article article) {
    final favoritesBloc = context.read<FavoritesBloc>();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: favoritesBloc,
          child: NewsDetailPage(article: article),
        ),
      ),
    );
  }
}
