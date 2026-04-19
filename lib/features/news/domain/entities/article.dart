import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/article.freezed.dart';

@freezed
class Article with _$Article {
  const Article._();

  const factory Article({
    required String title,
    required String description,
    required String sourceName,
    required String url,
    required String imageUrl,
    DateTime? publishedAt,
  }) = _Article;

  /// Checks if the article has a valid image
  bool get hasValidImage {
    if (imageUrl.trim().isEmpty) return false;
    final parsed = Uri.tryParse(imageUrl);
    return parsed != null && parsed.hasScheme;
  }

  /// Get formatted publish date (e.g., "10 Apr 2024")
  String? get formattedDate {
    final value = publishedAt;
    if (value == null) return null;
    final day = value.day;
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    final month = months[value.month - 1];
    final year = value.year;
    return '$day $month $year';
  }
}
