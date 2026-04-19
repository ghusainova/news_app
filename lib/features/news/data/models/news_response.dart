import 'package:freezed_annotation/freezed_annotation.dart';

import 'article_model.dart';

part 'generated/news_response.freezed.dart';
part 'generated/news_response.g.dart';

@freezed
class NewsResponse with _$NewsResponse {
  const factory NewsResponse({
    required String status,
    required int totalResults,
    required List<ArticleModel>? articles,
  }) = _NewsResponse;

  factory NewsResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsResponseFromJson(json);
}
