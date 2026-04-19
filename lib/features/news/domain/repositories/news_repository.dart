import 'package:dio/dio.dart';

import 'package:news_app/core/error/result.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

abstract class NewsRepository {
  Future<Result<List<Article>>> getTopHeadlines({
    String country = 'us',
    String? query,
    String? category,
    CancelToken? cancelToken,
  });
}
