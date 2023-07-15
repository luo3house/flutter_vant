import 'package:flutter/widgets.dart';

import '../../utils/std.dart';
import '../config/index.dart';

abstract class HideableWidgetState<W extends StatefulWidget> extends State<W> {
  hide();
}

typedef OverlayWidgetBuilder<W extends StatefulWidget> = Widget Function({
  /// called when widget does both hides and ends the animation
  required Function() onInvalidate,
  required GlobalKey<HideableWidgetState<W>> key,
});

class OverlayHandle {
  final Function() hide;
  final Function() remove;
  const OverlayHandle(this.hide, this.remove);
}

class OverlayStatic {
  OverlayStatic._();

  static OverlayHandle show<W extends StatefulWidget>(
    BuildContext context,
    OverlayWidgetBuilder<W> builder,
  ) {
    final overlayState = Overlay.of(context);
    assert(overlayState != null, "should have an Overlay");
    final key = GlobalKey<HideableWidgetState<W>>();
    OverlayEntry? entry;
    removeEntry() {
      entry?.remove();
      entry = null;
    }

    entry = OverlayEntry(
      builder: (context) => builder(
        key: key,
        onInvalidate: () => removeEntry(),
      ),
    );
    overlayState!.insert(entry!);
    return OverlayHandle(
      () => key.currentState?.hide(),
      () => removeEntry(),
    );
  }
}
