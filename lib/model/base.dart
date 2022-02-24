/// 基类
class Base {

  /// 默认构造
  Base(
      this.id,
      this.addTimeString,
      this.modifyTimeString);

  /// 主键
  String? id;
  /// 添加时间
  String? addTimeString;
  /// 最后修改时间
  String? modifyTimeString;

}