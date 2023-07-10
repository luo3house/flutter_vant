import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/utils/date_util.dart';
import 'package:dart_date/dart_date.dart';

import '../../utils/std.dart';
import '../../utils/vo.dart';
import '../picker/panel.dart';
import 'types.dart';

// @DocsId("datepicker")

class DatePickerPanel extends StatelessWidget {
  static const defaultColumnsType = {
    DateColumn.year,
    DateColumn.month,
    DateColumn.day,
  };

  static List<int> valueOf(DateTime date,
      [Set<DateColumn> columnsType = defaultColumnsType]) {
    return List.generate(columnsType.length, (index) {
      if (columnsType.elementAt(index) == DateColumn.year) {
        return date.year;
      } else if (columnsType.elementAt(index) == DateColumn.month) {
        return date.month;
      } else if (columnsType.elementAt(index) == DateColumn.day) {
        return date.day;
      } else {
        return 0;
      }
    });
  }

  static DateTime fromValue(List<int> value,
      [Set<DateColumn> columnsType = defaultColumnsType]) {
    int year = DateTime.now().year;
    int month = 1;
    int day = 1;
    List.generate(columnsType.length, (index) {
      if (columnsType.elementAt(index) == DateColumn.year) {
        year = value.length > index ? value[index] : 0;
      } else if (columnsType.elementAt(index) == DateColumn.month) {
        month = value.length > index ? value[index] : 0;
      } else if (columnsType.elementAt(index) == DateColumn.day) {
        day = value.length > index ? value[index] : 0;
      }
    });
    day = min(day, DateUtil.getDaysInMonth(year, month));
    return DateTime(year, month, day);
  }

  // @DocsProp("minDate", "DateTime", "最小日期")
  final DateTime? minDate;
  // @DocsProp("maxDate", "DateTime", "最大日期")
  final DateTime? maxDate;
  // @DocsProp("value", "List<int>", "当前已选日期")
  final List<int>? value;
  // @DocsProp("columnsType", "Set<year | month | day>", "日期列")
  final Set<DateColumn>? columnsType;
  // @DocsProp("onChange", "Function(List<int> values)", "值变化回调")
  final Function(List<int> value)? onChange;
  // @DocsProp("formatter", "Map<year | month | day, NamedValue Function(NamedValue option)>", "格式化选项")
  final Map<DateColumn, OptionFormatter>? formatter;

  const DatePickerPanel({
    this.minDate,
    this.maxDate,
    this.value,
    this.columnsType,
    this.onChange,
    this.formatter,
    super.key,
  });

  INamedValue Function(INamedValue) getFormatter(DateColumn typ) {
    return formatter?[typ] ?? (option) => option;
  }

  PickerOption toPickerOption(INamedValue option) {
    return PickerOption(option.name, option.value);
  }

  @override
  Widget build(BuildContext context) {
    final minDate = this.minDate ?? DateTime.now().subYears(10);
    final maxDate = this.maxDate ?? DateTime.now().addYears(10);
    final columnsType = this.columnsType ?? defaultColumnsType;

    final options = <List<PickerOption>>[];
    final normalizeValues = <int>[];
    int? curYear;
    int? curMonth;
    int? curDay;

    for (var i = 0; i < columnsType.length; i++) {
      final col = columnsType.elementAt(i);
      if (col == DateColumn.year) {
        curYear = tryCatch(() => value!.elementAt(i)) ?? minDate.year;
        normalizeValues.add(curYear);
        options.add(
          List.of(DateRangeUtil.rangeYears(minDate, maxDate)
              .map((year) => NamedValue(year.toString(), year))
              .map(getFormatter(DateColumn.year))
              .map(toPickerOption)),
        );
      } else if (col == DateColumn.month) {
        curMonth = tryCatch(() => value!.elementAt(i)) ?? minDate.month;
        normalizeValues.add(curMonth);
        options.add(
          List.of(DateRangeUtil.rangeMonths(minDate, maxDate, curYear)
              .map((year) => NamedValue(year.toString(), year))
              .map(getFormatter(DateColumn.month))
              .map(toPickerOption)),
        );
      } else if (col == DateColumn.day) {
        curDay = tryCatch(() => value!.elementAt(i)) ?? minDate.day;
        normalizeValues.add(curDay);
        options.add(
          List.of(DateRangeUtil.rangeDays(minDate, maxDate, curYear, curMonth)
              .map((year) => NamedValue(year.toString(), year))
              .map(getFormatter(DateColumn.day))
              .map(toPickerOption)),
        );
      }
    }

    return PickerPanel(
      columns: options,
      values: normalizeValues,
      onChange: (values) {
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
