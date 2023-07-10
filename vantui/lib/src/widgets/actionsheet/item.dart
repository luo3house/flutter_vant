import 'package:flutter/widgets.dart';
import 'package:tailstyle/tailstyle.dart';

import '../../utils/nil.dart';
import '../button/pressable.dart';
import '../config/index.dart';

class ActionSheetItem extends StatelessWidget {
  final String name;
  final String? subname;
  final Widget? child;
  final bool? disabled;
  const ActionSheetItem(
    this.name, {
    this.subname,
    this.disabled,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);
    final fontSize =
        DefaultTextStyle.of(context).style.fontSize ?? theme.fontSizeMd;
    final px = theme.paddingMd, py = 14.0;

    final disabled = this.disabled == true;
    final child = this.child;

    final name = DefaultTextStyle(
      style: TailTypo()
          .font_size(theme.fontSizeLg)
          .text_color(disabled ? theme.textColor3 : theme.textColor)
          .TextStyle(),
      child: Center(child: child ?? Text(this.name)),
    );

    final subname = this.subname == null || child != null
        ? nil
        : TailBox().mt(theme.paddingXs).as((s) {
            return s.Container(
              child: TailTypo()
                  .text_color(theme.textColor2)
                  .font_size(theme.fontSizeSm)
                  .text_center()
                  .line_height(theme.lineHeightSm / fontSize)
                  .Text("${this.subname}"),
            );
          });

    return Pressable((pressed) {
      final bg = !disabled && pressed ? theme.gray2 : theme.background2;
      return TailBox().bg(bg).px(px).py(py).as((s) {
        return s.Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              name,
              subname,
            ],
          ),
        );
      });
    });
  }
}
