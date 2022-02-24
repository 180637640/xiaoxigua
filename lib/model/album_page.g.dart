// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumPage _$AlbumPageFromJson(Map<String, dynamic> json) => AlbumPage(
      json['theme'] as String?,
      json['albumId'] as String?,
      (json['textList'] as List<dynamic>).map((e) => e as String).toList(),
      (json['photoList'] as List<dynamic>).map((e) => e as String).toList(),
      json['id'] as String?,
      json['addTimeString'] as String?,
      json['modifyTimeString'] as String?,
    );

Map<String, dynamic> _$AlbumPageToJson(AlbumPage instance) => <String, dynamic>{
      'id': instance.id,
      'addTimeString': instance.addTimeString,
      'modifyTimeString': instance.modifyTimeString,
      'theme': instance.theme,
      'albumId': instance.albumId,
      'textList': instance.textList,
      'photoList': instance.photoList,
    };
