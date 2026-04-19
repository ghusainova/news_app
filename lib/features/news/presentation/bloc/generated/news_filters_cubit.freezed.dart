// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../news_filters_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NewsFiltersState {
  String get query => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NewsFiltersStateCopyWith<NewsFiltersState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsFiltersStateCopyWith<$Res> {
  factory $NewsFiltersStateCopyWith(
          NewsFiltersState value, $Res Function(NewsFiltersState) then) =
      _$NewsFiltersStateCopyWithImpl<$Res, NewsFiltersState>;
  @useResult
  $Res call({String query, String? category});
}

/// @nodoc
class _$NewsFiltersStateCopyWithImpl<$Res, $Val extends NewsFiltersState>
    implements $NewsFiltersStateCopyWith<$Res> {
  _$NewsFiltersStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? category = freezed,
  }) {
    return _then(_value.copyWith(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewsFiltersStateImplCopyWith<$Res>
    implements $NewsFiltersStateCopyWith<$Res> {
  factory _$$NewsFiltersStateImplCopyWith(_$NewsFiltersStateImpl value,
          $Res Function(_$NewsFiltersStateImpl) then) =
      __$$NewsFiltersStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String query, String? category});
}

/// @nodoc
class __$$NewsFiltersStateImplCopyWithImpl<$Res>
    extends _$NewsFiltersStateCopyWithImpl<$Res, _$NewsFiltersStateImpl>
    implements _$$NewsFiltersStateImplCopyWith<$Res> {
  __$$NewsFiltersStateImplCopyWithImpl(_$NewsFiltersStateImpl _value,
      $Res Function(_$NewsFiltersStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? category = freezed,
  }) {
    return _then(_$NewsFiltersStateImpl(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$NewsFiltersStateImpl implements _NewsFiltersState {
  const _$NewsFiltersStateImpl({this.query = '', this.category});

  @override
  @JsonKey()
  final String query;
  @override
  final String? category;

  @override
  String toString() {
    return 'NewsFiltersState(query: $query, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsFiltersStateImpl &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query, category);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsFiltersStateImplCopyWith<_$NewsFiltersStateImpl> get copyWith =>
      __$$NewsFiltersStateImplCopyWithImpl<_$NewsFiltersStateImpl>(
          this, _$identity);
}

abstract class _NewsFiltersState implements NewsFiltersState {
  const factory _NewsFiltersState(
      {final String query, final String? category}) = _$NewsFiltersStateImpl;

  @override
  String get query;
  @override
  String? get category;
  @override
  @JsonKey(ignore: true)
  _$$NewsFiltersStateImplCopyWith<_$NewsFiltersStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
