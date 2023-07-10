import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/widgets/picker/panel.dart';

import '../_util/with_value.dart';
import 'toolbar.dart';

// @DocsId("picker")

class Picker extends PickerPanel {
  // @DocsProp("title", "Widget | String", "面板标题")
  final dynamic title;
  // @DocsProp("confirmText", "String", "确认文本")
  final String? confirmText;
  // @DocsProp("cancelTetx", "String", "取消文本")
  final String? cancelText;
  // @DocsProp("onConfirm", "Function(List)", "确认回调")
  final Function(List? value)? onConfirm;
  // @DocsProp("onCancel", "Function(List)", "取消回调")
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
