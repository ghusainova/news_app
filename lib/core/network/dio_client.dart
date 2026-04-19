import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/l10n/strings.dart';
import 'package:news_app/core/network/http_error_message.dart';
import 'error_handling_interceptor.dart';

@lazySingleton
class DioClient {
  late final Dio _dio;

  DioClient({
    @Named('newsBaseUrl') required String baseUrl,
    @Named('newsApiKey') required String apiKey,
    Duration timeout = const Duration(seconds: 30),
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: timeout.inMilliseconds,
        receiveTimeout: timeout.inMilliseconds,
        sendTimeout: timeout.inMilliseconds,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add error handling interceptor
    _dio.interceptors.add(ErrorHandlingInterceptor());

    // Add API key parameter interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add API key to all requests
          options.queryParameters['apiKey'] = apiKey;
          return handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;

  static bool isRequestCancelled(dynamic error) {
    return error is DioError && error.type == DioErrorType.cancel;
  }

  static Failure mapDioError(dynamic error) {
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.connectTimeout:
          return const NetworkFailure(AppStrings.connectTimeout);
        case DioErrorType.sendTimeout:
          return const NetworkFailure(AppStrings.sendTimeout);
        case DioErrorType.receiveTimeout:
          return const NetworkFailure(AppStrings.receiveTimeout);
        case DioErrorType.response:
          final statusCode = error.response?.statusCode;
          final message = HttpErrorMessage.fromStatusCode(statusCode);
          return ServerFailure(message, statusCode: statusCode);
        case DioErrorType.cancel:
          return const UnknownFailure(AppStrings.requestCancelled);
        case DioErrorType.other:
          return const NetworkFailure(AppStrings.networkError);
      }
    } else {
      return UnknownFailure('${AppStrings.unknownError} ${error.toString()}');
    }
  }

}
