import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import 'package:news_app/core/network/dio_client.dart';
import 'package:news_app/features/news/data/dto/article_hive_dto.dart';
import 'package:news_app/features/news/data/datasources/news_api_service.dart';

@module
abstract class DiModule {
  @preResolve
  Future<Box<ArticleHiveDto>> get favoritesBox async {
    await Hive.initFlutter();
    Hive.registerAdapter(ArticleHiveDtoAdapter());
    return Hive.openBox<ArticleHiveDto>('favorites');
  }

  @lazySingleton
  Connectivity get connectivity => Connectivity();

  @lazySingleton
  NewsApiService newsApiService(DioClient client) => NewsApiService(client.dio);
}

