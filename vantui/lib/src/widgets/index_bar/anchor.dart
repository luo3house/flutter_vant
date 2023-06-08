import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:tailstyle/tailstyle.dart';

import '../config/index.dart';
import 'anchor_state.dart';

class IndexBarAnchor extends StatelessWidget implements PreferredSizeWidget {
  static const defaultHeight = 32.0;

  final String index;
  final dynamic child;

  const IndexBarAnchor(this.index, {this.child, super.key});

  double get height => defaultHeight;

  @override
  Size get preferredSize => const Size.fromHeight(defaultHeight);

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);
    // final selected = AnchorState.of(context)?.selected == true;
    final selected = false;

    final bg = selected ? theme.background2 : theme.background;
    final color = selected ? theme.primaryColor : theme.textColor;

    final px = theme.paddingMd;

    final textStyle = TailTypo()
        .text_color(color)
        .font_size(theme.fontSizeMd)
        .font_bold()
        .TextStyle();

    final border = theme.gray3;

    final child = () {
      if (this.child is Widget) {
        return this.child as Widget;
      } else {
        return Text("${this.child ?? index}");
      }
    }();

    return DefaultTextStyle(
      style: textStyle,
      child: TailBox().bg(bg).px(px).border(border, selected ? .5 : 0).as((s) {
        return s.Container(
          height: defaultHeight,
          child: Align(alignment: Alignment.centerLeft, child: child),
        );
      }),
    );
  }
}
