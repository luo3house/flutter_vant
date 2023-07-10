import 'package:flutter/widgets.dart';

import '../_util/overlay_static.dart';
import 'types.dart';
import 'wrap.dart';

// @DocsId("toast")
class ToastStatic {
  ToastStatic._();

  static const defaultInstanceKey = "VAN_TOAST_DEFAULT_KEY";

  static final _instances = <String, Function()>{};

  static Function() show(
    // @DocsProp("context", "BuildContext", "上下文，需要从上下文获取覆盖层挂载")
    BuildContext context, {
    bool? show,
    // @DocsProp("position", "top | bottom | center", "弹出位置")
    VanToastPosition? position,
    // @DocsProp("duration", "Duration", "弹出时间")
    Duration? duration,
    // @DocsProp("overlay", "bool", "遮罩层")
    bool? overlay,
    // @DocsProp("closeOnClickOverlay", "bool", "点击遮罩层关闭")
    bool? closeOnClickOverlay,
    // @DocsProp("type", "loading | success | fail | text", "类型")
    VanToastType? type,
    // @DocsProp("padding", "EdgeInsets", "文本内间距")
    EdgeInsets? padding,
    // @DocsProp("icon", "Widget | IconData", "图标")
    dynamic icon,
    // @DocsProp("message", "Widget | String", "内容")
    dynamic message,
    // @DocsProp("key", "String", "多实例标识")
    String? key,
  }) {
    final instanceKey = key ?? defaultInstanceKey;
    _instances.remove(instanceKey)?.call();

    final handle = OverlayStatic.show<ToastWrap>(context, (
        {required key, required onInvalidate}) {
      return ToastWrap(
        key: key,
        onInvalidate: () {
          _instances.remove(instanceKey);
          onInvalidate();
        },
        show: true,
        position: position,
        duration: duration,
        overlay: overlay,
        closeOnClickOverlay: closeOnClickOverlay,
        type: type,
        padding: padding,
        icon: icon,
        child: message,
      );
    });
    _instances[instanceKey] = handle.remove;
    return handle.remove;
  }

  static hide({String? key}) {
    final instanceKey = key ?? defaultInstanceKey;
    _instances.remove(instanceKey)?.call();
  }
}
