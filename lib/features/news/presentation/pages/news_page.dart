import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/features/news/presentation/bloc/news_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/news_filters_cubit.dart';
import 'package:news_app/features/news/presentation/widgets/news_app_bar.dart';
import 'package:news_app/features/news/presentation/widgets/news_body.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsFiltersCubit>(
      create: (context) => NewsFiltersCubit(newsBloc: context.read<NewsBloc>()),
      child: const Scaffold(
        appBar: NewsAppBar(),
        body: NewsBody(),
      ),
    );
  }
}
