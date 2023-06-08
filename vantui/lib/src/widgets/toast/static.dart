import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/utils/std.dart';
import 'package:flutter_vantui/src/widgets/config/index.dart';

import 'types.dart';
import 'wrap2.dart';

class VanToastStatic {
  VanToastStatic._();

  static const defaultInstanceKey = "VAN_TOAST_DEFAULT_KEY";

  static final _instances = <String, GlobalKey<VanToastWrapState>>{};

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
    final overlayState = tryCatch(
      () => Overlay.of(context),
      orElse: (e) => VanConfig.ofOverlay(context),
    );
    assert(overlayState != null,
        "should have either Overlay or VanConfigProvider");
    final globalKey = GlobalKey<VanToastWrapState>();
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => VanToastWrap(
        show: true,
        key: globalKey,
        position: position,
        duration: duration,
        overlay: overlay,
        closeOnClickOverlay: closeOnClickOverlay,
        type: type,
        padding: padding,
        icon: icon,
        child: message,
        onInvalidate: () {
          _instances.remove(instanceKey);
          entry.remove();
        },
      ),
    );
    hide(key: instanceKey);
    _instances[instanceKey] = globalKey;
    overlayState!.insert(entry);

    return () => hide(key: instanceKey);
  }

  static hide({String? key}) {
    final instanceKey = key ?? defaultInstanceKey;
    final instance = _instances[instanceKey];
    _instances.remove(instanceKey);
    instance?.currentState?.hide(true);
  }
}
