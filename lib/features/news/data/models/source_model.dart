import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/source_model.freezed.dart';
part 'generated/source_model.g.dart';

@freezed
class SourceModel with _$SourceModel {
  const factory SourceModel({String? id, String? name}) = _SourceModel;

  factory SourceModel.fromJson(Map<String, dynamic> json) =>
      _$SourceModelFromJson(json);
}
