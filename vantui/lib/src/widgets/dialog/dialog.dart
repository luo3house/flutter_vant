import 'package:flutter/widgets.dart';

import '../popup/index.dart';
import 'body.dart';
import 'action.dart';

class VanDialog extends StatelessWidget {
  final bool? show;
  final dynamic title;
  final dynamic message;
  final DialogActionLike? action;
  final BoxConstraints? constraints;
  final bool? closeOnClickOverlay;
  final Function()? onClose;
  final Function()? onInvalidate;

  const VanDialog({
    this.show,
    this.title,
    this.message,
    this.action,
    this.constraints,
    this.closeOnClickOverlay,
    this.onClose,
    this.onInvalidate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final actionSrc = this.action ?? const VanDialogConfirm();
    final action = actionSrc.cloneWithDialogActionLike(
      tryClose: () => onClose?.call(),
    );

    return LayoutBuilder(builder: (_, con) {
      return VanPopup(
        show: show,
        position: VanPopupPosition.center,
        constraints: BoxConstraints(
          maxWidth: con.maxWidth * .85,
          maxHeight: con.maxHeight * .85,
        ),
        onInvalidate: onInvalidate,
        onClose: onClose,
        closeOnClickOverlay: closeOnClickOverlay == true,
        round: true,
        child: VanDialogBody(
          title: title,
          message: message,
          action: action,
        ),
      );
    });
  }
}
