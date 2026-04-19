import 'package:news_app/core/l10n/strings.dart';

class NewsCategory {
  final String apiValue;
  final String label;

  const NewsCategory({required this.apiValue, required this.label});
}

class NewsCategories {
  static const List<NewsCategory> all = [
    NewsCategory(apiValue: 'general', label: AppStrings.general),
    NewsCategory(apiValue: 'business', label: AppStrings.business),
    NewsCategory(apiValue: 'entertainment', label: AppStrings.entertainment),
    NewsCategory(apiValue: 'health', label: AppStrings.health),
    NewsCategory(apiValue: 'science', label: AppStrings.science),
    NewsCategory(apiValue: 'sports', label: AppStrings.sports),
    NewsCategory(apiValue: 'technology', label: AppStrings.technology),
  ];
}

