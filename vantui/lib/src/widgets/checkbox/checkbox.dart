import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter_vantui/src/widgets/checkbox/input.dart';
import 'package:flutter_vantui/src/widgets/form/types.dart';
import 'package:tailstyle/tailstyle.dart';

typedef LabelByChecked = dynamic Function(bool checked);

class Checkbox extends StatelessWidget implements FormItemChild<bool> {
  final bool? checked;
  @override
  final Function(bool v)? onChange;
  final BoxShape? shape;
  final InputByChecked? icon;
  final dynamic label;
  final bool? disabled;
  final Color? checkedColor;

  const Checkbox({
    this.checked,
    this.onChange,
    this.shape,
    this.icon,
    this.label,
    this.disabled,
    this.checkedColor,
    super.key,
  });

  @override
  FormItemChild<bool> cloneWithFormItemChild({
    Function(bool v)? onChange,
    bool? value,
  }) {
    return Checkbox(
      checked: value,
      onChange: onChange,
      shape: shape,
      icon: icon,
      label: label,
      disabled: disabled,
      checkedColor: checkedColor,
      key: key,
    );
  }

  @override
  bool? get value => checked;

  BoxShape getShape() => shape ?? BoxShape.circle;
  bool isDisabled() => disabled == true;
  bool isChecked(BuildContext context) => checked == true;

  bool handleOnTap(BuildContext context) {
    if (isDisabled()) return false;
    onChange?.call(!isChecked(context));
    return true;
  }

  Widget buildInput(BuildContext context) {
    return CheckboxInput(
      disabled: isDisabled(),
      checked: isChecked(context),
      shape: getShape(),
      checkedColor: checkedColor,
      icon: icon,
    );
  }

  buildLabel(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    Widget probe(dynamic label) {
      if (label is Widget) {
        return label;
      } else if (label == null) {
        return nil;
      } else {
        final color = isDisabled() ? theme.textColor3 : null;
        return TailTypo().text_color(color).Text("$label");
      }
    }

    if (label is LabelByChecked) {
      return probe((label as LabelByChecked).call(isChecked(context)));
    } else {
      return probe(label);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    final icon = buildInput(context);
    final label = buildLabel(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => handleOnTap(context),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        icon,
        TailBox().ml(label == nil ? 0 : theme.paddingXs).as((styled) {
          return styled.Container(child: label);
        }),
      ]),
    );
  }
}
