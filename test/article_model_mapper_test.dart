import 'package:flutter_test/flutter_test.dart';

import 'package:news_app/core/l10n/strings.dart';
import 'package:news_app/features/news/data/mappers/article_model_mapper.dart';
import 'package:news_app/features/news/data/models/article_model.dart';

void main() {
  test('ArticleModelMapper uses fallbacks for missing fields', () {
    final model = ArticleModel(
      title: '',
      description: null,
      source: null,
      url: '',
      urlToImage: null,
      publishedAt: DateTime.parse('2026-01-01T12:00:00Z'),
    );

    final entity = model.toEntity();

    expect(entity.title, AppStrings.untitledArticle);
    expect(entity.description, '');
    expect(entity.sourceName, AppStrings.unknownSource);
    expect(entity.url, '');
    expect(entity.imageUrl, '');
    expect(entity.publishedAt, model.publishedAt);
  });
}

