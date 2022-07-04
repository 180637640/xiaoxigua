
import 'package:flutter/material.dart';
import 'package:photo_album/config/text_style_config.dart';
import 'package:photo_album/model/album_model.dart';
import 'package:provider/provider.dart';

class ThemePage11 extends StatefulWidget {
  static const int textLength = 1;
  static const int photoLength = 2;

  final int albumPageIndex;
  const ThemePage11({Key? key, required this.albumPageIndex}) : super(key: key);

  @override
  _ThemePage11State createState() => _ThemePage11State();
}

class _ThemePage11State extends State<ThemePage11> {

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
