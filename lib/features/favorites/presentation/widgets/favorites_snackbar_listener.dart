import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/features/favorites/presentation/bloc/favorites_bloc.dart';

class FavoritesSnackbarListener extends StatelessWidget {
  final Widget child;

  const FavoritesSnackbarListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoritesBloc, FavoritesState>(
      listenWhen: (previous, current) => current.maybeWhen(
        updated: (favorites, message) => true,
        orElse: () => false,
      ),
      listener: (context, state) {
        state.whenOrNull(
          updated: (favorites, message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                duration: const Duration(seconds: 2),
              ),
            );
          },
        );
      },
      child: child,
    );
  }
}
