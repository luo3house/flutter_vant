import 'package:flutter/widgets.dart';
import '../../utils/std.dart';
import '../../utils/vo.dart';
import '../date_picker/types.dart';
import '../picker/panel.dart';
import 'types.dart';

class TimePickerPanel extends StatelessWidget {
  static const defaultColumnsType = {
    TimePickerColumn.hour,
    TimePickerColumn.minute,
    TimePickerColumn.second,
  };

  final Set<TimePickerColumn>? columnsType;
  final List<int>? value;
  final Function(List<int> value)? onChange;
  final int? minHour;
  final int? maxHour;
  final int? minMinute;
  final int? maxMinute;
  final int? minSecond;
  final int? maxSecond;
  final Map<TimePickerColumn, OptionFormatter>? formatter;
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
