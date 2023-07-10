import 'package:flutter/widgets.dart';

import '../popup/index.dart';
import 'body.dart';
import 'action.dart';

// @DocsId("dialog")

class Dialog extends StatelessWidget {
  // @DocsProp("show", "bool", "是否展示面板")
  final bool? show;
  // @DocsProp("title", "Widget | String | null", "标题")
  final dynamic title;
  // @DocsProp("title", "Widget | String", "内容")
  final dynamic message;
  // @DocsProp("action", "DialogConfirm", "确认栏，提供确认、取消、或二者")
  final DialogActionLike? action;
  // @DocsProp("constraints", "BoxConstraints", "面板尺寸约束")
  final BoxConstraints? constraints;
  // @DocsProp("closeOnClickOverlay", "bool", "点击遮罩层关闭面板")
  final bool? closeOnClickOverlay;
  // @DocsProp("onClose", "Function()", "关闭回调")
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
    final actionSrc = this.action ?? const DialogConfirm();
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
