import 'package:flutter/widgets.dart';
import "package:flutter_vantui_icons/flutter_vantui_icons.dart";
export "package:flutter_vantui_icons/flutter_vantui_icons.dart";

// @DocsId("icon")

class VanIcon extends StatelessWidget {
// @DocsProp("name", "VanIconData", "图标数据")
  final VanIconData name;
// @DocsProp("color", "Color", "颜色")
  final Color? color;
// @DocsProp("size", "double", "大小")
  final double? size;

  const VanIcon(
    this.name, {
    this.color,
    this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(name, color: color, size: size);
  }
}
