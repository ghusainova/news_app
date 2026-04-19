// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i9;
import 'package:hive_flutter/hive_flutter.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:news_app/core/di/di_module.dart' as _i18;
import 'package:news_app/core/network/dio_client.dart' as _i6;
import 'package:news_app/features/favorites/data/repositories/favorites_repository_impl.dart'
    as _i14;
import 'package:news_app/features/favorites/domain/repositories/favorites_repository.dart'
    as _i13;
import 'package:news_app/features/favorites/presentation/bloc/favorites_bloc.dart'
    as _i17;
import 'package:news_app/features/news/data/datasources/news_api_service.dart'
    as _i7;
import 'package:news_app/features/news/data/datasources/news_local_datasource.dart'
    as _i8;
import 'package:news_app/features/news/data/datasources/news_remote_datasource.dart'
    as _i10;
import 'package:news_app/features/news/data/dto/article_hive_dto.dart' as _i4;
import 'package:news_app/features/news/data/repositories/news_repository_impl.dart'
    as _i12;
import 'package:news_app/features/news/domain/repositories/news_repository.dart'
    as _i11;
import 'package:news_app/features/news/domain/usecases/get_top_headlines.dart'
    as _i15;
import 'package:news_app/features/news/presentation/bloc/news_bloc.dart'
    as _i16;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final diModule = _$DiModule();
    await gh.factoryAsync<_i3.Box<_i4.ArticleHiveDto>>(
      () => diModule.favoritesBox,
      preResolve: true,
    );
    gh.lazySingleton<_i5.Connectivity>(() => diModule.connectivity);
    gh.lazySingleton<_i6.DioClient>(() => _i6.DioClient(
          baseUrl: gh<String>(instanceName: 'newsBaseUrl'),
          apiKey: gh<String>(instanceName: 'newsApiKey'),
          timeout: gh<Duration>(),
        ));
    gh.lazySingleton<_i7.NewsApiService>(
        () => diModule.newsApiService(gh<_i6.DioClient>()));
    gh.lazySingleton<_i8.NewsLocalDataSource>(() =>
        _i8.NewsLocalDataSourceImpl(box: gh<_i9.Box<_i4.ArticleHiveDto>>()));
    gh.lazySingleton<_i10.NewsRemoteDataSource>(() =>
        _i10.NewsRemoteDataSourceImpl(apiService: gh<_i7.NewsApiService>()));
    gh.lazySingleton<_i11.NewsRepository>(() => _i12.NewsRepositoryImpl(
          remote: gh<_i10.NewsRemoteDataSource>(),
          local: gh<_i8.NewsLocalDataSource>(),
        ));
    gh.lazySingleton<_i13.FavoritesRepository>(() =>
        _i14.FavoritesRepositoryImpl(
            localDataSource: gh<_i8.NewsLocalDataSource>()));
    gh.lazySingleton<_i15.GetTopHeadlines>(
        () => _i15.GetTopHeadlines(gh<_i11.NewsRepository>()));
    gh.factory<_i16.NewsBloc>(
        () => _i16.NewsBloc(getTopHeadlines: gh<_i15.GetTopHeadlines>()));
    gh.factory<_i17.FavoritesBloc>(
        () => _i17.FavoritesBloc(repository: gh<_i13.FavoritesRepository>()));
    return this;
  }
}

class _$DiModule extends _i18.DiModule {}
