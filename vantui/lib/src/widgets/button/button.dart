import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/utils/nil.dart';
import 'package:flutter_vantui/src/widgets/button/pressable.dart';
import 'package:flutter_vantui/src/widgets/config/index.dart';
import 'package:flutter_vantui/src/widgets/icon/index.dart';
import 'package:tailstyle/tailstyle.dart';

import 'types.dart';
export 'package:flutter_vantui/src/widgets/button/pressable.dart';

class VanBtn extends StatelessWidget {
  final VanBtnType? type;
  final VanBtnSize? size;
  final String? text;
  final bool? block;
  final bool? plain;
  final bool? square;
  final bool? round;
  final bool? disabled;
  final bool? loading;
  final String? loadingText;
  final double? loadingSize;
  final dynamic icon;
  final Function()? onTap;
  final Color? borderColor;
  const VanBtn({
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
      "plain": theme.white,
      null: theme.white,
      VanBtnType.primary: theme.primaryColor,
      VanBtnType.success: theme.successColor,
      VanBtnType.danger: theme.dangerColor,
      VanBtnType.warning: theme.warningColor,
    }[plain == true ? "plain" : type];

    final borderWidth = theme.borderWidth;

    final borderColor = this.borderColor ??
        <dynamic, Color>{
          null: theme.gray4,
          VanBtnType.primary: theme.primaryColor,
          VanBtnType.success: theme.successColor,
          VanBtnType.danger: theme.dangerColor,
          VanBtnType.warning: theme.warningColor,
        }[type]!;

    final color = <dynamic, Color>{
      null: theme.textColor,
      VanBtnType.primary: plain == true ? theme.primaryColor : theme.white,
      VanBtnType.success: plain == true ? theme.successColor : theme.white,
      VanBtnType.danger: plain == true ? theme.dangerColor : theme.white,
      VanBtnType.warning: plain == true ? theme.warningColor : theme.white,
    }[type];

    final rounded = <dynamic, double>{
      null: theme.radiusMd,
      false: theme.radiusMd,
      true: theme.radiusMax,
      "square": 0.0,
    }[square == true ? 'square' : round];

    final px = <dynamic, double>{
      null: 15,
      VanBtnSize.large: 17,
      VanBtnSize.small: theme.paddingXs,
      VanBtnSize.mini: theme.paddingBase,
    }[size]!;
    final py = px / (2 / 1);

    final fontSize = <dynamic, double>{
      null: theme.fontSizeMd,
      VanBtnSize.large: theme.fontSizeLg,
      VanBtnSize.small: theme.fontSizeSm,
      VanBtnSize.mini: theme.fontSizeXs,
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

    final height = <VanBtnSize?, double>{
      VanBtnSize.large: 50,
      null: 44,
      VanBtnSize.small: 32,
      VanBtnSize.mini: 24,
    }[size]!;

    final disabled = this.disabled == true;

    final prefix = () {
      if (icon is VanIconData) {
        return TailBox().mr(theme.paddingBase).as((styled) {
          return styled.Container(child: VanIcon(icon as VanIconData));
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
