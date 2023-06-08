import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/widgets/_util/touch_opacity.dart';
import 'package:tailstyle/tailstyle.dart';

import '../../utils/nil.dart';
import '../config/index.dart';
import '../icon/index.dart';

class VanNavBar extends StatelessWidget implements PreferredSizeWidget {
  static const height = 46.0;

  final dynamic title;
  final dynamic leftText;
  final dynamic leftArrow;
  final Widget? left;
  final Function()? onLeftTap;
  final dynamic rightText;
  final dynamic rightArrow;
  final Widget? right;
  final Function()? onRightTap;
  final bool? noBorder;

  const VanNavBar({
    this.title,
    this.leftText,
    this.leftArrow,
    this.left,
    this.onLeftTap,
    this.rightText,
    this.rightArrow,
    this.right,
    this.onRightTap,
    this.noBorder,
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    final sideTextStyle = TailTypo()
        .font_size(theme.fontSizeMd)
        .text_color(theme.primaryColor)
        .TextStyle();

    final sideIconTheme = IconThemeData(
      size: 16,
      color: theme.primaryColor,
    );

    final titleTextStyle = TailTypo()
        .font_size(theme.fontSizeLg)
        .text_color(theme.gray8)
        .font_bold()
        .TextStyle();

    final titleIconTheme = IconThemeData(
      size: theme.fontSizeLg,
      color: theme.gray8,
    );

    final left = () {
      if (this.left is Widget) {
        return this.left as Widget;
      } else {
        return NavBarBtn(
          icon: leftArrow == true ? VanIcons.arrow_left : leftArrow,
          onTap: () => onLeftTap?.call(),
          text: leftText,
        );
      }
    }();

    final right = () {
      if (this.right is Widget) {
        return this.right as Widget;
      } else {
        return NavBarBtn(
          icon: rightArrow == true ? VanIcons.arrow : rightArrow,
          onTap: () => onRightTap?.call(),
          text: rightText,
        );
      }
    }();

    final title = () {
      if (this.title is Widget) {
        return this.title as Widget;
      } else {
        return Text("${this.title}");
      }
    }();

    final bg = theme.background2;
    final border = theme.borderColor;
    final borderW = noBorder == true ? 0.0 : 0.5;

    return TailBox().bg(bg).border_b(border, borderW).as((s) {
      return s.Container(
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            DefaultTextStyle(
              style: sideTextStyle,
              child: IconTheme(
                data: sideIconTheme,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [left, right],
                ),
              ),
            ),
            DefaultTextStyle(
              style: titleTextStyle,
              child: IconTheme(
                data: titleIconTheme,
                child: title,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class NavBarBtn extends StatelessWidget {
  final Function()? onTap;
  final dynamic icon;
  final dynamic text;
  final double? px; // padding x

  const NavBarBtn({
    this.onTap,
    this.icon,
    this.text,
    this.px,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);
    final px = this.px ?? theme.paddingMd;

    final icon = () {
      if (this.icon is Widget) {
        return this.icon as Widget;
      } else if (this.icon is IconData) {
        return Icon(this.icon as IconData);
      } else {
        return nil;
      }
    }();

    final text = () {
      if (this.text is Widget) {
        return this.text as Widget;
      } else if (this.text == null) {
        return nil;
      } else {
        return Text("${this.text}");
      }
    }();

    return TouchOpacity(
      onTap: () => onTap?.call(),
      child: TailBox().px(px).as((s) {
        return s.Container(
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            icon,
            SizedBox(width: icon == nil ? 0 : theme.paddingBase),
            text,
          ]),
        );
      }),
    );
  }
}
