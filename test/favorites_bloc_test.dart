import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/error/result.dart';
import 'package:news_app/core/l10n/strings.dart';
import 'package:news_app/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:news_app/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

class _MockFavoritesRepository extends Mock implements FavoritesRepository {}

void main() {
  group('FavoritesBloc', () {
    late FavoritesRepository repository;

    setUp(() {
      repository = _MockFavoritesRepository();
    });

    test('emits empty when repository returns empty list', () async {
      when(
        () => repository.getFavorites(),
      ).thenAnswer((_) async => const Result.success(<Article>[]));

      final bloc = FavoritesBloc(repository: repository);

      await expectLater(
        bloc.stream,
        emitsInOrder([
          const FavoritesState.loading(),
          const FavoritesState.empty(message: AppStrings.noSavedArticles),
        ]),
      );

      await bloc.close();
    });

    test('emits error when repository fails', () async {
      when(
        () => repository.getFavorites(),
      ).thenAnswer((_) async => const Result.failure(CacheFailure('boom')));

      final bloc = FavoritesBloc(repository: repository);

      await expectLater(
        bloc.stream,
        emitsInOrder([
          const FavoritesState.loading(),
          const FavoritesState.error(message: 'boom'),
        ]),
      );

      await bloc.close();
    });
  });
}
