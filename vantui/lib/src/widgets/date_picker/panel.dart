import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/utils/date_util.dart';
import 'package:dart_date/dart_date.dart';

import '../../utils/std.dart';
import '../../utils/vo.dart';
import '../picker/panel.dart';
import 'types.dart';

class DatePickerPanel extends StatelessWidget {
  static const defaultColumnsType = {
    VanDateColumn.year,
    VanDateColumn.month,
    VanDateColumn.day,
  };

  static List<int> valueOf(DateTime date,
      [Set<VanDateColumn> columnsType = defaultColumnsType]) {
    return List.generate(columnsType.length, (index) {
      if (columnsType.elementAt(index) == VanDateColumn.year) {
        return date.year;
      } else if (columnsType.elementAt(index) == VanDateColumn.month) {
        return date.month;
      } else if (columnsType.elementAt(index) == VanDateColumn.day) {
        return date.day;
      } else {
        return 0;
      }
    });
  }

  static DateTime fromValue(List<int> value,
      [Set<VanDateColumn> columnsType = defaultColumnsType]) {
    int year = DateTime.now().year;
    int month = 1;
    int day = 1;
    List.generate(columnsType.length, (index) {
      if (columnsType.elementAt(index) == VanDateColumn.year) {
        year = value.length > index ? value[index] : 0;
      } else if (columnsType.elementAt(index) == VanDateColumn.month) {
        month = value.length > index ? value[index] : 0;
      } else if (columnsType.elementAt(index) == VanDateColumn.day) {
        day = value.length > index ? value[index] : 0;
      }
    });
    day = min(day, DateUtil.getDaysInMonth(year, month));
    return DateTime(year, month, day);
  }

  final DateTime? minDate;
  final DateTime? maxDate;
  final List<int>? value;
  final Set<VanDateColumn>? columnsType;
  final Function(List<int> value)? onChange;
  final Map<VanDateColumn, OptionFormatter>? formatter;

  const DatePickerPanel({
    this.minDate,
    this.maxDate,
    this.value,
    this.columnsType,
    this.onChange,
    this.formatter,
    super.key,
  });

  NamedValue Function(NamedValue) getFormatter(VanDateColumn typ) {
    return formatter?[typ] ?? (option) => option;
  }

  @override
  Widget build(BuildContext context) {
    final minDate = this.minDate ?? DateTime.now().subYears(10);
    final maxDate = this.maxDate ?? DateTime.now().addYears(10);
    final columnsType = this.columnsType ?? defaultColumnsType;

    final options = <List<NamedValue>>[];
    final normalizeValues = <int>[];
    int? curYear;
    int? curMonth;
    int? curDay;

    for (var i = 0; i < columnsType.length; i++) {
      final col = columnsType.elementAt(i);
      if (col == VanDateColumn.year) {
        curYear = tryCatch(() => value!.elementAt(i)) ?? minDate.year;
        normalizeValues.add(curYear);
        options.add(
          List.of(DateRangeUtil.rangeYears(minDate, maxDate)
              .map((year) => NamedValue(year.toString(), year))
              .map(getFormatter(VanDateColumn.year))),
        );
      } else if (col == VanDateColumn.month) {
        curMonth = tryCatch(() => value!.elementAt(i)) ?? minDate.month;
        normalizeValues.add(curMonth);
        options.add(
          List.of(DateRangeUtil.rangeMonths(minDate, maxDate, curYear)
              .map((year) => NamedValue(year.toString(), year))
              .map(getFormatter(VanDateColumn.month))),
        );
      } else if (col == VanDateColumn.day) {
        curDay = tryCatch(() => value!.elementAt(i)) ?? minDate.day;
        normalizeValues.add(curDay);
        options.add(
          List.of(DateRangeUtil.rangeDays(minDate, maxDate, curYear, curMonth)
              .map((year) => NamedValue(year.toString(), year))
              .map(getFormatter(VanDateColumn.day))),
        );
      }
    }

    return PickerPanel(
      columns: options,
      values: normalizeValues,
      onChange: (values, colIndex) {
        final newDate = fromValue(List<int>.from(values), columnsType);
        final clampDate = newDate.isBefore(minDate)
            ? minDate
            : newDate.isAfter(maxDate)
                ? maxDate
                : newDate;
        onChange?.call(valueOf(clampDate, columnsType));
      },
    );
  }
}
