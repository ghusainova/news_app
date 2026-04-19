part of 'news_bloc.dart';

@freezed
class NewsEvent with _$NewsEvent {
  const factory NewsEvent.requested({
    @Default('us') String country,
    String? query,
    String? category,
  }) = NewsRequested;

  const factory NewsEvent.refreshed({
    @Default('us') String country,
    String? query,
    String? category,
  }) = NewsRefreshed;
}

