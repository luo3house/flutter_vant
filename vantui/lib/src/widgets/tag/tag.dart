import 'package:flutter/widgets.dart';
import 'package:tailstyle/tailstyle.dart';
import 'package:tuple/tuple.dart';

import '../../utils/nil.dart';
import '../config/index.dart';

enum TagType { primary, success, warning, danger }

enum TagSize { small, medium, large }

// @DocsId("tag")

class Tag extends StatelessWidget {
  // @DocsProp("child", "String", "标签文本")
  final String? child;
  // @DocsProp("type", "primary | success | warning | danger", "类型")
  final TagType? type;
  // @DocsProp("size", "small | medium | large", "大小")
  final TagSize? size;
  // @DocsProp("plain", "bool", "朴素风格")
  final bool? plain;
  // @DocsProp("round", "bool", "圆角风格")
  final bool? round;
  // @DocsProp("color", "Color", "颜色")
  final Color? color;
  // @DocsProp("textColor", "Color", "文本颜色")
  final Color? textColor;
  // @DocsProp("icon", "Widget | IconDate", "右侧图标")
  final dynamic icon;
  // @DocsProp("onIconTap", "Function()", "点击图标触发")
  final Function()? onIconTap;

  const Tag({
    this.child,
    this.type,
    this.size,
    this.plain,
    this.round,
    this.color, // this is bg, or color if plain
    this.textColor, // this is color
    this.icon,
    this.onIconTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    final type = this.type ?? TagType.primary;
    final size = this.size ?? TagSize.small;
    final plain = this.plain ?? false;
    final round = this.round ?? false;

    final bg = () {
      if (plain) {
        return theme.background2;
      } else if (this.color != null) {
        return this.color!;
      } else {
        return <TagType, Color>{
          TagType.primary: theme.primaryColor,
          TagType.success: theme.successColor,
          TagType.danger: theme.dangerColor,
          TagType.warning: theme.warningColor,
        }[type]!;
      }
    }();

    final borderColor = () {
      if (!plain) {
        return bg;
      } else if (this.color != null) {
        return this.color!;
      } else {
        return <TagType, Color>{
          TagType.primary: theme.primaryColor,
          TagType.success: theme.successColor,
          TagType.danger: theme.dangerColor,
          TagType.warning: theme.warningColor,
        }[type]!;
      }
    }();

    final color = () {
      if (!plain) {
        return textColor ?? theme.white;
      } else if (this.color != null) {
        return this.color!;
      } else {
        return <TagType, Color>{
          TagType.primary: theme.primaryColor,
          TagType.success: theme.successColor,
          TagType.danger: theme.dangerColor,
          TagType.warning: theme.warningColor,
        }[type]!;
      }
    }();

    final rounded = round ? theme.radiusMax : 2.0;

    const lineHeight = 16.0;

    final pypx = <TagSize, Tuple2<double, double>>{
      TagSize.small: Tuple2(0, theme.paddingBase),
      TagSize.medium: const Tuple2(2, 6),
      TagSize.large: Tuple2(theme.paddingBase, theme.paddingXs),
    }[size]!;

    final textStyle = TailTypo() //
        .font_size(theme.fontSizeSm)
        .text_color(color)
        .TextStyle();

    final iconTheme = IconThemeData(size: theme.fontSizeSm, color: color);

    final icon = () {
      if (this.icon is Widget) {
        return this.icon as Widget;
      } else if (this.icon is IconData) {
        return Icon(this.icon);
      } else {
        return nil;
      }
    }();

    final iconWrap = icon != nil
        ? GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onIconTap?.call(),
            child: TailBox().ml(2).Container(child: icon),
          )
        : icon;

    return UnconstrainedBox(
      child: TailBox().bg(bg).rounded(rounded).border(borderColor).as((s) {
        return s.py(pypx.item1).px(pypx.item2).as((s) {
          return s.Container(
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              DefaultTextStyle(style: textStyle, child: Text(child ?? "")),
              IconTheme(data: iconTheme, child: iconWrap),
            ]),
          );
        });
      }),
    );
  }
}
