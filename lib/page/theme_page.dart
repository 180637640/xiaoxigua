
import 'package:flutter/material.dart';
import 'package:photo_album/page/theme_page_1.dart';
import 'package:photo_album/page/theme_page_10.dart';
import 'package:photo_album/page/theme_page_11.dart';
import 'package:photo_album/page/theme_page_12.dart';
import 'package:photo_album/page/theme_page_13.dart';
import 'package:photo_album/page/theme_page_2.dart';
import 'package:photo_album/page/theme_page_3.dart';
import 'package:photo_album/page/theme_page_4.dart';
import 'package:photo_album/page/theme_page_5.dart';
import 'package:photo_album/page/theme_page_6.dart';
import 'package:photo_album/page/theme_page_7.dart';
import 'package:photo_album/page/theme_page_8.dart';
import 'package:photo_album/page/theme_page_9.dart';

class ThemePage {

  static StatefulWidget of(String? theme, int index) {
    switch(theme) {
      case "1" : {
        return ThemePage1(albumPageIndex: index);
      }
      case "2" : {
        return ThemePage2(albumPageIndex: index);
      }
      case "3" : {
        return ThemePage3(albumPageIndex: index);
      }
      case "4" : {
        return ThemePage4(albumPageIndex: index);
      }
      case "5" : {
        return ThemePage5(albumPageIndex: index);
      }
      case "6" : {
        return ThemePage6(albumPageIndex: index);
      }
      case "7" : {
        return ThemePage7(albumPageIndex: index);
      }
      case "8" : {
        return ThemePage8(albumPageIndex: index);
      }
      case "9" : {
        return ThemePage9(albumPageIndex: index);
      }
      case "10" : {
        return ThemePage10(albumPageIndex: index);
      }
      case "11" : {
        return ThemePage11(albumPageIndex: index);
      }
      case "12" : {
        return ThemePage12(albumPageIndex: index);
      }
      case "13" : {
        return ThemePage13(albumPageIndex: index);
      }
      default : {
        return ThemePage1(albumPageIndex: index);
      }
    }
  }

  static int getPhotoLength(String? theme) {
    return _getLength(theme, false);
  }

  static int getTextLength(String? theme) {
    return _getLength(theme, true);
  }

  static int _getLength(String? theme, bool isText) {
    switch(theme) {
      case "1" : {
        return isText ? ThemePage1.textLength : ThemePage1.photoLength;
      }
      case "2" : {
        return isText ? ThemePage2.textLength : ThemePage2.photoLength;
      }
      case "3" : {
        return isText ? ThemePage3.textLength : ThemePage3.photoLength;
      }
      case "4" : {
        return isText ? ThemePage4.textLength : ThemePage4.photoLength;
      }
      case "5" : {
        return isText ? ThemePage5.textLength : ThemePage5.photoLength;
      }
      case "6" : {
        return isText ? ThemePage6.textLength : ThemePage6.photoLength;
      }
      case "7" : {
        return isText ? ThemePage7.textLength : ThemePage7.photoLength;
      }
      case "8" : {
        return isText ? ThemePage8.textLength : ThemePage8.photoLength;
      }
      case "9" : {
        return isText ? ThemePage9.textLength : ThemePage9.photoLength;
      }
      case "10" : {
        return isText ? ThemePage10.textLength : ThemePage10.photoLength;
      }
      case "11" : {
        return isText ? ThemePage11.textLength : ThemePage11.photoLength;
      }
      case "12" : {
        return isText ? ThemePage12.textLength : ThemePage12.photoLength;
      }
      case "13" : {
        return isText ? ThemePage13.textLength : ThemePage13.photoLength;
      }
      default : {
        return 0;
      }
    }
  }
}
