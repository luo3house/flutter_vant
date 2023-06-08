import 'package:flutter/widgets.dart';

import '../../utils/nil.dart';
import '../../utils/rendering.dart';

class OverlayTeleport extends StatefulWidget {
  final OverlayState? to;
  final Widget remote;
  final Widget? local;

  const OverlayTeleport({
    this.to,
    required this.remote,
    this.local,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return OverlayTeleportState();
  }
}

class OverlayTeleportState extends State<OverlayTeleport> {
  Function()? removeEntry;
  Function()? remoteSetState;

  @override
  void initState() {
    super.initState();
    final entry = OverlayEntry(builder: (_) {
      return StatefulBuilder(builder: (_, setState) {
        remoteSetState = () => setState(() {});
        return widget.remote;
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
  void didUpdateWidget(covariant OverlayTeleport oldWidget) {
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
