// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
      json['name'] as String?,
      json['description'] as String?,
      (json['textList'] as List<dynamic>).map((e) => e as String).toList(),
      (json['photoList'] as List<dynamic>).map((e) => e as String).toList(),
      json['id'] as String?,
      json['addTimeString'] as String?,
      json['modifyTimeString'] as String?,
    );

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'id': instance.id,
      'addTimeString': instance.addTimeString,
      'modifyTimeString': instance.modifyTimeString,
      'name': instance.name,
      'description': instance.description,
      'textList': instance.textList,
      'photoList': instance.photoList,
    };
