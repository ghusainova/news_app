import 'package:hive/hive.dart';
import 'package:news_app/core/l10n/strings.dart';

part 'generated/article_hive_dto.g.dart';

@HiveType(typeId: 0)
class ArticleHiveDto extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  String sourceName;

  @HiveField(3)
  String url;

  @HiveField(4)
  String imageUrl;

  @HiveField(5)
  String publishedAt;

  ArticleHiveDto({
    required this.title,
    required this.description,
    required this.sourceName,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
  });

  factory ArticleHiveDto.fromMap(Map<String, dynamic> json) {
    return ArticleHiveDto(
      title: json['title'] as String? ?? AppStrings.untitledArticle,
      description: json['description'] as String? ?? '',
      sourceName: json['sourceName'] as String? ?? AppStrings.unknownSource,
      url: json['url'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      publishedAt: json['publishedAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'sourceName': sourceName,
      'url': url,
      'imageUrl': imageUrl,
      'publishedAt': publishedAt,
    };
  }
}
