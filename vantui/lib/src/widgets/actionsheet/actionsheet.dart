import 'package:flutter/widgets.dart';
import 'package:tailstyle/tailstyle.dart';

import '../../utils/nil.dart';
import '../config/index.dart';
import '../popup/index.dart';
import 'item.dart';

class VanActionSheet extends StatelessWidget {
  final bool? show;
  final List<VanActionSheetItem>? actions;
  final String? description;
  final String? cancelText;
  final bool? closeOnClickAction;
  final Function()? onClose;
  final Function()? onCancel;
  final Function(VanActionSheetItem item)? onSelect;
  final Function()? onInvalidate;

  const VanActionSheet({
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
          child: VanActionSheetItem(cancelText ?? "取消"),
        );
      }
    }();

    final gap = cancel == nil
        ? nil
        : TailBox().bg(theme.background).Container(height: theme.paddingXs);

    return LayoutBuilder(builder: (_, con) {
      return VanPopup(
        show: show,
        position: VanPopupPosition.bottom,
        constraints: BoxConstraints(maxHeight: con.maxHeight * .85),
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
    });
  }
}
