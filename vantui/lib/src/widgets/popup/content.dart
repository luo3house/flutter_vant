import 'package:flutter/widgets.dart';
import 'package:tailstyle/tailstyle.dart';

import '../../utils/nil.dart';
import '../../utils/rendering.dart';
import '../../utils/std.dart';
import '../config/index.dart';
import 'types.dart';

// typedef MaxSizeInterpolate = Size Function(Size maxSize);

class VanPopupContent extends StatelessWidget {
  final VanPopupPosition? position;
  final EdgeInsets? padding;
  final bool? round;
  final BoxConstraints? constraints;
  final Widget? child;
  final Function(Size size)? onLayout;

  const VanPopupContent({
    this.position,
    this.padding,
    this.round,
    this.constraints,
    this.child,
    this.onLayout,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    final bg = theme.background2;

    final position = this.position ?? VanPopupPosition.center;

    final pl = padding?.left ?? 0;
    final pt = padding?.top ?? 0;
    final pr = padding?.right ?? 0;
    final pb = padding?.bottom ?? 0;

    final rounded = () {
      if (round != true) return BorderRadius.zero;
      if (position == VanPopupPosition.left) {
        return const BorderRadius.horizontal(right: Radius.circular(16));
      } else if (position == VanPopupPosition.top) {
        return const BorderRadius.vertical(bottom: Radius.circular(16));
      } else if (position == VanPopupPosition.right) {
        return const BorderRadius.horizontal(left: Radius.circular(16));
      } else if (position == VanPopupPosition.bottom) {
        return const BorderRadius.vertical(top: Radius.circular(16));
      } else {
        return BorderRadius.circular(16);
      }
    }();

    raf(() {
      final actualSize = tryCatch(
        () => (context.findRenderObject() as RenderBox?)?.size,
      );
      if (actualSize != null) onLayout?.call(actualSize);
    });

    return TailBox()
        .bg(bg)
        .pl(pl)
        .pt(pt)
        .pr(pr)
        .pb(pb)
        .rounded_tl(rounded.topLeft.x)
        .rounded_tr(rounded.topRight.x)
        .rounded_br(rounded.bottomRight.x)
        .rounded_bl(rounded.bottomLeft.x)
        .as((styled) {
      return styled.Container(
        constraints: constraints,
        clipBehavior: Clip.hardEdge,
        child: child,
      );
    });
  }
}
