import 'package:flutter/widgets.dart';

import '../../utils/nil.dart';
import '../../utils/rendering.dart';

class TeleportOverlay extends StatefulWidget {
  final OverlayState? to;
  final Widget child;
  final Widget? local;

  const TeleportOverlay({
    this.to,
    this.local,
    required this.child,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return TeleportOverlayState();
  }
}

class TeleportOverlayState extends State<TeleportOverlay> {
  Function()? removeEntry;
  Function()? remoteSetState;

  @override
  void initState() {
    super.initState();
    final entry = OverlayEntry(builder: (_) {
      return StatefulBuilder(builder: (_, setState) {
        remoteSetState = () => setState(() {});
        return widget.child;
      });
    });
    raf(() {
      final to = Overlay.of(context);
      assert(to != null, "can not find nearest Overlay");
      if (mounted) {
        to!.insert(entry);
        removeEntry = () => entry.remove();
      }
    });
  }

  @override
  void didUpdateWidget(covariant TeleportOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    raf(() {
      if (mounted) remoteSetState?.call();
    });
  }

  @override
  void dispose() {
    removeEntry?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.local ?? nil;
  }
}
