
import 'package:flutter/material.dart';
import 'package:photo_album/config/text_style_config.dart';
import 'package:photo_album/model/album_model.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class ThemePage5 extends StatefulWidget {
  static const int textLength = 2;
  static const int photoLength = 2;

  final int albumPageIndex;
  const ThemePage5({Key? key, required this.albumPageIndex}) : super(key: key);

  @override
  _ThemePage5State createState() => _ThemePage5State();
}

class _ThemePage5State extends State<ThemePage5> {
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
                    padding: const EdgeInsets.all(80),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Transform.rotate(
                            angle: math.pi / 45,
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
                        ),
                        Container(width: 30),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.all(30),
                            child: Text(
                              context.watch<AlbumViewModel>().albumPageText(widget.albumPageIndex, 1),
                              textAlign: TextAlign.center,
                              maxLines: 12,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyleConfig.h3,
                            ),
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
