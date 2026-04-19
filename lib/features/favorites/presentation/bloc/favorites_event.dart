part of 'favorites_bloc.dart';

@freezed
class FavoritesEvent with _$FavoritesEvent {
  const factory FavoritesEvent.requested() = FavoritesRequested;

  const factory FavoritesEvent.toggled({
    required Article article,
  }) = FavoriteToggled;
}
