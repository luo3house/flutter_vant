import 'package:flutter/widgets.dart';

import '../../utils/nil.dart';
import '../form/types.dart';
import 'provider.dart';

class RadioGroup extends StatefulWidget implements FormItemChild<String?> {
  @override
  final String? value;
  @override
  final Function(String? v)? onChange;
  final Widget? child;

  const RadioGroup({
    this.value,
    this.onChange,
    this.child,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return RadioGroupState();
  }

  @override
  FormItemChild<String?> cloneWithFormItemChild({
    Function(String? v)? onChange,
    String? value,
  }) {
    return RadioGroup(
      value: value,
      onChange: onChange,
      key: key,
      child: child,
    );
  }
}

class RadioGroupState extends State<RadioGroup> {
  String? value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  void didUpdateWidget(covariant RadioGroup oldWidget) {
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
