import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:tailstyle/tailstyle.dart';

enum ContentPosition { left, center, right }

// @DocsId("divider")

class Divider extends StatelessWidget {
  final Widget? child;
  // @DocsProp("contentPosition", "left | center | right", "内容位置")
  final ContentPosition? contentPosition;
  // @DocsProp("textStyle", "TextStyle", "内容文本样式")
  final TextStyle? textStyle;

  const Divider({
    this.contentPosition,
    this.textStyle,
    this.child,
    super.key,
  });

  defaultBorderColor(BuildContext context) =>
      DefaultTextStyle.of(context).style.color;

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    final contentPosition = this.contentPosition ?? ContentPosition.center;

    final child = this.child ?? nil;

    final defaultTextStyle = TailTypo() //
        .text_color(theme.textColor2)
        .font_size(theme.fontSizeMd)
        .TextStyle();
    final textStyle = (this.textStyle ?? defaultTextStyle).copyWith(
      color: this.textStyle?.color ?? defaultTextStyle.color,
      fontSize: this.textStyle?.fontSize ?? defaultTextStyle.fontSize,
    );

    const lineHeight = 24.0;

    final borderColor = this.textStyle == null ? theme.gray3 : null;

    return LayoutBuilder(builder: (_, con) {
      final leftW = contentPosition == ContentPosition.left //
          ? 0.1 * con.maxWidth
          : null;

      final rightW = contentPosition == ContentPosition.right //
          ? 0.1 * con.maxWidth
          : null;

      final left = Builder(builder: (context) {
        return TailBox()
            .mr(child == nil ? 0 : theme.paddingMd)
            .border(borderColor ?? defaultBorderColor(context), 0.5)
            .Container(width: leftW);
      });

      final right = Builder(builder: (context) {
        return TailBox()
            .ml(child == nil ? 0 : theme.paddingMd)
            .border(borderColor ?? defaultBorderColor(context), 0.5)
            .Container(width: rightW);
      });

      return DefaultTextStyle(
        style: textStyle,
        child: TailBox().my(theme.paddingMd).as((s) {
          return s.Container(
            constraints: const BoxConstraints(minHeight: lineHeight),
            child: Row(mainAxisSize: MainAxisSize.max, children: [
              leftW != null ? left : Expanded(child: left),
              child,
              rightW != null ? right : Expanded(child: right),
            ]),
          );
        }),
      );
    });
  }
}
