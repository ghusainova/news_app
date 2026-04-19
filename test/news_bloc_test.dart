import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/error/result.dart';
import 'package:news_app/core/l10n/strings.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/usecases/get_top_headlines.dart';
import 'package:news_app/features/news/presentation/bloc/news_bloc.dart';

class _MockGetTopHeadlines extends Mock implements GetTopHeadlines {}

void main() {
  group('NewsBloc', () {
    late GetTopHeadlines getTopHeadlines;

    setUp(() {
      getTopHeadlines = _MockGetTopHeadlines();
    });

    Article _article(String url) => Article(
          title: 't',
          description: 'd',
          sourceName: 's',
          url: url,
          imageUrl: '',
          publishedAt: DateTime.parse('2026-01-01T00:00:00Z'),
        );

    test('emits loading then loaded when usecase returns articles', () async {
      when(
        () => getTopHeadlines(
          country: any(named: 'country'),
          query: any(named: 'query'),
          category: any(named: 'category'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer(
        (_) async => Result.success(<Article>[_article('u1')]),
      );

      final bloc = NewsBloc(getTopHeadlines: getTopHeadlines);

      await expectLater(
        bloc.stream,
        emitsInOrder([
          const NewsState.loading(),
          isA<NewsState>().having(
            (s) => s.maybeWhen(loaded: (a) => a.length, orElse: () => -1),
            'loaded articles length',
            1,
          ),
        ]),
      );

      await bloc.close();
    });

    test('emits loading then empty when usecase returns empty list', () async {
      when(
        () => getTopHeadlines(
          country: any(named: 'country'),
          query: any(named: 'query'),
          category: any(named: 'category'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer((_) async => const Result.success(<Article>[]));

      final bloc = NewsBloc(getTopHeadlines: getTopHeadlines);

      await expectLater(
        bloc.stream,
        emitsInOrder([
          const NewsState.loading(),
          const NewsState.empty(message: AppStrings.noNewsAvailable),
        ]),
      );

      await bloc.close();
    });

    test('emits loading then error when usecase fails', () async {
      when(
        () => getTopHeadlines(
          country: any(named: 'country'),
          query: any(named: 'query'),
          category: any(named: 'category'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer((_) async => const Result.failure(ServerFailure('boom')));

      final bloc = NewsBloc(getTopHeadlines: getTopHeadlines);

      await expectLater(
        bloc.stream,
        emitsInOrder([
          const NewsState.loading(),
          const NewsState.error(message: 'boom'),
        ]),
      );

      await bloc.close();
    });

    test('does not emit error for cancelled requests (double requested)', () async {
      final firstCompleter = Completer<Result<List<Article>>>();
      final secondCompleter = Completer<Result<List<Article>>>();
      var callCount = 0;

      when(
        () => getTopHeadlines(
          country: any(named: 'country'),
          query: any(named: 'query'),
          category: any(named: 'category'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer((_) {
        callCount += 1;
        return callCount == 1 ? firstCompleter.future : secondCompleter.future;
      });

      final bloc = NewsBloc(getTopHeadlines: getTopHeadlines);

      final expectation = expectLater(
        bloc.stream,
        emitsInOrder([
          const NewsState.loading(),
          isA<NewsState>().having(
            (s) => s.maybeWhen(loaded: (a) => a.single.url, orElse: () => ''),
            'loaded url',
            'u2',
          ),
        ]),
      );

      // Trigger a second request while the first is still in-flight.
      bloc.add(const NewsEvent.requested(query: 'new'));

      // First completes as "cancelled". Bloc should ignore it (no error emission).
      firstCompleter.complete(
        const Result.failure(UnknownFailure(AppStrings.requestCancelled)),
      );
      // Second succeeds.
      secondCompleter.complete(Result.success(<Article>[_article('u2')]));

      await expectation;
      await bloc.close();
    });

    test('passes a CancelToken to usecase and cancels on close', () async {
      final receivedTokens = <CancelToken?>[];

      when(
        () => getTopHeadlines(
          country: any(named: 'country'),
          query: any(named: 'query'),
          category: any(named: 'category'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer((invocation) async {
        receivedTokens.add(invocation.namedArguments[#cancelToken] as CancelToken?);
        return const Result.success(<Article>[]);
      });

      final bloc = NewsBloc(getTopHeadlines: getTopHeadlines);

      // Consume the first two states (loading -> empty).
      await expectLater(
        bloc.stream,
        emitsInOrder([
          const NewsState.loading(),
          const NewsState.empty(message: AppStrings.noNewsAvailable),
        ]),
      );

      expect(receivedTokens, isNotEmpty);
      expect(receivedTokens.first, isA<CancelToken>());

      await bloc.close();

      // Token should be cancelled when bloc is disposed.
      expect(receivedTokens.first!.isCancelled, isTrue);
    });
  });
}

