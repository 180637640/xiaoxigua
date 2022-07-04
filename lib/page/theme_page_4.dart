
import 'package:flutter/material.dart';
import 'package:photo_album/config/text_style_config.dart';
import 'package:photo_album/model/album_model.dart';
import 'package:provider/provider.dart';

class ThemePage4 extends StatefulWidget {
  static const int textLength = 2;
  static const int photoLength = 2;

  final int albumPageIndex;
  const ThemePage4({Key? key, required this.albumPageIndex}) : super(key: key);

  @override
  _ThemePage4State createState() => _ThemePage4State();
}

class _ThemePage4State extends State<ThemePage4> {

  // 是否显示标题栏
  bool visibleTitle = true;

  void initTitleState() {
    if(!mounted) {
      return;
    }
    String title = Provider.of<AlbumViewModel>(context, listen: false).albumPageText(widget.albumPageIndex, 0);
    if(title.isEmpty) {
      setState(() {
        visibleTitle = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => initTitleState());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration.zero, () => initTitleState());
  }

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
              Visibility(
                visible: visibleTitle,
                child: Container(
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
              ),
              Visibility(
                visible: visibleTitle,
                child: Container(height: double.infinity, width: 2, color: Colors.black12),
              ),
              Expanded(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    padding: const EdgeInsets.all(40),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
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
