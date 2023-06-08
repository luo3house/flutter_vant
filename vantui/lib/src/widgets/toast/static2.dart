import 'package:flutter/widgets.dart';

import '../_util/overlay_static.dart';
import 'types.dart';
import 'wrap2.dart';

class VanToastStatic {
  VanToastStatic._();

  static const defaultInstanceKey = "VAN_TOAST_DEFAULT_KEY";

  static final _instances = <String, Function()>{};

  static Function() show(
    BuildContext context, {
    bool? show,
    VanToastPosition? position,
    Duration? duration,
    bool? overlay,
    bool? closeOnClickOverlay,
    VanToastType? type,
    EdgeInsets? padding,
    dynamic icon,
    dynamic message,
    String? key,
  }) {
    final instanceKey = key ?? defaultInstanceKey;
    _instances.remove(instanceKey)?.call();

    final handle = OverlayStatic.show<VanToastWrap>(context, (
        {required key, required onInvalidate}) {
      return VanToastWrap(
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
