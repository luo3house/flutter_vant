import 'package:flutter/widgets.dart';

import '../checkbox/checkbox.dart';
import 'provider.dart';

// @DocsId("radio")

class Radio extends Checkbox {
  // @DocsProp("name", "String", "单选框值")
  final String? name;
  // @DocsProp("onChange", "Function(bool)", "选择时触发")
  // @DocsProp("shape", "BoxShape", "选框形状")
  // @DocsProp("icon", "Widget Function(bool checked)", "选框图标")
  // @DocsProp("label", "(Widget | String | null) Function(bool checked) | Widget | String | null", "选框标题")
  // @DocsProp("disabled", "bool", "禁用状态")
  // @DocsProp("checkedColor", "Color", "选中颜色")

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
