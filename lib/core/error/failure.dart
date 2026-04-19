abstract class Failure {
  final String message;

  const Failure(this.message);

  @override
  String toString() => 'Failure(message: $message)';
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection.']);
}

class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure(super.message, {this.statusCode});
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Local storage error.']);
}

class RateLimitFailure extends Failure {
  const RateLimitFailure([
    super.message = 'Rate limit exceeded. Please try again later.',
  ]);
}

class UnknownFailure extends Failure {
  const UnknownFailure([
    super.message = 'An unknown error occurred. Please try again.',
  ]);
}

class EmptyDataFailure extends Failure {
  const EmptyDataFailure([super.message = 'No data available.']);
}
