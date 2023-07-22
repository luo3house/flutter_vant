import 'package:flutter/widgets.dart';
import '../_util/static_to_widget.dart';

import 'static.dart';
import 'item.dart';

// @DocsId("actionsheet")

class ActionSheet extends StatelessWidget {
  // @DocsProp("show", "bool", "是否显示")
  final bool? show;
  // @DocsProp("actions", "List<ActionSheetItem>", "Action")
  final List<ActionSheetItem>? actions;
  // @DocsProp("description", "String", "描述文本")
  final String? description;
  // @DocsProp("cancelText", "String", "取消文本")
  final String? cancelText;
  // @DocsProp("closeOnClickAction", "bool", "在点击 Action 后关闭面板")
  final bool? closeOnClickAction;
  // @DocsProp("onClose", "Function()", "面板关闭回调")
  final Function()? onAfterClose;
  // @DocsProp("onCancel", "Function()", "点击取消回调，之后触发 onAfterClose")
  final Function()? onCancel;
  // @DocsProp("onSelect", "Function(ActionSheetItem)", "点击 Action 回调")
  final Function(ActionSheetItem item)? onSelect;

  const ActionSheet({
    this.show,
    this.actions,
    this.description,
    this.cancelText,
    this.closeOnClickAction,
    this.onAfterClose,
    this.onCancel,
    this.onSelect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StaticToWidget(
      show: show == true,
      () => ActionSheetStatic.show(
        context,
        actions: actions,
        description: description,
        cancelText: cancelText,
        closeOnClickAction: closeOnClickAction,
        onAfterClose: onAfterClose,
        onCancel: onCancel,
        onSelect: onSelect,
      ),
    );
  }
}
