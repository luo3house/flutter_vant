import 'package:flutter/widgets.dart';
import 'types.dart';
export 'types.dart';

import 'wrap.dart';
export 'static.dart';

class VanToast extends StatelessWidget {
  final bool? show;
  final VanToastPosition? position;
  final Duration? duration;
  final bool? overlay;
  final bool? closeOnClickOverlay;
  final VanToastType? type;
  final EdgeInsets? padding;
  final dynamic icon;
  final dynamic child;

  const VanToast({
    this.show,
    this.position,
    this.duration,
    this.overlay,
    this.closeOnClickOverlay,
    this.type,
    this.padding,
    this.icon,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return VanToastWrap(
      show: show,
      position: position,
      duration: duration,
      overlay: overlay,
      closeOnClickOverlay: closeOnClickOverlay,
      type: type,
      padding: padding,
      icon: icon,
      child: child,
    );
  }
}
