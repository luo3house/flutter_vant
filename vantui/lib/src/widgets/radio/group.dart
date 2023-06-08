import 'package:flutter/widgets.dart';

import '../../utils/nil.dart';
import '../form/types.dart';
import 'provider.dart';

class VanRadioGroup extends StatefulWidget implements FormItemChild<String?> {
  @override
  final String? value;
  @override
  final Function(String? v)? onChange;
  final Widget? child;

  const VanRadioGroup({
    this.value,
    this.onChange,
    this.child,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return VanRadioGroupState();
  }

  @override
  FormItemChild<String?> cloneWithFormItemChild({
    Function(String? v)? onChange,
    String? value,
  }) {
    return VanRadioGroup(
      value: value,
      onChange: onChange,
      key: key,
      child: child,
    );
  }
}

class VanRadioGroupState extends State<VanRadioGroup> {
  String? value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  void didUpdateWidget(covariant VanRadioGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    value = widget.value;
  }

  handleChange(String? value) {
    this.value = value;
    setState(() {});
    widget.onChange?.call(this.value);
  }

  @override
  Widget build(BuildContext context) {
    return VanRadioGroupProvider(
      value: value,
      onChange: (value) => handleChange(value),
      child: widget.child ?? nil,
    );
  }
}
