import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/core/di/injection.dart' as di;
import 'package:news_app/core/l10n/strings.dart';
import 'package:news_app/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:news_app/features/favorites/presentation/pages/favorites_page.dart';
import 'package:news_app/features/favorites/presentation/widgets/favorites_snackbar_listener.dart';
import 'package:news_app/features/news/presentation/bloc/news_bloc.dart';
import 'package:news_app/features/news/presentation/pages/news_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  static const List<String> _titles = [
    AppStrings.newsTitle,
    AppStrings.favoritesTitle,
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoritesBloc>(
      create: (_) => di.getIt<FavoritesBloc>(),
      child: FavoritesSnackbarListener(
        child: Scaffold(
          appBar: AppBar(title: Text(_titles[_selectedIndex])),
          body: IndexedStack(
            index: _selectedIndex,
            children: const [
              _NewsTab(),
              _FavoritesTab(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onTap,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.newspaper),
                label: AppStrings.navNews,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: AppStrings.navFavorites,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NewsTab extends StatelessWidget {
  const _NewsTab();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsBloc>(
      create: (_) => di.getIt<NewsBloc>(),
      child: const NewsPage(),
    );
  }
}

class _FavoritesTab extends StatelessWidget {
  const _FavoritesTab();

  @override
  Widget build(BuildContext context) {
    return const FavoritesPage();
  }
}

