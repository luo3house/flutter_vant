import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/widgets/_util/touch_opacity.dart';
import 'package:provider/provider.dart';
import 'package:tailstyle/tailstyle.dart';

import '../../utils/nil.dart';
import '../badge/badge.dart';
import '../config/index.dart';

// @DocsId("tabbar")

class TabBar extends StatelessWidget implements PreferredSizeWidget {
  static const height = 50.0;

  // @DocsProp("value", "dynamic", "当前选中")
  final dynamic value;
  // @DocsProp("onChange", "Function(dynamic)", "选中变化触发")
  final Function(dynamic value)? onChange;
  // @DocsProp("activeColor", "Color", "选中颜色")
  final Color? activeColor;
  // @DocsProp("children", "List<TabBarItem>", "子项")
  final List<TabBarItem>? children;

  const TabBar({
    this.value,
    this.onChange,
    this.activeColor,
    this.children,
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);
    final children = this.children ?? [];

    final scope = TabBarScope(
      activeColor ?? theme.primaryColor,
      value,
      (item) => onChange?.call(item.value),
    );

    final bg = theme.background2;
    return TailBox().bg(bg).as((s) {
      return s.Container(
        height: height,
        child: Provider.value(
          value: scope,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(children.length, (index) {
              return Expanded(child: children[index]);
            }),
          ),
        ),
      );
    });
  }
}

class TabBarItem extends StatelessWidget {
  final dynamic icon;
  final dynamic text;
  final bool? dot;
  final dynamic badge;
  final dynamic value;
  final Widget Function(bool selected)? drawIcon;

  const TabBarItem({
    this.icon,
    this.text,
    this.dot,
    this.badge,
    this.value,
    this.drawIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    return Consumer<TabBarScope>(builder: (_, scope, __) {
      final selected = scope.value == value;

      final textStyle = TailTypo()
          .font_size(theme.fontSizeSm)
          .text_color(selected ? scope.activeColor : theme.textColor)
          .TextStyle();

      final iconTheme = IconThemeData(
        size: 22,
        color: selected ? scope.activeColor : theme.textColor,
      );

      final icon = () {
        if (drawIcon != null) {
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: iconTheme.size!),
            child: drawIcon!.call(selected),
          );
        } else if (this.icon is Widget) {
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

      final badgeContent = badge ?? 0; // 0 = hide
      final badgeDot = dot == true;
      final badgeIcon = Badge(
        content: badgeContent,
        dot: badgeDot,
        dy: theme.paddingBase,
        child: icon,
      );

      return DefaultTextStyle(
        style: textStyle,
        child: IconTheme(
          data: iconTheme,
          child: TouchOpacity(
            activeOpacity: 1,
            onTap: () => scope.onChange(this),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                badgeIcon,
                SizedBox(
                  height: icon == nil || text == nil ? 0 : theme.paddingBase,
                ),
                text,
              ],
            ),
          ),
        ),
      );
    });
  }
}

class TabBarScope {
  final Color activeColor;
  final dynamic value;
  final Function(TabBarItem item) onChange;
  TabBarScope(this.activeColor, this.value, this.onChange);
}
