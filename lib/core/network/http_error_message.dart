import 'package:news_app/core/l10n/strings.dart';

class HttpErrorMessage {
  static String fromStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return AppStrings.http400;
      case 401:
        return AppStrings.http401;
      case 403:
        return AppStrings.http403;
      case 404:
        return AppStrings.http404;
      case 429:
        return AppStrings.http429;
      case 500:
        return AppStrings.http500;
      case 502:
      case 503:
      case 504:
        return AppStrings.http5xx;
      default:
        return AppStrings.httpUnknown(statusCode);
    }
  }
}

