import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/l10n/strings.dart';
import 'package:news_app/features/news/data/datasources/news_local_datasource.dart';
import 'package:news_app/features/news/data/datasources/news_remote_datasource.dart';
import 'package:news_app/features/news/data/models/article_model.dart';
import 'package:news_app/features/news/data/repositories/news_repository_impl.dart';

class _MockRemote extends Mock implements NewsRemoteDataSource {}

class _MockLocal extends Mock implements NewsLocalDataSource {}

void main() {
  group('NewsRepositoryImpl', () {
    late NewsRemoteDataSource remote;
    late NewsLocalDataSource local;
    late NewsRepositoryImpl repository;

    setUp(() {
      remote = _MockRemote();
      local = _MockLocal();
      repository = NewsRepositoryImpl(remote: remote, local: local);
    });

    ArticleModel _model() => ArticleModel(
      title: 't',
      description: 'd',
      source: null,
      url: 'u1',
      urlToImage: '',
      publishedAt: DateTime.parse('2026-01-01T00:00:00Z'),
    );

    test('returns success when remote returns list', () async {
      when(
        () => remote.fetchTopHeadlines(
          country: any(named: 'country'),
          query: any(named: 'query'),
          category: any(named: 'category'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer((_) async => <ArticleModel>[_model()]);

      final result = await repository.getTopHeadlines(query: 'q');

      result.when(
        success: (articles) => expect(articles, hasLength(1)),
        failure: (_) => fail('Expected success'),
      );
    });

    test('maps cancelled DioError to requestCancelled failure', () async {
      final error = DioError(
        requestOptions: RequestOptions(path: '/top-headlines'),
        type: DioErrorType.cancel,
      );

      when(
        () => remote.fetchTopHeadlines(
          country: any(named: 'country'),
          query: any(named: 'query'),
          category: any(named: 'category'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenThrow(error);

      final result = await repository.getTopHeadlines();

      result.when(
        success: (_) => fail('Expected failure'),
        failure: (f) {
          expect(f, isA<UnknownFailure>());
          expect(f.message, AppStrings.requestCancelled);
        },
      );
    });

    test(
      'maps connectTimeout DioError to NetworkFailure(connectTimeout)',
      () async {
        final error = DioError(
          requestOptions: RequestOptions(path: '/top-headlines'),
          type: DioErrorType.connectTimeout,
        );

        when(
          () => remote.fetchTopHeadlines(
            country: any(named: 'country'),
            query: any(named: 'query'),
            category: any(named: 'category'),
            cancelToken: any(named: 'cancelToken'),
          ),
        ).thenThrow(error);

        final result = await repository.getTopHeadlines();

        result.when(
          success: (_) => fail('Expected failure'),
          failure: (f) {
            expect(f, isA<NetworkFailure>());
            expect(f.message, AppStrings.connectTimeout);
          },
        );
      },
    );
  });
}
