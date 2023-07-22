import 'package:flutter/widgets.dart';
import 'package:tailstyle/tailstyle.dart';

import '../../utils/nil.dart';
import '../config/index.dart';
import '../popup/static.dart';
import '../popup/types.dart';
import 'item.dart';

class ActionSheetStatic {
  ActionSheetStatic._();

  static PopupDisposeFn show(
    BuildContext context, {
    List<ActionSheetItem>? actions,
    String? description,
    String? cancelText,
    bool? closeOnClickAction,
    Function()? onAfterClose,
    Function()? onCancel,
    Function(ActionSheetItem item)? onSelect,
  }) {
    late PopupDisposeFn disposePopup;

    final desc = () {
      if (description == null) {
        return nil;
      } else {
        return Builder(builder: (context) {
          final theme = VanConfig.ofTheme(context);
          final fontSize =
              DefaultTextStyle.of(context).style.fontSize ?? theme.fontSizeMd;
          final px = theme.paddingMd;
          return TailBox().px(px).py(20).border_b(theme.borderColor).as((s) {
            return s.Container(
              child: TailTypo()
                  .line_height(theme.lineHeightMd / fontSize)
                  .text_center()
                  .text_color(theme.textColor2)
                  .Text(description),
            );
          });
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
            if (closeOnClickAction != false) disposePopup();
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
            disposePopup();
          },
          child: ActionSheetItem(cancelText ?? "取消"),
        );
      }
    }();

    final gap = cancel == nil
        ? nil
        : Builder(builder: (context) {
            final theme = VanConfig.ofTheme(context);
            return TailBox()
                .bg(theme.background)
                .Container(height: theme.paddingXs);
          });

    return disposePopup = PopupStatic.show(
      context,
      position: PopupPosition.bottom,
      onAfterClose: onAfterClose,
      closeOnClickOverlay: true,
      round: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [desc, content, gap, cancel],
      ),
    );
  }
}
