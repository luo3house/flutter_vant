import 'package:flutter/widgets.dart';

import '../_util/with_value.dart';
import '../picker/toolbar.dart';
import 'panel.dart';

// @DocsId("datepicker")

class DatePicker extends DatePickerPanel {
  // @DocsProp("title", "Widget | String", "面板标题")
  final dynamic title;
  // @DocsProp("confirmText", "String", "确认文本")
  final String? confirmText;
  // @DocsProp("cancelTetx", "String", "取消文班")
  final String? cancelText;
  // @DocsProp("onConfirm", "Function(List<int>)", "确认回调")
  final Function(List<int>? value)? onConfirm;
  // @DocsProp("onCancel", "Function(List<int>)", "取消回调")
  final Function(List<int>? value)? onCancel;

  const DatePicker({
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
        DatePickerPanel(
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
      ]);
    });
  }
}
