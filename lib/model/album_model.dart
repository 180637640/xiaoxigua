import 'package:flutter/cupertino.dart';
import 'package:photo_album/db/album_service.dart';
import 'package:photo_album/model/album_page.dart';
import 'dart:io';

class AlbumViewModel with ChangeNotifier {

  /// 当前查看相册
  int albumIndex = 0;

  /// 当前查看页面
  int _pageIndex = 0;
  int _textLength = 0;
  int _photoLength = 0;
  final List<String> _photoList = [];

  int get pageIndex => _pageIndex;
  int get pageTotalSize => AlbumService.albumPageList[albumIndex].length;
  int get textLength => _textLength;
  int get photoLength => _photoLength;
  List<String> get photoList => _photoList;

  /// 设置页面文本和图片数量
  void setPageInfo(int pageIndex, int textLength, int photoLength) {
    _pageIndex = pageIndex;
    _textLength = textLength;
    _photoLength = photoLength;
    _photoList.clear();

    int length = AlbumService.albumPageList[albumIndex][_pageIndex].photoList.length;
    for(int i = 0; i < photoLength; i++) {
      _photoList.add("");
      if(i < length) {
        _photoList[i] = AlbumService.albumPageList[albumIndex][_pageIndex].photoList[i];
      }
    }
  }

  void setPhoto(int index, String fileName) {
    photoList[index] = fileName;
  }

  /// 设置页面文本和图片数量
  void saveAlbumIndex(List<String> textList, List<String> photoList) {
    AlbumService.albumPageList[albumIndex][_pageIndex].textList.clear();
    AlbumService.albumPageList[albumIndex][_pageIndex].textList.addAll(textList);
    AlbumService.albumPageList[albumIndex][_pageIndex].photoList.clear();
    AlbumService.albumPageList[albumIndex][_pageIndex].photoList.addAll(photoList);

    // 更新相册
    AlbumService.writeAlbumIndex(albumIndex);
    notifyListeners();
  }

  /// 返回当前页
  AlbumPage albumPage() {
    return AlbumService.albumPageList[albumIndex][_pageIndex];
  }

  /// 返回指定页
  AlbumPage albumPageByIndex(int index) {
    return AlbumService.albumPageList[albumIndex][index];
  }

  /// 获取文本内容
  String albumPageText(int pageIndex, int index, { String defaultString = "请设置此处标题" }) {
    AlbumPage o = albumPageByIndex(pageIndex);
    if(o.textList.length <= index) {
      return defaultString;
    }
    return o.textList[index];
  }

  /// 获取图片内容
  ImageProvider albumPageImage(int pageIndex, int index, { assetName = "static/image/photo.jpg" }) {
    AlbumPage o = albumPageByIndex(pageIndex);
    if(o.photoList.length <= index) {
      return AssetImage(assetName);
    }
    String path = o.photoList[index];
    if(path.isEmpty) {
      return AssetImage(assetName);
    }
    String id = o.albumId as String;
    if(path.startsWith("http:") || path.startsWith("https:")) {
      return NetworkImage(path);
    }
    File file = File(AlbumService.albumPath + "/" + id + "/" + path);
    if(!file.existsSync()) {
      return AssetImage(assetName);
    }
    return FileImage(file);
  }

  /// 返回当前相册页数量
  int albumPageLength() {
    if(AlbumService.albumPageList.isEmpty) {
      return 0;
    }
    return AlbumService.albumPageList[albumIndex].length;
  }

  /// 返回当前相册创建时间
  String albumAddTime() {
    if(AlbumService.albumList.isEmpty) {
      return "";
    }
    String? addTime = AlbumService.albumList[albumIndex].addTimeString;
    return (null == addTime) ? "" : addTime.substring(0, addTime.indexOf("."));
  }

  /// 返回当前相册页数量
  String albumPath() {
    return AlbumService.albumPath;
  }

  /// 强制刷新
  void forceRefresh() {
    notifyListeners();
  }

  /// 添加新一页
  void addAlbumPageAtIndex(String theme) {
    AlbumService.addAlbumPageAtIndex(albumIndex, pageIndex + 1, theme);
    notifyListeners();
  }

  /// 删除当前页
  void removeAlbumPageAtIndex() {
    if(albumPageLength() <= 1) {
      return;
    }
    AlbumService.removeAlbumPageAtIndex(albumIndex, pageIndex);
    notifyListeners();
  }

  /// 下一本
  void nextAlbum() {
    int length = AlbumService.albumList.length - 1;
    if(albumIndex >= length) {
      return;
    }
    albumIndex++;
    notifyListeners();
  }

  /// 上一本
  void prevAlbum() {
    if(albumIndex <= 0) {
      return;
    }
    albumIndex--;
    notifyListeners();
  }

}