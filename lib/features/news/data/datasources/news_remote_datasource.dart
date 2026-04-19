import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../models/article_model.dart';
import 'news_api_service.dart';

abstract class NewsRemoteDataSource {
  Future<List<ArticleModel>> fetchTopHeadlines({
    String country = 'us',
    String? query,
    String? category,
    CancelToken? cancelToken,
  });
}

@LazySingleton(as: NewsRemoteDataSource)
class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final NewsApiService apiService;

  NewsRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<ArticleModel>> fetchTopHeadlines({
    String country = 'us',
    String? query,
    String? category,
    CancelToken? cancelToken,
  }) async {
    final response = await apiService.fetchTopHeadlines(
      country,
      20,
      query,
      category,
    );

    return response.articles ?? <ArticleModel>[];
  }
}
