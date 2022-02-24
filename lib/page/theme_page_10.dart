
import 'package:flutter/material.dart';
import 'package:photo_album/config/text_style_config.dart';
import 'package:photo_album/model/album_model.dart';
import 'package:provider/provider.dart';

class ThemePage10 extends StatefulWidget {
  static const int textLength = 3;
  static const int photoLength = 3;

  final int albumPageIndex;
  const ThemePage10({Key? key, required this.albumPageIndex}) : super(key: key);

  @override
  _ThemePage10State createState() => _ThemePage10State();
}

class _ThemePage10State extends State<ThemePage10> {
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
              Container(height: double.infinity, width: 2, color: Colors.black12),
              Expanded(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    padding: const EdgeInsets.all(40),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row (
                            children: [
                              Expanded(
                                child: Container(
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white, width: 10),
                                    image: DecorationImage(
                                      image: context.watch<AlbumViewModel>().albumPageImage(widget.albumPageIndex, 1),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(80, 20, 80, 20),
                                  alignment: Alignment.center,
                                  child: Text(
                                    context.watch<AlbumViewModel>().albumPageText(widget.albumPageIndex, 1),
                                    textAlign: TextAlign.center,
                                    maxLines: 6,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyleConfig.h3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          flex: 1,
                          child: Row (
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(80, 20, 80, 20),
                                  alignment: Alignment.center,
                                  child: Text(
                                    context.watch<AlbumViewModel>().albumPageText(widget.albumPageIndex, 2),
                                    textAlign: TextAlign.center,
                                    maxLines: 6,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyleConfig.h3,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white, width: 10),
                                    image: DecorationImage(
                                      image: context.watch<AlbumViewModel>().albumPageImage(widget.albumPageIndex, 2),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
