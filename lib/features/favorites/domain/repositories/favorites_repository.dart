import 'package:news_app/core/error/result.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

abstract class FavoritesRepository {
  Future<Result<List<Article>>> getFavorites();
  /// Returns true if the article was added, false if it was removed.
  Future<Result<bool>> toggleFavorite(Article article);
  Future<Result<bool>> isFavorite(String url);
}
