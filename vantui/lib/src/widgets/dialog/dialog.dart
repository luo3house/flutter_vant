import 'package:flutter/widgets.dart';
import '../_util/static_to_widget.dart';

import 'static.dart';
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
  // @DocsProp("constraints", "BoxConstraints | BoxConstraints Function(BoxConstraints layout)", "面板尺寸约束")
  final BoxConstraints? constraints;
  // @DocsProp("closeOnClickOverlay", "bool", "点击遮罩层关闭面板")
  final bool? closeOnClickOverlay;
  // @DocsProp("onAfterClose", "bool", "完全关闭后触发")
  final Function()? onAfterClose;

  const Dialog({
    this.show,
    this.title,
    this.message,
    this.action,
    this.constraints,
    this.closeOnClickOverlay,
    this.onAfterClose,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StaticToWidget(
      show: show == true,
      () => DialogStatic.show(
        context,
        title: title,
        message: message,
        action: action,
        constraints: constraints,
        closeOnClickOverlay: closeOnClickOverlay,
        onAfterClose: onAfterClose,
      ),
    );
  }
}
