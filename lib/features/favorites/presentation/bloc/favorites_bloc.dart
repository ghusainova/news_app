import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:news_app/core/l10n/strings.dart';

part 'generated/favorites_bloc.freezed.dart';
part 'favorites_event.dart';
part 'favorites_state.dart';

@injectable
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository repository;

  FavoritesBloc({required this.repository})
      : super(const FavoritesState.initial()) {
    on<FavoritesRequested>(_onRequested);
    on<FavoriteToggled>(_onToggled);
    add(const FavoritesEvent.requested());
  }

  Future<void> _onRequested(
    FavoritesRequested event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(const FavoritesState.loading());
    final result = await repository.getFavorites();

    result.when(
      success: (favorites) {
        if (favorites.isEmpty) {
          emit(const FavoritesState.empty(message: AppStrings.noSavedArticles));
          return;
        }
        emit(FavoritesState.loaded(favorites: favorites));
      },
      failure: (failure) {
        emit(FavoritesState.error(message: failure.message));
      },
    );
  }

  Future<void> _onToggled(
    FavoriteToggled event,
    Emitter<FavoritesState> emit,
  ) async {
    final toggleResult = await repository.toggleFavorite(event.article);
    await toggleResult.when(
      success: (added) async {
        final refreshed = await repository.getFavorites();
        refreshed.when(
          success: (favorites) {
            if (favorites.isEmpty) {
              emit(const FavoritesState.empty(message: AppStrings.noSavedArticles));
              return;
            }
            emit(
              FavoritesState.updated(
                favorites: favorites,
                message: added
                    ? AppStrings.addedToFavorites
                    : AppStrings.removedFromFavorites,
              ),
            );
          },
          failure: (failure) => emit(FavoritesState.error(message: failure.message)),
        );
      },
      failure: (failure) async {
        emit(FavoritesState.error(message: failure.message));
      },
    );
  }
}
