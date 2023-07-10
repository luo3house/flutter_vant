import 'package:flutter/widgets.dart';

import '../popup/index.dart';
import 'body.dart';
import 'action.dart';

class Dialog extends StatelessWidget {
  final bool? show;
  final dynamic title;
  final dynamic message;
  final DialogActionLike? action;
  final BoxConstraints? constraints;
  final bool? closeOnClickOverlay;
  final Function()? onClose;
  final Function()? onInvalidate;

  const Dialog({
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
      return Popup(
        show: show,
        position: PopupPosition.center,
        constraints: BoxConstraints(
          maxWidth: con.maxWidth * .85,
          maxHeight: con.maxHeight * .85,
        ),
        onInvalidate: onInvalidate,
        onClose: onClose,
        closeOnClickOverlay: closeOnClickOverlay,
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
