import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/widgets/picker/panel.dart';

import '../_util/with_value.dart';
import 'toolbar.dart';

class Picker extends PickerPanel {
  final dynamic title;
  final String? confirmText;
  final String? cancelText;
  final Function(List? value)? onConfirm;
  final Function(List? value)? onCancel;

  Picker({
    this.title,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    required super.columns,
    super.values,
    super.onChange,
    super.loop,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return PickerState();
  }
}

class PickerState extends State<Picker> {
  @override
  Widget build(BuildContext context) {
    return WithValue(widget.values, (model) {
      return Column(mainAxisSize: MainAxisSize.min, children: [
        PickerToolBar(
          title: widget.title,
          cancelText: widget.cancelText,
          confirmText: widget.confirmText,
          onCancel: () => widget.onCancel?.call(model.value),
          onConfirm: () => widget.onConfirm?.call(model.value),
        ),
        PickerPanel(
          values: model.value,
          onChange: (values) {
            model.value = values;
            widget.onChange?.call(values);
          },
          columns: widget.columns,
          loop: widget.loop,
        ),
      ]);
    });
  }
}
