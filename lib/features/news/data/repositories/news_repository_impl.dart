import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/error/result.dart';
import 'package:news_app/core/l10n/strings.dart';
import 'package:news_app/core/network/dio_client.dart';
import 'package:news_app/features/news/data/datasources/news_local_datasource.dart';
import 'package:news_app/features/news/data/datasources/news_remote_datasource.dart';
import 'package:news_app/features/news/data/mappers/article_model_mapper.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';
import 'package:news_app/features/news/domain/entities/article.dart' as domain;

@LazySingleton(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remote;
  final NewsLocalDataSource local;

  NewsRepositoryImpl({required this.remote, required this.local});

  @override
  Future<Result<List<domain.Article>>> getTopHeadlines({
    String country = 'us',
    String? query,
    String? category,
    CancelToken? cancelToken,
  }) async {
    try {
      final remoteArticles = await remote.fetchTopHeadlines(
        country: country,
        query: query,
        category: category,
        cancelToken: cancelToken,
      );

      final articles = remoteArticles.map((model) => model.toEntity()).toList();

      return Result.success(articles);
    } catch (error) {
      if (DioClient.isRequestCancelled(error)) {
        return const Result.failure(
          UnknownFailure(AppStrings.requestCancelled),
        );
      }
      return Result.failure(DioClient.mapDioError(error));
    }
  }
}
