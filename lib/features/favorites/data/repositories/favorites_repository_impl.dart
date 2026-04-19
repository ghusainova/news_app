import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/error/result.dart';
import 'package:news_app/features/news/data/dto/article_hive_dto.dart';
import 'package:news_app/features/news/data/datasources/news_local_datasource.dart';
import 'package:news_app/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: FavoritesRepository)
class FavoritesRepositoryImpl implements FavoritesRepository {
  final NewsLocalDataSource localDataSource;

  FavoritesRepositoryImpl({required this.localDataSource});

  @override
  Future<Result<bool>> toggleFavorite(Article article) async {
    try {
      final isFavorite = await localDataSource.isFavorite(article.url);
      final dto = ArticleHiveDto(
        title: article.title,
        description: article.description,
        sourceName: article.sourceName,
        url: article.url,
        imageUrl: article.imageUrl,
        publishedAt: article.publishedAt?.toIso8601String() ?? '',
      );

      if (isFavorite) {
        await localDataSource.removeFavorite(article.url);
        return const Result.success(false);
      } else {
        await localDataSource.addFavorite(dto);
        return const Result.success(true);
      }
    } catch (_) {
      return const Result.failure(CacheFailure());
    }
  }

  @override
  Future<Result<List<Article>>> getFavorites() async {
    try {
      final favorites = await localDataSource.getFavorites();
      final articles = favorites
          .map(
            (dto) => Article(
              title: dto.title,
              description: dto.description,
              sourceName: dto.sourceName,
              url: dto.url,
              imageUrl: dto.imageUrl,
              publishedAt: DateTime.tryParse(dto.publishedAt),
            ),
          )
          .toList();

      return Result.success(articles);
    } catch (_) {
      return const Result.failure(CacheFailure());
    }
  }

  @override
  Future<Result<bool>> isFavorite(String url) async {
    try {
      return Result.success(await localDataSource.isFavorite(url));
    } catch (_) {
      return const Result.failure(CacheFailure());
    }
  }
}
