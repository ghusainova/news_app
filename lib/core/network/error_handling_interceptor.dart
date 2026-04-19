import 'package:dio/dio.dart';
import 'package:news_app/core/l10n/strings.dart';
import 'package:news_app/core/network/http_error_message.dart';

class ErrorHandlingInterceptor extends Interceptor {
  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    final normalizedError = _normalizeError(err);
    return handler.reject(normalizedError);
  }

  DioError _normalizeError(DioError error) {
    late String message;

    if (error.type == DioErrorType.connectTimeout) {
      message = AppStrings.connectTimeout;
    } else if (error.type == DioErrorType.sendTimeout) {
      message = AppStrings.sendTimeout;
    } else if (error.type == DioErrorType.receiveTimeout) {
      message = AppStrings.receiveTimeout;
    } else if (error.type == DioErrorType.response) {
      message = HttpErrorMessage.fromStatusCode(error.response?.statusCode);
    } else if (error.type == DioErrorType.cancel) {
      message = AppStrings.requestCancelled;
    } else if (error.type == DioErrorType.other) {
      message = AppStrings.networkError;
    } else {
      message = AppStrings.unknownError;
    }

    return DioError(
      requestOptions: error.requestOptions,
      type: error.type,
      error: message,
      response: error.response,
    );
  }
}
