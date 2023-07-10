import 'package:flutter/widgets.dart';
import '../../utils/std.dart';
import '../../utils/vo.dart';
import '../date_picker/types.dart';
import '../picker/panel.dart';
import 'types.dart';

// @DocsId("time_picker")

class TimePickerPanel extends StatelessWidget {
  static const defaultColumnsType = {
    TimePickerColumn.hour,
    TimePickerColumn.minute,
    TimePickerColumn.second,
  };

  // @DocsProp("columnsType", "Set<hour | minute | second>", "时间列")
  final Set<TimePickerColumn>? columnsType;
  // @DocsProp("value", "List<int>", "当前值")
  final List<int>? value;
  // @DocsProp("onChange", "List<int>", "值变化触发")
  final Function(List<int> value)? onChange;
  // @DocsProp("minHour", "int", "最小小时")
  final int? minHour;
  // @DocsProp("maxHour", "int", "最大小时")
  final int? maxHour;
  // @DocsProp("minMinute", "int", "最小分钟")
  final int? minMinute;
  // @DocsProp("maxMinute", "int", "最大分钟")
  final int? maxMinute;
  // @DocsProp("minSecond", "int", "最小秒")
  final int? minSecond;
  // @DocsProp("maxSecond", "int", "最大秒")
  final int? maxSecond;
  // @DocsProp("minHour", "Map<hour | minute | second, NamedValue Function(NamedValue option)", "选项格式化")
  final Map<TimePickerColumn, OptionFormatter>? formatter;
  // @DocsProp("filter", "Map<hour | minute | second, List<NamedValue> Function(List<NamedValue>)", "过滤选项")
  final Map<TimePickerColumn, OptionFilter>? filter;

  const TimePickerPanel({
    this.columnsType,
    this.value,
    this.onChange,
    this.minHour,
    this.maxHour,
    this.minMinute,
    this.maxMinute,
    this.minSecond,
    this.maxSecond,
    this.formatter,
    this.filter,
    super.key,
  });

  INamedValue Function(INamedValue) getFormatter(TimePickerColumn typ) {
    return formatter?[typ] ?? (option) => option;
  }

  List<INamedValue> applyFilter(
      TimePickerColumn typ, List<INamedValue> options) {
    return filter?[typ]?.call(options) ?? options;
  }

  INamedValue padStartFormatter(INamedValue option) {
    return NamedValue("${option.value}".padLeft(2, '0'), option.value);
  }

  PickerOption toPickerOption(INamedValue option) {
    return PickerOption(option.name, option.value);
  }

  @override
  Widget build(BuildContext context) {
    final minHour = this.minHour ?? 0;
    final maxHour = this.maxHour ?? 23;
    final minMinute = this.minMinute ?? 0;
    final maxMinute = this.maxMinute ?? 59;
    final minSecond = this.minSecond ?? 0;
    final maxSecond = this.maxSecond ?? 59;

    final options = <List<PickerOption>>[];
    final columnsType = this.columnsType ?? defaultColumnsType;
    final normalizeValue = <int>[];

    for (var i = 0; i < columnsType.length; i++) {
      if (columnsType.elementAt(i) == TimePickerColumn.hour) {
        normalizeValue.add(tryCatch(() => value!.elementAt(i)) ?? minHour);
        options.add(
          List.of(applyFilter(
            TimePickerColumn.hour,
            List.of(range(minHour, maxHour)
                .map((h) => NamedValue(h.toString(), h))
                .map(padStartFormatter)
                .map(getFormatter(TimePickerColumn.hour))),
          ).map(toPickerOption)),
        );
      } else if (columnsType.elementAt(i) == TimePickerColumn.minute) {
        normalizeValue.add(tryCatch(() => value!.elementAt(i)) ?? minMinute);
        options.add(
          List.of(applyFilter(
            TimePickerColumn.minute,
            List.of(range(minMinute, maxMinute)
                .map((m) => NamedValue(m.toString(), m))
                .map(padStartFormatter)
                .map(getFormatter(TimePickerColumn.minute))),
          ).map(toPickerOption)),
        );
      } else if (columnsType.elementAt(i) == TimePickerColumn.second) {
        normalizeValue.add(tryCatch(() => value!.elementAt(i)) ?? minSecond);
        options.add(
          List.of(applyFilter(
            TimePickerColumn.second,
            List.of(range(minSecond, maxSecond)
                .map((s) => NamedValue(s.toString(), s))
                .map(padStartFormatter)
                .map(getFormatter(TimePickerColumn.second))),
          ).map(toPickerOption)),
        );
      }
    }

    return PickerPanel(
      columns: options,
      values: normalizeValue,
      onChange: (values) => onChange?.call(List.from(values)),
    );
  }
}
