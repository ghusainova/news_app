import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_app/features/news/data/models/source_model.dart';

part 'generated/article_model.freezed.dart';
part 'generated/article_model.g.dart';

@freezed
class ArticleModel with _$ArticleModel {
  const factory ArticleModel({
    @Default('') String title,
    String? description,
    SourceModel? source,
    @Default('') String url,
    String? urlToImage,
    required DateTime publishedAt,
  }) = _ArticleModel;

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
}
