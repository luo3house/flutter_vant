import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/widgets/picker/panel.dart';

import '../_util/with_value.dart';
import 'toolbar.dart';

class VanPicker extends PickerPanel {
  final dynamic title;
  final String? confirmText;
  final String? cancelText;
  final Function(List? value)? onConfirm;
  final Function(List? value)? onCancel;

  VanPicker({
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
    return VanPickerState();
  }
}

class VanPickerState extends State<VanPicker> {
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
          onChange: (values, _) {
            model.value = values;
            widget.onChange?.call(values, _);
          },
          columns: widget.columns,
          loop: widget.loop,
        ),
      ]);
    });
  }
}
