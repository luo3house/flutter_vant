import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/widgets/_util/default_constraint.dart';

import '../_util/with_value.dart';
import '../picker/toolbar.dart';
import 'panel.dart';

class TimePicker extends TimePickerPanel {
  final dynamic title;
  final String? confirmText;
  final String? cancelText;
  final Function(List<int>? value)? onConfirm;
  final Function(List<int>? value)? onCancel;

  const TimePicker({
    this.title,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    super.columnsType,
    super.value,
    super.onChange,
    super.minHour,
    super.maxHour,
    super.minMinute,
    super.maxMinute,
    super.minSecond,
    super.maxSecond,
    super.formatter,
    super.filter,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WithValue(value, (model) {
      return Column(mainAxisSize: MainAxisSize.min, children: [
        PickerToolBar(
          title: title ?? "选择时间",
          cancelText: cancelText,
          confirmText: confirmText,
          onCancel: () => onCancel?.call(model.value),
          onConfirm: () => onConfirm?.call(model.value),
        ),
        LayoutBuilder(builder: (_, con) {
          return DefaultConstraint(
            maxHeight: 264,
            child: TimePickerPanel(
              value: model.value,
              onChange: (value) {
                model.value = value;
                onChange?.call(value);
              },
              columnsType: columnsType,
              minHour: minHour,
              maxHour: maxHour,
              minMinute: minMinute,
              maxMinute: maxMinute,
              minSecond: minSecond,
              maxSecond: maxSecond,
              formatter: formatter,
              filter: filter,
            ),
          );
        }),
      ]);
    });
  }
}
