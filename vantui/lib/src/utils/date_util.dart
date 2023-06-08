import 'package:flutter/material.dart'
    show DefaultMaterialLocalizations, DateUtils;
import 'package:flutter_vantui/flutter_vantui.dart';

const _defaultLocalizations = DefaultMaterialLocalizations();

class DateUtil {
  DateUtil._();

  static int getWeekRowsByYearMonth(int year, int month) {
    return getWeekRows(
      getFirstDayOffset(year, month),
      getDaysInMonth(year, month),
    );
  }

  static int getWeekRows(int firstDayOffset, int days) {
    return ((days + firstDayOffset) / DateTime.daysPerWeek).ceil();
  }

  static int getMaxWeekRows() {
    const maxFirstDayOffset = 6;
    const maxDaysPerMonth = 31;
    return getWeekRows(maxFirstDayOffset, maxDaysPerMonth);
  }

  /// from material
  static int getFirstDayOffset(int year, int month) {
    return DateUtils.firstDayOffset(year, month, _defaultLocalizations);
  }

  static int getDaysInMonth(int year, int month) {
    return DateUtils.getDaysInMonth(year, month);
  }

  static int nowms() => DateTime.now().millisecondsSinceEpoch;
}

class DateRangeUtil {
  DateRangeUtil._();

  static List<int> rangeYears(DateTime min, DateTime max) {
    return range(min.year, max.year);
  }

  static List<int> rangeMonths(DateTime min, DateTime max, [int? curYear]) {
    if (curYear == null) {
      return range(min.month, max.month);
    } else if (curYear == min.year) {
      if (min.year != max.year) {
        return range(min.month, 12);
      } else {
        return range(min.month, max.month);
      }
    } else if (curYear == max.year) {
      return range(1, max.month);
    } else {
      return range(1, 12);
    }
  }

  static List<int> rangeDays(DateTime min, DateTime max,
      [int? curYear, int? curMonth]) {
    assert(curYear == null || curMonth != null,
        "curMonth must present when curYear presented");

    // if (curYear != null) {} // curMonth != null, orElse go below
    if (curMonth != null) {
      // use minDate year
      curYear ??= min.year;
    } else if (curYear == null) {
      // both year and month empty
      return range(min.day, max.day);
    }

    // both presented
    if (min.year == curYear && min.month == curMonth) {
      return range(min.day, DateUtil.getDaysInMonth(curYear, curMonth!));
    } else if (max.year == curYear && max.month == curMonth) {
      return range(1, max.day);
    } else {
      return range(1, DateUtil.getDaysInMonth(curYear, curMonth!));
    }
  }
}
