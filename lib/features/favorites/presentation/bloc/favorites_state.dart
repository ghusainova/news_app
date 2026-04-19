part of 'favorites_bloc.dart';

@freezed
class FavoritesState with _$FavoritesState {
  const factory FavoritesState.initial() = _Initial;

  const factory FavoritesState.loading() = _Loading;

  const factory FavoritesState.loaded({
    required List<Article> favorites,
  }) = _Loaded;

  const factory FavoritesState.updated({
    required List<Article> favorites,
    required String message,
  }) = _Updated;

  const factory FavoritesState.empty({
    required String message,
  }) = _Empty;

  const factory FavoritesState.error({
    required String message,
  }) = _Error;
}
