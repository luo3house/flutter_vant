import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/widgets/_util/default_constraint.dart';

import '../_util/with_value.dart';
import '../picker/toolbar.dart';
import 'panel.dart';

// @DocsId("time_picker")

class TimePicker extends TimePickerPanel {
  // @DocsProp("title", "Widget | String", "面板标题")
  final dynamic title;
  // @DocsProp("confirmText", "String", "确认文本")
  final String? confirmText;
  // @DocsProp("cancelText", "String", "取消文本")
  final String? cancelText;
  // @DocsProp("onConfirm", "Function(List<int>)", "确认触发")
  final Function(List<int>? value)? onConfirm;
  // @DocsProp("onCancel", "Function(List<int>)", "取消触发")
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
