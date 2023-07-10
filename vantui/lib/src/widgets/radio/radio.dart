import 'package:flutter/widgets.dart';

import '../checkbox/checkbox.dart';
import 'provider.dart';

class Radio extends Checkbox {
  final String? name;
  const Radio({
    super.checked,
    super.onChange,
    super.shape,
    super.icon,
    super.label,
    super.disabled,
    super.checkedColor,
    this.name,
    super.key,
  });

  VanRadioGroupProvider? ofGroup(BuildContext context) {
    return VanRadioGroupProvider.ofn(context);
  }

  @override
  dynamic get label => super.label ?? name;

  @override
  bool isChecked(BuildContext context) {
    final grp = ofGroup(context);
    return grp != null ? grp.value == name : super.isChecked(context);
  }

  @override
  handleOnTap(BuildContext context) {
    if (isDisabled() || isChecked(context)) return false;
    if (super.handleOnTap(context)) {
      ofGroup(context)?.onChange?.call(name);
      return true;
    } else {
      return false;
    }
  }
}
