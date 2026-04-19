import 'package:freezed_annotation/freezed_annotation.dart';

import 'failure.dart';

part 'generated/result.freezed.dart';

@freezed
sealed class Result<T> with _$Result<T> {
  const factory Result.success(T value) = _Success<T>;
  const factory Result.failure(Failure failure) = _Failure<T>;
}
