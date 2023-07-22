import 'package:flutter/widgets.dart';

import '../_util/static_to_widget.dart';
import 'static.dart';
import 'types.dart';

class Popup extends StatelessWidget {
  final bool? show;
  final PopupPosition? position;
  final EdgeInsets? padding;
  final bool? round;
  final bool? closeOnClickOverlay;
  final dynamic constraints;
  final Function()? onAfterClose;
  final Widget? child;

  const Popup({
    this.show,
    this.position,
    this.padding,
    this.round,
    this.closeOnClickOverlay,
    this.child,
    this.constraints,
    this.onAfterClose,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StaticToWidget(
      show: show == true,
      () => PopupStatic.show(
        context,
        position: position,
        padding: padding,
        round: round,
        constraints: constraints,
        onAfterClose: onAfterClose,
        child: child,
        safeArea: true,
      ),
    );
  }
}
