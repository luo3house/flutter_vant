import 'dart:math';

import 'package:flutter_vantui/src/utils/date_util.dart';

class CalendarExtent {
  final double? dayHeight;

  const CalendarExtent({this.dayHeight});

  double getDayHeight() => dayHeight ?? 64;

  double getWeekdaysHeight() => 30;
  double getHeaderHeight() => 44;

  /// MonthBody
  double getMonthBodyHeight() {
    return getMonthHeaderHeight() + DateUtil.getMaxWeekRows() * getDayHeight();
  }

  double getMonthHeaderHeight() => 44;

  int getIndexByDeltaY(double dy) {
    return max(
      0.0,
      (dy - getWeekdaysHeight() - getHeaderHeight()) / getMonthBodyHeight(),
    ).floor();
  }
}
