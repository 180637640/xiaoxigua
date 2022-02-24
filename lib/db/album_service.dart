import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/common/uf.dart';
import 'package:photo_album/model/album.dart';
import 'package:photo_album/model/album_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 相册
class AlbumService {
  static final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static const String albumPathKey = "DB_ALBUM_PATH_KEY";
  static String albumPath = '';
  static List<Album> albumList = [];
  static List<List<AlbumPage>> albumPageList = [];

  /// 获取相册路径
  static Future<String> getAlbumPathFromCache() async {
    SharedPreferences prefs = await _prefs;
    String? path = prefs.getString(albumPathKey);
    return (null == path) ? "" : path;
  }

  /// 获取相册路径
  static String getAlbumPath() {
    return albumPath;
  }

  /// 设置相册路径
  static setAlbumPath(String? path) async {
    if(null == path || path.isEmpty) {
      return;
    }
    // 保存到缓存
    SharedPreferences prefs = await _prefs;
    await prefs.setString(albumPathKey, path);

    albumPath = path;
    albumList = [];
    albumPageList = [];
  }

  /// 样式路径
  static String albumThemePath() {
    return albumPath + "/theme/";
  }

  /// 初始化相册
  static initAlbum() async {
    if(getAlbumPath().isEmpty) {
      // 从缓存读取
      SharedPreferences prefs = await _prefs;
      String? path = prefs.getString(albumPathKey);
      await setAlbumPath(path);

      if(getAlbumPath().isEmpty) {
        return;
      }
    }
    File file = File('$albumPath/index.json');

    if(!file.existsSync()) {
      // 如果文件不存在则创建默认相册
      String id = UF.getRandomId();
      String dateTime = DateTime.now().toString();
      List list = [Album("时光印记", "小西瓜于二〇二〇年一月三日开始留影", [], [], id, dateTime, dateTime)];
      String jsonText = jsonEncode(list);
      await file.writeAsString(jsonText);
      debugPrint("相册初始化:" + jsonText);
    }
    String jsonText = await file.readAsString();
    debugPrint(jsonText);
    List list = jsonDecode(jsonText);
    for(dynamic e in list) {
      albumList.add(Album.fromJson(e as Map<String, dynamic>));
    }

    int index = 0;
    for(Album o in albumList) {
      await readAlbumPage(index++, o.id);
    }
  }

  /// 读取相册页
  static readAlbumPage(int index, String? albumId) async {
    File file = File('$albumPath/$albumId/index.json');
    if(!file.existsSync()) {
      // 如果文件不存在则创建默认相册页
      file.parent.createSync();
      String id = UF.getRandomId();
      String dateTime = DateTime.now().toString();
      List list = [AlbumPage("1", albumId, [], [], id, dateTime, dateTime)];
      String jsonText = jsonEncode(list);
      await file.writeAsString(jsonText);
      debugPrint("相册页初始化:" + jsonText);
    }
    String jsonText = await file.readAsString();
    if(jsonText.isEmpty) {
      jsonText = "[]";
    }
    albumPageList.add([]);
    List list = jsonDecode(jsonText);
    for(dynamic e in list) {
      albumPageList[index].add(AlbumPage.fromJson(e as Map<String, dynamic>));
    }
    // 如果为空 则默认一条数据
    if(albumPageList[index].isEmpty) {
      String id = UF.getRandomId();
      String dateTime = DateTime.now().toString();
      albumPageList[index].add(AlbumPage("1", albumId, [], [], id, dateTime, dateTime));
    }
    debugPrint("initAlbumPage ok");
  }

  /// 回写相册索引
  static writeAlbumIndex(int albumIndex) async {
    String? albumId = albumList[albumIndex].id;
    File file = File('$albumPath/$albumId/index.json');
    List list = albumPageList[albumIndex];

    if(!file.existsSync()) {
      // 如果文件不存在则创建默认相册页
      file.parent.createSync();
    }

    String jsonText = jsonEncode(list);
    if(jsonText.isEmpty) {
      jsonText = "[]";
    }
    await file.writeAsString(jsonText);
  }

  /// 在当前位置插入页
  static addAlbumPageAtIndex(int albumIndex, int pageIndex, String theme) async {
    String id = UF.getRandomId();
    String dateTime = DateTime.now().toString();

    String? albumId = albumList[albumIndex].id;
    if(pageIndex >= albumPageList[albumIndex].length) {
      albumPageList[albumIndex].add(AlbumPage(theme, albumId, [], [], id, dateTime, dateTime));
    } else {
      albumPageList[albumIndex].insert(pageIndex, AlbumPage(theme, albumId, [], [], id, dateTime, dateTime));
    }
    String jsonText = jsonEncode(albumPageList[albumIndex]);

    File file = File('$albumPath/$albumId/index.json');
    await file.writeAsString(jsonText);
  }

  /// 删除当前页
  static removeAlbumPageAtIndex(int albumIndex, int pageIndex) async {
    if(pageIndex >= albumPageList[albumIndex].length) {
      return;
    }
    String? albumId = albumList[albumIndex].id;
    albumPageList[albumIndex].removeAt(pageIndex);
    String jsonText = jsonEncode(albumPageList[albumIndex]);

    File file = File('$albumPath/$albumId/index.json');
    await file.writeAsString(jsonText);
  }

  /// 上传文件
  static String uploadFile(String? albumId, File file) {
    String path = file.path;
    String extName = path.substring(path.lastIndexOf("."));
    String newFileName = UF.getRandomId() + extName;
    file.copySync(albumPath + "/$albumId" + "/$newFileName");
    debugPrint("uploadFile:" + newFileName);
    return newFileName;
  }

}
