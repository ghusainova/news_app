import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/news_response.dart';

part 'generated/news_api_service.g.dart';

@RestApi(
  baseUrl: String.fromEnvironment(
    'NEWS_API_BASE_URL',
    defaultValue: 'https://newsapi.org/v2',
  ),
)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;

  @GET('/top-headlines')
  Future<NewsResponse> fetchTopHeadlines(
    @Query('country') String country,
    @Query('pageSize') int pageSize,
    @Query('q') String? query,
    @Query('category') String? category,
  );
}
