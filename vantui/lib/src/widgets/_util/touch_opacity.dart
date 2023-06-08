import 'package:flutter/widgets.dart';

import '../button/pressable.dart';
import '../config/index.dart';

class TouchOpacity extends StatelessWidget {
  final double? activeOpacity;
  final void Function()? onTap;
  final bool? diabled;
  final Widget child;

  const TouchOpacity({
    super.key,
    this.activeOpacity,
    this.diabled,
    this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);
    final diabled = this.diabled ?? false;
    final activeOpacity = this.activeOpacity ?? theme.activeOpacity;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => (diabled ? null : onTap)?.call(),
      child: Pressable(
        (pressed) => Opacity(
          opacity: pressed && !diabled ? activeOpacity : 1,
          child: child,
        ),
      ),
    );
  }
}
