import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/widgets/calendar/panel.dart';

import '../_util/with_value.dart';
import '../picker/toolbar.dart';

class Calendar extends CalendarPanel {
  final dynamic title;
  final String? confirmText;
  final String? cancelText;
  final Function(List<DateTime>? value)? onConfirm;
  final Function(List<DateTime>? value)? onCancel;

  const Calendar({
    this.title,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    super.minDate,
    super.maxDate,
    super.dayHeight,
    super.type,
    super.value,
    super.onChange,
    super.expands,
    super.key,
  });

  @override
  State createState() {
    return _CalendarState();
  }
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    final title = widget.title;
    final confirmText = widget.confirmText;
    final cancelText = widget.cancelText;
    final onConfirm = widget.onConfirm;
    final onCancel = widget.onCancel;
    final value = widget.value;
    final onChange = widget.onChange;
    final expands = widget.expands;

    return WithValue(value, (model) {
      return Column(mainAxisSize: MainAxisSize.min, children: [
        PickerToolBar(
          title: title ?? "选择日期",
          cancelText: cancelText,
          confirmText: confirmText,
          onCancel: () => onCancel?.call(model.value),
          onConfirm: () => onConfirm?.call(model.value),
        ),
        Expanded(
          flex: expands == true ? 1 : 0,
          child: CalendarPanel(
            value: model.value,
            onChange: (value) {
              model.value = value;
              onChange?.call(value);
            },
            minDate: widget.minDate,
            maxDate: widget.maxDate,
            dayHeight: widget.dayHeight,
            type: widget.type,
            expands: widget.expands,
          ),
        ),
      ]);
    });
  }
}
