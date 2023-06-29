import 'dart:math';

import 'package:flutter_vantui/src/utils/date_util.dart';

class CalendarExtent {
  final double? dayHeight;

  const CalendarExtent({this.dayHeight});

  double getDayHeight() => dayHeight ?? 64;
  double getHeaderHeight() => getDayHeight();

  double getStickyHeaderHeight() => 50;

  double getWeekdaysHeight() => 30;

  /// MonthBodyExtent = HeaderE + rows * dayE
  double getMonthBodyHeight(int year, int month) {
    return getMonthHeaderHeight() +
        DateUtil.getWeekRowsByYearMonth(year, month) * getDayHeight();
  }

  double getMonthHeaderHeight() => getDayHeight();

  int getStickyIndexByScrollOffset(
    double offset,
    Map<double, int> offsetMap,
  ) {
    final offsetSubtracted = max(0, offset - getWeekdaysHeight());

    final offsets = offsetMap.keys;
    var archieveOffset = 0.0;
    for (var expectOffset in offsets) {
      if (offsetSubtracted >= expectOffset) {
        archieveOffset = expectOffset;
      } else {
        break;
      }
    }
    return offsetMap[archieveOffset] ?? 0;
  }
}
