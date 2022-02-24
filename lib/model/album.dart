import 'package:json_annotation/json_annotation.dart';

import 'base.dart';

part 'album.g.dart';

/// 相册
@JsonSerializable()
class Album extends Base {

  /// 构造
  Album(this.name, this.description, this.textList, this.photoList, String? id, String? addTimeString, String? modifyTimeString) : super(id, addTimeString, modifyTimeString);

  /// 相册名称
  String? name;
  /// 备注
  String? description;
  /// 文本
  List<String> textList = [];
  /// 照片
  List<String> photoList = [];

  /// 反序列化
  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
  /// 序列化
  Map<String, dynamic> toJson() => _$AlbumToJson(this);

}
