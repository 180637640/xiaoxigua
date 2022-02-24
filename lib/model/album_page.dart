import 'package:json_annotation/json_annotation.dart';
import 'base.dart';

part 'album_page.g.dart';

/// 相册页
@JsonSerializable()
class AlbumPage extends Base {

  /// 构造
  AlbumPage(this.theme, this.albumId, this.textList, this.photoList, String? id, String? addTimeString, String? modifyTimeString) : super(id, addTimeString, modifyTimeString);

  /// 主题
  String? theme;
  /// 相册ID
  String? albumId;
  /// 文本
  List<String> textList = [];
  /// 照片
  List<String> photoList = [];

  /// 反序列化
  factory AlbumPage.fromJson(Map<String, dynamic> json) => _$AlbumPageFromJson(json);
  /// 序列化
  Map<String, dynamic> toJson() => _$AlbumPageToJson(this);

}
