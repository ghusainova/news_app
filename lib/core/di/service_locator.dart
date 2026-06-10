import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/core/di/service_locator.config.dart';

final getIt = GetIt.instance;

@injectableInit
void configureDependencies() => getIt.init();

@module
abstract class AppModule {
  @singleton
  Dio get dio => Dio();
}
