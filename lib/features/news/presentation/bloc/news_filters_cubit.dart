import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:news_app/features/news/presentation/bloc/news_bloc.dart';

part 'generated/news_filters_cubit.freezed.dart';

@freezed
class NewsFiltersState with _$NewsFiltersState {
  const factory NewsFiltersState({
    @Default('') String query,
    String? category,
  }) = _NewsFiltersState;
}

class NewsFiltersCubit extends Cubit<NewsFiltersState> {
  final NewsBloc newsBloc;

  NewsFiltersCubit({required this.newsBloc})
      : super(const NewsFiltersState());

  void setQuery(String value) => emit(state.copyWith(query: value));

  void setCategory(String? value) => emit(state.copyWith(category: value));

  void submit() {
    final trimmed = state.query.trim();
    newsBloc.add(
      NewsEvent.requested(
        query: trimmed.isEmpty ? null : trimmed,
        category: state.category,
      ),
    );
  }

  void refresh() {
    final trimmed = state.query.trim();
    newsBloc.add(
      NewsEvent.refreshed(
        query: trimmed.isEmpty ? null : trimmed,
        category: state.category,
      ),
    );
  }
}

