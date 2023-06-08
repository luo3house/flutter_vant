import 'package:flutter/material.dart';
import 'package:tailstyle/tailstyle.dart';

import '../button/button.dart';
import '../button/types.dart';
import '../config/index.dart';

abstract class DialogActionLike implements Widget {
  Widget cloneWithDialogActionLike({
    Function()? tryClose,
  });
}

class VanDialogConfirm extends StatelessWidget implements DialogActionLike {
  final Function()? onCancel; // not null = show
  final Function()? onOK;
  final bool? loading;
  final bool? warning;
  final String? cancelText;
  final String? okText;
  final Function()? internalTryClose;

  @override
  Widget cloneWithDialogActionLike({Function()? tryClose}) {
    return VanDialogConfirm(
      onCancel: onCancel,
      onOK: onOK,
      warning: warning,
      loading: loading,
      cancelText: cancelText,
      okText: okText,
      internalTryClose: tryClose,
      key: key,
    );
  }

  const VanDialogConfirm({
    this.onCancel,
    this.onOK,
    this.warning,
    this.loading,
    this.cancelText,
    this.okText,
    this.internalTryClose,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    final enableCancel = cancelText != null || onCancel != null;
    // final enableOK = okText != null || onOK != null;
    const enableOK = true;
    final buttons = <Widget>[];

    if (enableCancel) {
      buttons.add(
        VanBtn(
          square: true,
          block: true,
          text: cancelText ?? '取消',
          borderColor: const Color(0x00000000),
          plain: true,
          size: VanBtnSize.large,
          loading: loading,
          onTap: () {
            onCancel?.call();
            internalTryClose?.call();
          },
        ),
      );
    }

    if (enableOK) {
      buttons.add(VanBtn(
        square: true,
        block: true,
        text: okText ?? '确定',
        type: warning == true ? VanBtnType.warning : VanBtnType.primary,
        borderColor: const Color(0x00000000),
        plain: true,
        size: VanBtnSize.large,
        loading: loading,
        onTap: () {
          onOK?.call();
          internalTryClose?.call();
        },
      ));
    }

    final children = List.generate(buttons.length, (index) {
      final box = TailBox();
      if (index + 1 < buttons.length) {
        // has next
        box.border_r(theme.borderColor);
      }

      return Expanded(child: box.Container(child: buttons[index]));
    });

    return TailBox().border_t(theme.borderColor).as((s) {
      return s.Container(
        child: Row(mainAxisSize: MainAxisSize.max, children: children),
      );
    });
  }
}
