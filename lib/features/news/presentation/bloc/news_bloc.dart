import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/l10n/strings.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/usecases/get_top_headlines.dart';

part 'generated/news_bloc.freezed.dart';
part 'news_event.dart';
part 'news_state.dart';

@injectable
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetTopHeadlines getTopHeadlines;
  CancelToken? _currentRequest;

  NewsBloc({required this.getTopHeadlines}) : super(const NewsState.initial()) {
    on<NewsRequested>(_onRequested);
    on<NewsRefreshed>(_onRefreshed);
    add(const NewsEvent.requested());
  }

  Future<void> _onRequested(
    NewsRequested event,
    Emitter<NewsState> emit,
  ) async {

    await _fetchAndEmit(
      emit: emit,
      country: event.country,
      query: event.query,
      category: event.category,
    );
  }

  Future<void> _onRefreshed(
    NewsRefreshed event,
    Emitter<NewsState> emit,
  ) async {
    await _fetchAndEmit(
      emit: emit,
      country: event.country,
      query: event.query,
      category: event.category,
      cancelReason: 'Refreshing',
    );
  }

  Future<void> _fetchAndEmit({
    required Emitter<NewsState> emit,
    required String country,
    required String? query,
    required String? category,
    String cancelReason = 'Cancelled by a new request',
  }) async {
    _currentRequest?.cancel(cancelReason);
    _currentRequest = CancelToken();

    emit(const NewsState.loading());

    final result = await getTopHeadlines(
      country: country,
      query: query,
      category: category,
      cancelToken: _currentRequest,
    );

    result.when(
      success: (articles) {
        if (articles.isEmpty) {
          emit(const NewsState.empty(message: AppStrings.noNewsAvailable));
          return;
        }
        emit(NewsState.loaded(articles: articles));
      },
      failure: (failure) {
        if (failure is UnknownFailure &&
            failure.message == AppStrings.requestCancelled) {
          return;
        }
        emit(NewsState.error(message: failure.message));
      },
    );
  }

  @override
  Future<void> close() {
    _currentRequest?.cancel('Bloc disposed');
    return super.close();
  }
}
