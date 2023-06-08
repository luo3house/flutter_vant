import 'package:flutter/widgets.dart';
import 'package:tailstyle/tailstyle.dart';

import '../../utils/nil.dart';
import '../config/index.dart';

class VanDialogBody extends StatelessWidget {
  final dynamic title;
  final dynamic message;
  final Widget? action;

  const VanDialogBody({
    this.title,
    this.message,
    this.action,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);
    final fontSize =
        DefaultTextStyle.of(context).style.fontSize ?? theme.fontSizeMd;

    final titleStyle = TailTypo()
        .text_color(theme.textColor)
        .font_bold()
        .line_height(24 / fontSize)
        .TextStyle();

    final title = () {
      if (this.title is Widget) {
        return this.title as Widget;
      } else if (this.title == null) {
        return nil;
      } else {
        return TailTypo().text_center().Text("${this.title}");
      }
    }();

    final messageStyle = TailTypo()
        .text_color(title == nil ? theme.gray7 : theme.textColor)
        .line_height(theme.lineHeightMd / fontSize)
        .TextStyle();

    final message = () {
      if (this.message is Widget) {
        return this.message as Widget;
      } else {
        final px = theme.paddingLg, py = 26.0;
        final pt = title == nil ? py : theme.paddingXs;
        return TailBox().px(px).py(py).pt(pt).as((s) {
          return s.Container(
            child: TailTypo().text_center().Text("${this.message}"),
          );
        });
      }
    }();

    final header = DefaultTextStyle(
      style: titleStyle,
      child: TailBox().pt(title == nil ? 0 : 26).as((s) {
        return s.Container(child: Center(child: title));
      }),
    );

    final content = DefaultTextStyle(
      style: messageStyle,
      child: Center(child: message),
    );

    final bg = theme.background2;
    const rounded = 16.0;

    return TailBox().bg(bg).rounded(rounded).as((s) {
      return s.Container(
        clipBehavior: Clip.hardEdge,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          header,
          content,
          action ?? nil,
        ]),
      );
    });
  }
}
