
/// 自定义工具
class UF{
  static int _index = 100;

  /// 获取唯一ID 格式 202201281550283708609999
  static String getRandomId() {
    // 格式 2022-01-28 15:50:28.370860
    String dateTime = DateTime.now().toString();
    dateTime = dateTime
        .replaceAll(" ", "")
        .replaceAll("-", "")
        .replaceAll(":", "")
        .replaceAll("+", "")
        .replaceAll("T", "")
        .replaceAll(".", "");

    _index++;
    if(_index >= 1000) {
      _index = 999;
    }
    String suffix = _index.toString();
    return dateTime + suffix;
  }

}
