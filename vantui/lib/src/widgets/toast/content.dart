import 'package:flutter/widgets.dart';
import 'package:tailstyle/tailstyle.dart';

import '../../utils/nil.dart';
import '../config/index.dart';
import '../icon/index.dart';
import 'types.dart';

class VanToastContent extends StatelessWidget {
  final VanToastType? type;
  final EdgeInsets? padding;
  final dynamic icon;
  final dynamic child;

  const VanToastContent({
    this.type,
    this.padding,
    this.icon,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    final color = theme.white;

    const bg = Color(0xB3000000);

    final radius = theme.radiusLg;

    final icon = () {
      const fontSize = 36.0;
      final icon = this.icon;
      if (icon is Widget) return icon;
      if (icon is IconData) {
        return Icon(icon, size: fontSize, color: color);
      } else if (type == VanToastType.success) {
        return Icon(VanIcons.success, size: fontSize, color: color);
      } else if (type == VanToastType.fail) {
        return Icon(VanIcons.fail, size: fontSize, color: color);
      } else {
        return nil;
      }
    }();

    final iconPa = icon != nil ? theme.paddingMd : null;

    final pl = padding?.left ?? iconPa ?? 12.0;
    final pt = padding?.top ?? iconPa ?? 8.0;
    final pr = padding?.right ?? iconPa ?? 12.0;
    final pb = padding?.bottom ?? iconPa ?? 8.0;

    final textStyle = TextStyle(color: color);

    final text = () {
      final child = this.child;
      if (child is Widget) {
        return child;
      } else if (child is String) {
        return Text(child);
      } else {
        return nil;
      }
    }();

    return TailBox().bg(bg).rounded(radius).as((styled) {
      return styled.pl(pl).pt(pt).pr(pr).pb(pb).as((styled) {
        return styled.Container(
          clipBehavior: Clip.hardEdge,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            icon,
            icon != nil ? SizedBox(height: theme.paddingXs) : nil,
            DefaultTextStyle(style: textStyle, child: text),
          ]),
        );
      });
    });
  }
}
