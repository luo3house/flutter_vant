import 'package:flutter/widgets.dart';

import 'package:tailstyle/tailstyle.dart';

import '../../utils/nil.dart';
import '../config/index.dart';
import 'extent.dart';
import 'selection_provider.dart';

class CalendarDay extends StatelessWidget {
  final double? width;
  final CalendarExtent extent;
  final DateTime date;
  final bool? disabled;
  final dynamic top;
  final dynamic bottom;

  const CalendarDay({
    required this.extent,
    required this.date,
    this.width,
    this.disabled,
    this.top,
    this.bottom,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);
    final selection = CalendarSelectionProvider.of(context);

    final disabled = this.disabled == true;

    final isRangeFirst = selection.isRangeFirst(date);
    final isRangeLast = selection.isRangeLast(date);
    var isBetween = false;
    final wrapper = () {
      final box = TailBox();
      if (isRangeFirst) {
        box.bg(theme.primaryColor);
        box.rounded_tl(theme.radiusMd);
        box.rounded_bl(theme.radiusMd);
      } else if (isRangeLast) {
        box.bg(theme.primaryColor);
        box.rounded_tr(theme.radiusMd);
        box.rounded_br(theme.radiusMd);
      } else if (selection.isRangeContains(date)) {
        isBetween = true;
      } else if (selection.isSelected(date)) {
        box.bg(theme.primaryColor).rounded(theme.radiusMd);
      }
      return box;
    }();

    final Widget top = () {
      final top = this.top;
      if (top is Widget) {
        return top;
      } else if (top is String) {
        return TailTypo().font_size(theme.fontSizeXs).Text(top);
      } else {
        return nil;
      }
    }();

    final bottomFromRange = () {
      if (isRangeFirst) return "开始";
      if (isRangeLast) return "结束";
      return null;
    }();

    final Widget bottom = () {
      final bottom = this.bottom;
      final typo = TailTypo().text_center().font_size(theme.fontSizeXs);
      if (bottom is Widget) {
        return bottom;
      } else if (bottom is String) {
        return typo.Text(bottom);
      } else if (bottomFromRange != null) {
        return typo.Text(bottomFromRange);
      } else {
        return nil;
      }
    }();

    final textStyle = () {
      final typo = TailTypo().font_size(theme.fontSizeMd);
      if (disabled) {
        typo.text_color(theme.textColor3);
      } else if (selection.isRangeFirst(date) ||
          selection.isRangeContains(date) ||
          selection.isSelected(date)) {
        typo.text_color(isBetween ? theme.primaryColor : theme.white);
      }
      return typo.TextStyle();
    }();

    final pathMask = () {
      if (!isBetween || disabled) return nil;
      return Opacity(opacity: 0.1, child: Container(color: theme.primaryColor));
    }();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => (disabled ? null : selection.onDaySelect)?.call(date),
      child: wrapper.as((styled) {
        return styled.Container(
          clipBehavior: Clip.hardEdge,
          width: width,
          height: extent.getDayHeight(),
          child: DefaultTextStyle.merge(
            style: textStyle,
            child: Stack(alignment: Alignment.center, children: [
              Positioned(top: 6, bottom: 0, child: top),
              TailTypo().font_size(theme.fontSizeLg).Text(date.day.toString()),
              Positioned(top: null, bottom: 6, child: bottom),
              Positioned.fill(child: isBetween ? pathMask : nil),
            ]),
          ),
        );
      }),
    );
  }
}
