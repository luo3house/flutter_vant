import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/utils/nil.dart';
import 'package:flutter_vantui/src/utils/std.dart';
import 'package:provider/provider.dart';
import 'package:tailstyle/tailstyle.dart';

import '../_util/glowless_scroll_behavior.dart';
import 'theme.dart';

// @DocsId("config")

class VanConfig extends StatelessWidget {
  static VanConfig of(BuildContext context) {
    return Provider.of<VanConfig>(context);
  }

  static Widget tryCopy(BuildContext context, {required Widget child}) {
    final config = ofn(context);
    return config != null
        ? VanConfig(theme: config.theme, child: child)
        : child;
  }

  static VanConfig? ofn(BuildContext context) {
    return tryCatch(() => of(context));
  }

  static VanTheme ofTheme(BuildContext context, [VanTheme? defaultVal]) {
    return ofn(context)?.theme ?? defaultVal ?? VanTheme.fallback;
  }

  // @DocsProp("theme", "VanTheme", "主题配置")
  final VanTheme? theme;
  final Widget? child;

  const VanConfig({
    this.theme,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? VanTheme.fallback;

    final defaultTextStyle = TailTypo()
        .no_underline()
        .font_size(theme.fontSizeLg)
        .text_color(theme.textColor)
        .TextStyle();

    final defaultIconTheme = IconThemeData(
      color: theme.textColor,
      size: theme.fontSizeMd,
    );

    return Provider<VanConfig>.value(
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
            child: child ?? nil,
          ),
        ),
      ),
    );
  }
}
