import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:news_app/core/error/result.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

@lazySingleton
class GetTopHeadlines {
  final NewsRepository repository;

  GetTopHeadlines(this.repository);

  Future<Result<List<Article>>> call({
    String country = 'us',
    String? query,
    String? category,
    CancelToken? cancelToken,
  }) {
    return repository.getTopHeadlines(
      country: country,
      query: query,
      category: category,
      cancelToken: cancelToken,
    );
  }
}
