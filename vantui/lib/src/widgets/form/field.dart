import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/widgets/form/types.dart';

import '../cell/_flex.dart';
import '../cell/cell.dart';
import 'item.dart';

/// Field draws Cell within Form
class VanField extends StatelessWidget {
  final String? label;
  final String? name;
  final dynamic child;
  final dynamic arrow;
  final bool? clickable;
  final Function()? onTap;

  const VanField({
    this.label,
    this.name,
    this.child,
    this.arrow,
    this.clickable,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final name = (child is VanFormItem ? (child as VanFormItem).name : null) ??
    //     this.name;
    // final value =
    //     name != null ? VanForm.ofn(context)?.getFieldValues()[name] : null;

    final cellValue = () {
      if (child is VanFormItem) {
        return child as VanFormItem;
      } else if (child is FormItemChild) {
        return VanFormItem(name: name, child: child);
      } else {
        return child;
      }
    }();

    return CellFlexProvider(
      flexLeftDelegate: (child) => Builder(builder: (context) {
        final fontSize = DefaultTextStyle.of(context).style.fontSize ?? 14.0;
        final width = fontSize * 6.2; // 6.2em
        return SizedBox(width: width, child: child);
      }),
      child: Cell(
        title: label,
        arrow: arrow,
        value: Align(alignment: Alignment.centerLeft, child: cellValue),
        clickable: clickable,
        onTap: onTap,
        center: true,
      ),
    );
  }
}
