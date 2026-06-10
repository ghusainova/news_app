// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../users_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UsersModelImpl _$$UsersModelImplFromJson(Map<String, dynamic> json) =>
    _$UsersModelImpl(
      users: (json['users'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$UsersModelImplToJson(_$UsersModelImpl instance) =>
    <String, dynamic>{
      'users': instance.users,
    };
