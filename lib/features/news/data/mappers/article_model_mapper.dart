import '../models/article_model.dart';
import '../../domain/entities/article.dart' as domain;
import 'package:news_app/core/l10n/strings.dart';

extension ArticleModelMapper on ArticleModel {
  domain.Article toEntity() => domain.Article(
    title: title.isNotEmpty ? title : AppStrings.untitledArticle,
    description: description ?? '',
    sourceName: source?.name ?? AppStrings.unknownSource,
    url: url.isNotEmpty ? url : '',
    imageUrl: urlToImage ?? '',
    publishedAt: publishedAt,
  );
}
