import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../dto/article_hive_dto.dart';

abstract class NewsLocalDataSource {
  Future<void> addFavorite(ArticleHiveDto article);
  Future<void> removeFavorite(String url);
  Future<List<ArticleHiveDto>> getFavorites();
  Future<bool> isFavorite(String url);
}

@LazySingleton(as: NewsLocalDataSource)
class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  final Box<ArticleHiveDto> box;

  NewsLocalDataSourceImpl({required this.box});

  @override
  Future<void> addFavorite(ArticleHiveDto article) async {
    await box.put(article.url, article);
  }

  @override
  Future<List<ArticleHiveDto>> getFavorites() async {
    return box.values.toList();
  }

  @override
  Future<bool> isFavorite(String url) async {
    return box.containsKey(url);
  }

  @override
  Future<void> removeFavorite(String url) async {
    await box.delete(url);
  }
}
