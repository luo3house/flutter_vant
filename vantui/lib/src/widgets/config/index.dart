import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/utils/nil.dart';
import 'package:flutter_vantui/src/utils/std.dart';
import 'package:provider/provider.dart';
import 'package:tailstyle/tailstyle.dart';

import '../_util/glowless_scroll_behavior.dart';
import 'theme.dart';

class VanConfig extends StatefulWidget {
  static VanConfigState of(BuildContext context) {
    return Provider.of<VanConfigState>(context);
  }

  static VanConfigState? ofn(BuildContext context) {
    return tryCatch(() => of(context));
  }

  static VanTheme ofTheme(BuildContext context, [VanTheme? defaultVal]) {
    return ofn(context)?.theme ?? defaultVal ?? VanTheme.fallback;
  }

  static OverlayState? ofOverlay(BuildContext context) {
    return ofn(context)?.overlayKey.currentState;
  }

  final VanTheme? theme;
  final Widget? child;

  const VanConfig({
    this.theme,
    this.child,
    super.key,
  });

  @override
  createState() => VanConfigState();
}

class VanConfigState extends State<VanConfig> {
  final overlayKey = GlobalKey<OverlayState>();

  VanTheme get theme => widget.theme ?? VanTheme.fallback;

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = TailTypo()
        .no_underline()
        .font_size(theme.fontSizeLg)
        .text_color(theme.textColor)
        .TextStyle();

    final defaultIconTheme = IconThemeData(
      color: theme.textColor,
      size: theme.fontSizeMd,
    );

    return Provider<VanConfigState>.value(
      value: this,
      updateShouldNotify: (pre, cur) => true,
      child: DefaultTextStyle(
        style: defaultTextStyle,
        child: IconTheme(
          data: defaultIconTheme,
          child: ScrollConfiguration(
            behavior: GlowlessScrollBehavior(
              parent: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.stylus,
                  PointerDeviceKind.invertedStylus,
                  PointerDeviceKind.unknown,
                  PointerDeviceKind.mouse,
                },
              ),
            ),
            child: Overlay(
              key: overlayKey,
              initialEntries: [
                OverlayEntry(builder: (_) => widget.child ?? nil)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
