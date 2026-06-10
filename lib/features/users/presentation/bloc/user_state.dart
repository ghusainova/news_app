part of 'user_bloc.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = UsersLoading;
  const factory UserState.loaded(List<UserModel> users) = UsersLoaded;
  const factory UserState.error(String message) = UsersError;
}
