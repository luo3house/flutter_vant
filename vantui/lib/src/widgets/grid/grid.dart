import 'package:flutter/widgets.dart';
import 'package:tailstyle/tailstyle.dart';

import '../../utils/nil.dart';
import '../_util/value_provider.dart';
import '../badge/badge.dart';
import '../button/pressable.dart';
import '../config/index.dart';

class VanGrid extends StatelessWidget {
  final bool? square;
  final int? columnNum;
  final double? gutter;
  final List<GridItem>? children;
  const VanGrid({
    this.square,
    this.columnNum,
    this.gutter,
    this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final columnNum = this.columnNum ?? 4;
    final gutter = this.gutter ?? 0;
    final square = this.square ?? false;
    final children = this.children ?? const [];
    assert(columnNum > 0);

    final theme = VanConfig.ofTheme(context);

    final borderC = theme.borderColor;

    final childrenHasChild =
        children.fold(false, (pre, cur) => pre || cur.child != null);

    final wrapBorderT = childrenHasChild || gutter > 0 ? 0.0 : 1.0;

    final rowLen = (children.length / columnNum).ceil();

    return LayoutBuilder(builder: (_, con) {
      final itemWidth = ((con.maxWidth - gutter) / columnNum) - gutter;
      final itemHeight = square ? itemWidth : null;
      final wrapMarginL = gutter;

      return ValueProvider(
        value: GridItemMeasure(itemWidth, itemHeight, gutter),
        child: TailBox().ml(wrapMarginL).border_t(borderC, wrapBorderT).as((s) {
          return s.Container(
            child: Column(
              children: List.generate(rowLen, (rowIndex) {
                final cells = List.generate(columnNum, (index) {
                  final itemIndex = rowIndex * columnNum + index;
                  return children.length > itemIndex
                      ? children[itemIndex]
                      : nil;
                });
                return Row(children: cells);
              }),
            ),
          );
        }),
      );
    });
  }
}

class GridItem extends VanGrid {
  final String? text;
  final dynamic icon;
  final dynamic badge;
  final bool? dot;
  final Axis? direction;
  final Widget? child;
  final bool? clickable;
  final Function()? onTap;

  const GridItem({
    this.text,
    this.icon,
    this.badge,
    this.dot,
    this.child,
    this.direction,
    this.clickable,
    this.onTap,
    super.key,
  });

  GridItem copyWith({
    String? text,
    dynamic icon,
    dynamic badge,
    bool? dot,
    Axis? direction,
    Widget? child,
    bool? clickable,
    Function()? onTap,
  }) =>
      GridItem(
        key: key,
        text: text ?? this.text,
        icon: icon ?? this.icon,
        badge: badge ?? this.badge,
        dot: dot ?? this.dot,
        direction: direction ?? this.direction,
        clickable: clickable ?? this.clickable,
        onTap: onTap ?? this.onTap,
        child: child ?? this.child,
      );

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);
    final measure = ValueProvider.ofn<GridItemMeasure>(context)!.value;

    final direction = this.direction ?? Axis.vertical;
    final clickable = this.clickable ?? false;

    final textStyle = TailTypo() //
        .text_color(theme.gray8)
        .font_size(theme.fontSizeSm)
        .TextStyle();
    final iconTheme = IconThemeData(size: 28, color: theme.gray8);

    final badgeContent = badge ?? 0; // 0 = hide
    final badgeDot = dot == true;

    final icon = () {
      if (this.icon is Widget) {
        return this.icon as Widget;
      } else if (this.icon is IconData) {
        return Icon(this.icon as IconData);
      } else {
        return nil;
      }
    }();

    final iconBadge = VanBadge(
      content: badgeContent,
      dot: badgeDot,
      child: icon,
    );

    final text = () {
      if (this.text == null) {
        return nil;
      } else {
        final ml = direction == Axis.horizontal ? theme.paddingXs : 0.0;
        final mt = direction == Axis.vertical ? theme.paddingXs : 0.0;
        return TailBox()
            .ml(icon != nil ? ml : 0)
            .mt(icon != nil ? mt : 0)
            .Container(child: Text(this.text!));
      }
    }();

    final py = theme.paddingMd;
    final px = theme.paddingXs;
    final border = theme.borderColor;

    final inner = () {
      if (child is Widget) {
        return child;
      } else {
        return DefaultTextStyle(
          style: textStyle,
          child: IconTheme(
            data: iconTheme,
            child: Center(
              child: Flex(
                direction: direction,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [iconBadge, text],
              ),
            ),
          ),
        );
      }
    }();

    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Pressable((pressed) {
        final bg = clickable && pressed ? theme.gray3 : theme.background2;

        return TailBox()
            .bg(bg)
            .py(py)
            .px(px)
            .mt(measure.gutter)
            .mr(measure.gutter)
            .border_l(border, child == null && measure.gutter > 0 ? 1 : 0)
            .border_t(border, child == null && measure.gutter > 0 ? 1 : 0)
            .border_r(border, child == null ? 1 : 0)
            .border_b(border, child == null ? 1 : 0)
            .Container(
              width: measure.width,
              height: measure.height,
              child: inner,
            );
      }),
    );
  }
}

class GridItemMeasure {
  final double? width;
  final double? height;
  final double gutter;
  GridItemMeasure(this.width, this.height, this.gutter);
}
