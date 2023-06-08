import 'package:flutter/widgets.dart';

import '../_util/default_constraint.dart';
import '../_util/with_value.dart';
import '../picker/toolbar.dart';
import 'panel.dart';

class VanDatePicker extends DatePickerPanel {
  final dynamic title;
  final String? confirmText;
  final String? cancelText;
  final Function(List<int>? value)? onConfirm;
  final Function(List<int>? value)? onCancel;

  const VanDatePicker({
    this.title,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    super.minDate,
    super.maxDate,
    super.value,
    super.columnsType,
    super.onChange,
    super.formatter,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WithValue(value, (model) {
      return Column(mainAxisSize: MainAxisSize.min, children: [
        PickerToolBar(
          title: title ?? "选择日期",
          cancelText: cancelText,
          confirmText: confirmText,
          onCancel: () => onCancel?.call(model.value),
          onConfirm: () => onConfirm?.call(model.value),
        ),
        LayoutBuilder(builder: (_, con) {
          return DefaultConstraint(
            maxHeight: 264,
            child: DatePickerPanel(
              value: model.value,
              onChange: (value) {
                model.value = value;
                onChange?.call(value);
              },
              columnsType: columnsType,
              minDate: minDate,
              maxDate: maxDate,
              formatter: formatter,
            ),
          );
        }),
      ]);
    });
  }
}
