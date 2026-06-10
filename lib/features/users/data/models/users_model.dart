import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_app/features/users/data/models/user_model.dart';

part 'generated/users_model.g.dart';
part 'generated/users_model.freezed.dart';

@freezed
class UsersModel with _$UsersModel {
  const factory UsersModel({required List<UserModel> users}) = _UsersModel;

  factory UsersModel.fromJson(Map<String, Object?> json) =>
      _$UsersModelFromJson(json);
}
