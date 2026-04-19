// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../article_hive_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArticleHiveDtoAdapter extends TypeAdapter<ArticleHiveDto> {
  @override
  final int typeId = 0;

  @override
  ArticleHiveDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArticleHiveDto(
      title: fields[0] as String,
      description: fields[1] as String,
      sourceName: fields[2] as String,
      url: fields[3] as String,
      imageUrl: fields[4] as String,
      publishedAt: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ArticleHiveDto obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.sourceName)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.publishedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticleHiveDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
