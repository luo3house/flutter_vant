import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/utils/nil.dart';
import 'package:flutter_vantui/src/widgets/button/pressable.dart';
import 'package:flutter_vantui/src/widgets/config/index.dart';
import 'package:tailstyle/tailstyle.dart';

import 'types.dart';
export 'package:flutter_vantui/src/widgets/button/pressable.dart';

// @DocsId("button")
class Button extends StatelessWidget {
  // @DocsProp("type", "primary | success | warning | danger | null", "按钮类型")
  final ButtonType? type;
  // @DocsProp("size", "large | small | mini | null", "按钮大小")
  final ButtonSize? size;
  // @DocsProp("text", "String", "文本")
  final String? text;
  // @DocsProp("block", "bool", "尺寸")
  final bool? block;
  // @DocsProp("plain", "bool", "是否为朴素按钮")
  final bool? plain;
  // @DocsProp("square", "bool", "方形按钮")
  final bool? square;
  // @DocsProp("round", "bool", "圆形按钮")
  final bool? round;
  // @DocsProp("disabled", "bool", "禁用")
  final bool? disabled;
  // @DocsProp("loading", "bool", "加载状态")
  final bool? loading;
  // @DocsProp("loadingText", "String", "加载文本")
  final String? loadingText;
  // @DocsProp("loadingSize", "double", "加载图标大小")
  final double? loadingSize;
  // @DocsProp("icon", "Icon | IconData | Widget", "按钮图标")
  final dynamic icon;
  // @DocsProp("onTap", "Function()", "点击回调")
  final Function()? onTap;
  // @DocsProp("borderColor", "Color", "边框颜色")
  final Color? borderColor;

  const Button({
    this.type,
    this.size,
    this.text,
    this.block,
    this.plain,
    this.square,
    this.round,
    this.disabled,
    this.loading,
    this.loadingText,
    this.loadingSize,
    this.onTap,
    this.borderColor,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    final bg = <dynamic, Color>{
      "plain": const Color(0x00000000),
      null: const Color(0x00000000),
      ButtonType.primary: theme.primaryColor,
      ButtonType.success: theme.successColor,
      ButtonType.danger: theme.dangerColor,
      ButtonType.warning: theme.warningColor,
    }[plain == true ? "plain" : type];

    final borderWidth = theme.borderWidth;

    final borderColor = this.borderColor ??
        <dynamic, Color>{
          null: theme.gray4,
          ButtonType.primary: theme.primaryColor,
          ButtonType.success: theme.successColor,
          ButtonType.danger: theme.dangerColor,
          ButtonType.warning: theme.warningColor,
        }[type]!;

    final color = <dynamic, Color>{
      null: theme.textColor,
      ButtonType.primary: plain == true ? theme.primaryColor : theme.white,
      ButtonType.success: plain == true ? theme.successColor : theme.white,
      ButtonType.danger: plain == true ? theme.dangerColor : theme.white,
      ButtonType.warning: plain == true ? theme.warningColor : theme.white,
    }[type];

    final rounded = <dynamic, double>{
      null: theme.radiusMd,
      false: theme.radiusMd,
      true: theme.radiusMax,
      "square": 0.0,
    }[square == true ? 'square' : round];

    final px = <dynamic, double>{
      null: 15,
      ButtonSize.large: 17,
      ButtonSize.small: theme.paddingXs,
      ButtonSize.mini: theme.paddingBase,
    }[size]!;
    final py = px / (2 / 1);

    final fontSize = <dynamic, double>{
      null: theme.fontSizeMd,
      ButtonSize.large: theme.fontSizeLg,
      ButtonSize.small: theme.fontSizeSm,
      ButtonSize.mini: theme.fontSizeXs,
    }[size]!;

    final loading = this.loading == true;

    final labelText = <dynamic, String?>{
      true: loadingText ?? text,
      false: text,
    }[loading];

    final label = TailTypo()
        .text_color(color)
        .font_size(fontSize)
        .text_center()
        .Text(labelText ?? '');

    final mainAxisSize = <bool?, MainAxisSize>{
      null: MainAxisSize.min,
      false: MainAxisSize.min,
      true: MainAxisSize.max,
    }[block]!;

    final height = <ButtonSize?, double>{
      ButtonSize.large: 50,
      null: 44,
      ButtonSize.small: 32,
      ButtonSize.mini: 24,
    }[size]!;

    final disabled = this.disabled == true;

    final prefix = () {
      if (icon is IconData) {
        return TailBox().mr(theme.paddingBase).as((styled) {
          return styled.Container(child: Icon(icon as IconData));
        });
      } else if (icon is Widget) {
        return TailBox().mr(theme.paddingBase).as((styled) {
          return styled.Container(child: icon);
        });
      } else if (loading) {
        return TailBox().mr(theme.paddingBase).as((styled) {
          return styled.Container();
        });
      } else {
        return nil;
      }
    }();

    return LayoutBuilder(builder: (_, con) {
      return GestureDetector(
        onTap: () => (disabled || loading ? null : onTap)?.call(),
        child: Pressable((pressed) {
          return Opacity(
            opacity: disabled || loading ? theme.disabledOpacity : 1,
            child: TailBox().rounded(rounded).as((s) {
              return s.Container(
                clipBehavior: Clip.antiAlias,
                child: ShaderMask(
                  blendMode: !(disabled || loading) && pressed
                      ? BlendMode.darken
                      : BlendMode.dst,
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [Color(0x1A000000), Color(0x1A000000)],
                    ).createShader(bounds);
                  },
                  child: TailBox().border(borderColor, borderWidth).as((s) {
                    return s.bg(bg).px(px).py(py).rounded(rounded).as((s) {
                      return s.Container(
                        constraints: con.maxHeight == double.infinity
                            ? BoxConstraints(maxHeight: height)
                            : BoxConstraints(minHeight: height),
                        child: Row(
                          mainAxisSize: mainAxisSize,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: prefix),
                            Center(child: label)
                          ],
                        ),
                      );
                    });
                  }),
                ),
              );
            }),
          );
        }),
      );
    });
  }
}
