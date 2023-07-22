import 'package:flutter/widgets.dart';

import '../popup/static.dart';
import '../popup/types.dart';
import 'action.dart';
import 'body.dart';

class DialogStatic {
  DialogStatic._();

  static PopupDisposeFn show(
    BuildContext context, {
    dynamic title,
    dynamic message,
    DialogActionLike? action,
    dynamic constraints,
    bool? closeOnClickOverlay,
    Function()? onAfterClose,
  }) {
    late PopupDisposeFn disposeFn;

    return disposeFn = PopupStatic.show(
      context,
      position: PopupPosition.center,
      onAfterClose: onAfterClose,
      closeOnClickOverlay: closeOnClickOverlay,
      constraints: constraints ??
          (BoxConstraints layout) => layout.copyWith(
              maxWidth: layout.maxWidth * .85,
              maxHeight: layout.maxHeight * .85),
      round: true,
      child: VanDialogBody(
        title: title,
        message: message,
        action: (action ?? const DialogConfirm()).cloneWithDialogActionLike(
          tryClose: () {
            disposeFn();
          },
        ),
      ),
    );
  }
}
