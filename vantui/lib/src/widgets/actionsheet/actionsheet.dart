import 'package:flutter/widgets.dart';
import 'package:tailstyle/tailstyle.dart';

import '../../utils/nil.dart';
import '../config/index.dart';
import '../popup/index.dart';
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
  final Function()? onClose;
  // @DocsProp("onCancel", "Function()", "点击取消回调，之后触发关闭回调")
  final Function()? onCancel;
  // @DocsProp("onSelect", "Function(ActionSheetItem)", "点击 Action 回调")
  final Function(ActionSheetItem item)? onSelect;
  final Function()? onInvalidate;

  const ActionSheet({
    this.show,
    this.actions,
    this.description,
    this.cancelText,
    this.closeOnClickAction,
    this.onClose,
    this.onCancel,
    this.onSelect,
    this.onInvalidate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);
    final fontSize =
        DefaultTextStyle.of(context).style.fontSize ?? theme.fontSizeMd;

    final closeOnClickAction = this.closeOnClickAction ?? true;

    final description = () {
      if (this.description == null) {
        return nil;
      } else {
        final px = theme.paddingMd;
        return TailBox().px(px).py(20).border_b(theme.borderColor).as((s) {
          return s.Container(
            child: TailTypo()
                .line_height(theme.lineHeightMd / fontSize)
                .text_center()
                .text_color(theme.textColor2)
                .Text("${this.description}"),
          );
        });
      }
    }();

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: List.of((actions ?? []).map((action) {
        final disabled = action.disabled == true;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (disabled == true) return;
            onSelect?.call(action);
            if (closeOnClickAction) onClose?.call();
          },
          child: action,
        );
      })),
    );

    final cancel = () {
      if (cancelText == null && onCancel == null) {
        return nil;
      } else {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            onCancel?.call();
            onClose?.call();
          },
          child: ActionSheetItem(cancelText ?? "取消"),
        );
      }
    }();

    final gap = cancel == nil
        ? nil
        : TailBox().bg(theme.background).Container(height: theme.paddingXs);

    return Popup(
      show: show,
      position: PopupPosition.bottom,
      onInvalidate: onInvalidate,
      onClose: onClose,
      closeOnClickOverlay: true,
      round: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          description,
          content,
          gap,
          cancel,
        ],
      ),
    );
  }
}
