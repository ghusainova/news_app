import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/user_model.g.dart';
part 'generated/user_model.freezed.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String firstName,
    required String lastName,
    required String maidenName,
    required int age,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json) =>
      _$UserModelFromJson(json);
}
