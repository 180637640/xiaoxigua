
import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/model/album_model.dart';
import 'package:photo_album/page/welcome_page.dart';
import 'package:provider/provider.dart';

import 'common/uf.dart';
import 'db/album_service.dart';

Future<void> main() async {
  /*final width = window.physicalSize.width;
  final height = window.physicalSize.height;
  if(height > width) {
    // 强制横屏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
  }*/

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AlbumViewModel()),
        ],
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Album Theme Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: BotToastInit(),
      // debugShowCheckedModeBanner: false,
      home: WelcomePage(autoJump: true),
    );
  }
}
