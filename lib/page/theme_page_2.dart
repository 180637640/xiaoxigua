
import 'package:flutter/material.dart';
import 'package:photo_album/config/text_style_config.dart';
import 'package:photo_album/model/album_model.dart';
import 'package:provider/provider.dart';

class ThemePage2 extends StatefulWidget {
  static const int textLength = 3;
  static const int photoLength = 1;
  
  final int albumPageIndex;
  const ThemePage2({Key? key, required this.albumPageIndex}) : super(key: key);

  @override
  _ThemePage2State createState() => _ThemePage2State();
}

class _ThemePage2State extends State<ThemePage2> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: context.watch<AlbumViewModel>().albumPageImage(widget.albumPageIndex, 0, assetName: "static/image/hard_cover_plain_hd.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        width: double.infinity,
        child: Center (
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: double.infinity,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Text(
                  context.watch<AlbumViewModel>().albumPageText(widget.albumPageIndex, 0),
                  textAlign: TextAlign.center,
                  style: TextStyleConfig.h4,
                  softWrap: true,
                ),
              ),
              Container(
                height: double.infinity,
                width: 2,
                color: Colors.white70,
              ),
              Expanded(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    padding: const EdgeInsets.all(100),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Expanded(child: Container()),
                        Text(
                          context.watch<AlbumViewModel>().albumPageText(widget.albumPageIndex, 1),
                          textAlign: TextAlign.center,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyleConfig.h2,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          context.watch<AlbumViewModel>().albumPageText(widget.albumPageIndex, 2),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyleConfig.h3,
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  )
              ),

            ],
          ),
        )
    );
  }
}
