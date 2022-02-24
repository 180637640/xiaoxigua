
import 'package:flutter/material.dart';
import 'package:photo_album/config/text_style_config.dart';
import 'package:photo_album/model/album_model.dart';
import 'package:provider/provider.dart';

class ThemePage1 extends StatefulWidget {
  static const int textLength = 2;
  static const int photoLength = 2;

  final int albumPageIndex;
  const ThemePage1({Key? key, required this.albumPageIndex}) : super(key: key);

  @override
  _ThemePage1State createState() => _ThemePage1State();
}

class _ThemePage1State extends State<ThemePage1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: context.watch<AlbumViewModel>().albumPageImage(widget.albumPageIndex, 0, assetName: "static/image/hard_cover_title_hd.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          width: double.infinity,
          height: 224,
          color: Colors.white60,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    context.watch<AlbumViewModel>().albumPageText(widget.albumPageIndex, 0),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleConfig.h1,
                  ),
                  Image(
                    height: 72,
                    width: 72,
                    fit: BoxFit.cover,
                    image: context.watch<AlbumViewModel>().albumPageImage(widget.albumPageIndex, 1, assetName: "static/image/xigua.png"),
                  ),
                ],
              ),
              Positioned(
                bottom: 8,
                child: Text(
                  context.watch<AlbumViewModel>().albumPageText(widget.albumPageIndex, 1),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyleConfig.h4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
