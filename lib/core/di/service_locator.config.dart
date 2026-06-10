// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:news_app/core/di/service_locator.dart' as _i10;
import 'package:news_app/features/users/data/datasources/api_client.dart'
    as _i4;
import 'package:news_app/features/users/data/datasources/user_remote_ds.dart'
    as _i5;
import 'package:news_app/features/users/data/repositories/user_repository_impl.dart'
    as _i7;
import 'package:news_app/features/users/domain/repositories/user_repository.dart'
    as _i6;
import 'package:news_app/features/users/domain/usecases/get_users_usecase.dart'
    as _i8;
import 'package:news_app/features/users/presentation/bloc/user_bloc.dart'
    as _i9;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.singleton<_i3.Dio>(() => appModule.dio);
    gh.singleton<_i4.ApiClient>(() => _i4.ApiClient(gh<_i3.Dio>()));
    gh.lazySingleton<_i5.UserRemoteDataSource>(
        () => _i5.UserRemoteDataSourceImpl(apiClient: gh<_i4.ApiClient>()));
    gh.lazySingleton<_i6.UserRepository>(() => _i7.UserRepositoryImpl(
        remoteDataSource: gh<_i5.UserRemoteDataSource>()));
    gh.lazySingleton<_i8.GetUsersUseCase>(
        () => _i8.GetUsersUseCase(gh<_i6.UserRepository>()));
    gh.factory<_i9.UserBloc>(
        () => _i9.UserBloc(getUsersUseCase: gh<_i8.GetUsersUseCase>()));
    return this;
  }
}

class _$AppModule extends _i10.AppModule {}
