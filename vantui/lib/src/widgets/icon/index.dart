import 'package:flutter/widgets.dart';
import "package:flutter_vantui_icons/flutter_vantui_icons.dart";
export "package:flutter_vantui_icons/flutter_vantui_icons.dart";

class VanIcon extends StatelessWidget {
  final VanIconData name;
  final Color? color;
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
