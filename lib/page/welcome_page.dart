import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/config/text_style_config.dart';
import 'package:photo_album/model/album_model.dart';
import 'package:provider/provider.dart';
import 'package:bot_toast/bot_toast.dart';

import '../db/album_service.dart';
import 'album_page_view.dart';

class WelcomePage extends StatefulWidget {
  late bool autoJump;
  WelcomePage({Key? key, required this.autoJump}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // 定时器
  Timer? _timer;
  int albumPageLength = 0;

  // 初始化定时器
  void _initTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      // 跳转
      if(widget.autoJump) {
        goNextPage();
      }
    });
  }

  goNextPage(){
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=> const AlbumPageView()), (route) => false);
  }

  goSelfPage(bool jump){
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=> WelcomePage(autoJump: jump)), (route) => false);
  }

  Future<void> initAlbumService() async {
    await AlbumService.initAlbum();
    if(AlbumService.getAlbumPath().isNotEmpty) {
      goSelfPage(true);
    }
  }

  @override
  void initState() {
    super.initState();

    // 如果路径未设置
    if(AlbumService.getAlbumPath().isEmpty) {
      widget.autoJump = false;
      Future.delayed(Duration.zero, () => initAlbumService());
    }

    // 初始化定时器
    _initTimer();
    debugPrint("_initTimer");
  }

  @override
  void dispose() {
    // 取消定时器
    _timer?.cancel();
    super.dispose();
    debugPrint("_timer cancel");
  }

  Future<void> chooseAlbum() async {
    String? path = await FilePicker.platform.getDirectoryPath();
    if (path == null) {
      return;
    }
    path = path.replaceAll("\\", "/");

    await AlbumService.setAlbumPath(path);
    // 初始化数据
    await AlbumService.initAlbum();
    // 浏览相册
    goSelfPage(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 背景
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("static/image/hard_cover_title_hd.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: double.infinity,
            height: 260,
            color: Colors.white60,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "相册信息",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleConfig.h2,
                    ),
                    Text(
                      "页码：" + context.watch<AlbumViewModel>().albumPageLength().toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleConfig.h4,
                    ),
                    Text(
                      "创建时间：" + context.watch<AlbumViewModel>().albumAddTime(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleConfig.h4,
                    ),
                    Text(
                      "路径：" + context.watch<AlbumViewModel>().albumPath(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleConfig.h4,
                    ),
                    Visibility(
                      visible: !widget.autoJump,
                      child: const SizedBox(height: 20),
                    ),
                    Visibility(
                      visible: !widget.autoJump,
                      child: FloatingActionButton.extended(
                        backgroundColor: Colors.blue,
                        icon: const Icon(Icons.collections_bookmark),
                        heroTag: null,
                        label: const Text("重新选择相册"),
                        onPressed: chooseAlbum,
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: AlbumService.getAlbumPath().isNotEmpty,
                    child: Positioned(
                      right: 32,
                      child: FloatingActionButton(
                        backgroundColor: Colors.deepOrangeAccent,
                        heroTag: null,
                        child: const Icon(Icons.play_circle_outline),
                        tooltip: "立即播放",
                        onPressed: (){
                          // 设置组件页码
                          goNextPage();
                        },
                      ),
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
