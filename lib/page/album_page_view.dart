
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/db/album_service.dart';
import 'package:photo_album/model/album_model.dart';
import 'package:photo_album/page/theme_page.dart';
import 'package:photo_album/page/welcome_page.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class AlbumPageView extends StatefulWidget {
  const AlbumPageView({Key? key}) : super(key: key);

  @override
  _AlbumPageViewState createState() => _AlbumPageViewState();
}

class _AlbumPageViewState extends State<AlbumPageView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      endDrawer: Drawer(
        child: AlbumDrawer(),
      ),
      body: AlbumMainPage(),
    );
  }
}

class AlbumDrawer extends StatefulWidget {
  const AlbumDrawer({Key? key}) : super(key: key);

  @override
  _AlbumDrawerState createState() => _AlbumDrawerState();
}

class _AlbumDrawerState extends State<AlbumDrawer> {
  List<TextEditingController> textEditingControllerList = [];
  List<ImageProvider> imageProviderList = [];

  List<Widget> buildList() {
    List<Widget> list = [];
    int pageIndex = context.watch<AlbumViewModel>().pageIndex;
    int photoLength = context.watch<AlbumViewModel>().photoLength;
    int textLength = context.watch<AlbumViewModel>().textLength;

    // 生成图片选择
    if(imageProviderList.length != photoLength) {
      imageProviderList.clear();
    }
    for(int i = 0; i < photoLength; i++) {
      if(imageProviderList.length != photoLength) {
        imageProviderList.add(context.watch<AlbumViewModel>().albumPageImage(pageIndex, i, assetName: (i == 0) ? "static/image/hard_cover_plain_hd.jpeg" : "static/image/photo.jpg"));
      }
      list.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 3,
                child: RawMaterialButton(
                  padding: const EdgeInsets.all(8),
                  child: Image(
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    image: imageProviderList[i],
                  ),
                  onPressed: () {
                    // 选择图片
                    choosePhoto(i);
                  },
                )
            ),
            Expanded(
                flex: 1,
                child: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    // 选择图片
                    deletePhoto(i);
                  },
                )
            ),
          ],
        )
      );
    }

    // 生成文本输入
    if(textEditingControllerList.length != textLength) {
      textEditingControllerList.clear();
    }
    for(int i = 0; i < textLength; i++) {
      if(textEditingControllerList.length != textLength) {
        textEditingControllerList.add(TextEditingController());
      }
      textEditingControllerList[i].text = context.watch<AlbumViewModel>().albumPageText(pageIndex, i, defaultString: "");
      int labelIndex = i + 1;
      list.add(
          TextField(
            autofocus: true,
            maxLines: 4,
            minLines: 2,
            controller: textEditingControllerList[i],
            decoration: InputDecoration(
                labelText: "文本$labelIndex",
                hintText: "请设置此处标题",
                prefixIcon: const Icon(Icons.text_format)
            ),
          )
      );
    }
    return list;
  }

  void saveAlbumIndex() {
    int textLength = context.read<AlbumViewModel>().textLength;
    int textEditLength = textEditingControllerList.length;
    List<String> textList = [];
    for(int i = 0; i < textLength; i++) {
      String value = (textEditLength >= i) ? textEditingControllerList[i].text : "";
      textList.add(value);
    }
    List<String> photoList = context.read<AlbumViewModel>().photoList;
    context.read<AlbumViewModel>().saveAlbumIndex(textList, photoList);
  }

  void deletePhoto(int index) {
    context.read<AlbumViewModel>().setPhoto(index, "");
    setState(() {
      imageProviderList[index] = (index == 0) ? const AssetImage("static/image/hard_cover_plain_hd.jpeg") : const AssetImage("static/image/photo.jpg");
    });
  }

  void choosePhoto(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image, withReadStream: true, lockParentWindow: true);
    if (result != null && mounted) {
      File file = File(result.files.single.path as String);
      // 上传图片，返回新图片名
      String? albumId = context.read<AlbumViewModel>().albumPage().albumId;
      String fileName = AlbumService.uploadFile(albumId, file);
      context.read<AlbumViewModel>().setPhoto(index, fileName);

      setState(() {
        imageProviderList[index] = FileImage(file);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(15),
          color: Colors.blue,
          child: Row(
            children: [
              const Icon(Icons.settings, color: Colors.white,),
              const SizedBox(width: 10),
              const Text("设置", style: TextStyle(color: Colors.white)),
              const Expanded(child: Text("")),
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_)=> WelcomePage(autoJump: false)), (route) => false);
                  },
                  child: const Text("切换相册", style: TextStyle(color: Colors.white)))
            ],
          ),
        ),
        Container(height: 1, color: Colors.blue),
        Expanded(
            child: Container(
              alignment: Alignment.topCenter,
              child: ListView (
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                children: buildList(),
              ),
            )
        ),
        Container(height: 1, color: Colors.blue),
        Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FloatingActionButton.extended(
                backgroundColor: Colors.blue,
                icon: const Icon(Icons.cancel),
                heroTag: null,
                autofocus: true,
                label: const Text("取消"),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 10),
              FloatingActionButton.extended(
                backgroundColor: Colors.blue,
                icon: const Icon(Icons.save),
                heroTag: null,
                label: const Text("保存"),
                onPressed: (){
                  // 保存相册
                  saveAlbumIndex();
                  // 关闭
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AlbumMainPage extends StatefulWidget {
  const AlbumMainPage({Key? key}) : super(key: key);

  @override
  _AlbumMainPageState createState() => _AlbumMainPageState();
}

class _AlbumMainPageState extends State<AlbumMainPage> {
  final PageController _pageController = PageController(initialPage: 0, keepPage: false);
  bool showChooseTheme = false;
  int currentPageNum = 0;

  void setCurrentPageNum(int pageNum) {
    setState(() {
      currentPageNum = pageNum;
    });
  }

  void setShowChooseTheme(bool visible) {
    setState(() {
      showChooseTheme = visible;
    });
  }

  void setPageInfo() {
    double? page = _pageController.page;
    int num = (null == page) ? 0: page.toInt();
    currentPageNum = num;
    // 获取页面主题
    String? theme = context.read<AlbumViewModel>().albumPageByIndex(num).theme;
    // 设置页面的文本数量和图片数量
    context.read<AlbumViewModel>().setPageInfo(num, ThemePage.getTextLength(theme), ThemePage.getPhotoLength(theme));
  }

  void addPage(String theme) {
    context.read<AlbumViewModel>().addAlbumPageAtIndex(theme);
    // 跳转到新页面
    int num = currentPageNum + 1;
    _pageController.jumpToPage(num);
    setCurrentPageNum(num);
    setShowChooseTheme(false);
  }

  void removePage() {
    // 如果当前页码是最后一页，跳转到最后一页
    int total = context.read<AlbumViewModel>().pageTotalSize;
    // 最后一页不能删除
    if(total <= 1) {
      return;
    }
    int num = currentPageNum - 1;
    if(num < 0){
      num = 0;
    }
    _pageController.jumpToPage(num);
    context.read<AlbumViewModel>().removeAlbumPageAtIndex();
    setCurrentPageNum(num);
  }

  String pageInfoText() {
    int pageNum = currentPageNum + 1;
    int total = context.read<AlbumViewModel>().pageTotalSize;
    return pageNum.toString() + "\n" + total.toString();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<Widget> buildList() {
    List<Widget> list = [];
    for(int i = 0; i < 10; i++) {
      int labelIndex = i + 1;
      list.add(
          RawMaterialButton(
            padding: const EdgeInsets.all(4),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(4),
              child: Image(
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
                image: AssetImage("static/image/theme_$labelIndex.png"),
              ),
            ),
            onPressed: () {
              // 选择模板
              addPage(labelIndex.toString());
            },
          )
      );

    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          reverse: false,
          physics: const BouncingScrollPhysics(),
          itemCount: context.watch<AlbumViewModel>().albumPageLength(),
          onPageChanged: (index){
            setCurrentPageNum(index);
          },
          itemBuilder: (context, index){
            String? theme = context.watch<AlbumViewModel>().albumPageByIndex(index).theme;
            return ThemePage.of(theme, index);
          },
        ),
        Positioned(
            right: 32,
            height: 700,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: showChooseTheme,
                  child: Container(
                    alignment: Alignment.center,
                    width: 160,
                    height: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      itemExtent: 114,
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: buildList(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      backgroundColor: Colors.deepOrangeAccent,
                      heroTag: null,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(pageInfoText(), textAlign: TextAlign.center),
                          Container(color: Colors.white,height: 1, margin: const EdgeInsets.all(10),),
                        ],
                      ),
                      tooltip: "首页",
                      onPressed: (){
                        _pageController.animateToPage(0, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                      },
                    ),
                    const SizedBox(height: 10),
                    FloatingActionButton(
                      backgroundColor: Colors.deepOrangeAccent,
                      heroTag: null,
                      child: const Icon(Icons.settings),
                      tooltip: "配置",
                      onPressed: (){
                        // 设置组件页码
                        setPageInfo();
                        Scaffold.of(context).openEndDrawer();
                      },
                    ),
                    const SizedBox(height: 10),
                    FloatingActionButton(
                      backgroundColor: Colors.deepOrangeAccent,
                      heroTag: null,
                      child: const Icon(Icons.add),
                      tooltip: "插入",
                      onPressed: (){
                        if(!showChooseTheme) {
                          // 设置组件页码
                          setPageInfo();
                        }
                        setShowChooseTheme(showChooseTheme ? false : true);
                      },
                    ),
                    const SizedBox(height: 10),
                    FloatingActionButton(
                      backgroundColor: Colors.deepOrangeAccent,
                      heroTag: null,
                      child: const Icon(Icons.remove),
                      tooltip: "删除",
                      onPressed: (){
                        // 设置组件页码
                        setPageInfo();
                        removePage();
                      },
                    ),
                    const SizedBox(height: 10),
                    FloatingActionButton(
                      backgroundColor: Colors.deepOrangeAccent,
                      heroTag: null,
                      child: const Icon(Icons.arrow_back),
                      tooltip: "上一页",
                      onPressed: (){
                        _pageController.previousPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                      },
                    ),
                    const SizedBox(height: 10),
                    FloatingActionButton(
                      backgroundColor: Colors.deepOrangeAccent,
                      heroTag: null,
                      child: const Icon(Icons.arrow_forward),
                      tooltip: "下一页",
                      onPressed: (){
                        _pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                      },
                    ),
                  ],
                )
              ],
            )
        ),
      ],
    );
  }
}
