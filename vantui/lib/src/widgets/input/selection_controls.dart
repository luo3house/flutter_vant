import 'package:flutter/cupertino.dart'
    show
        DefaultCupertinoLocalizations,
        CupertinoLocalizations,
        cupertinoTextSelectionControls,
        cupertinoDesktopTextSelectionControls;
import 'package:flutter/material.dart'
    show
        DefaultMaterialLocalizations,
        MaterialLocalizations,
        desktopTextSelectionControls,
        materialTextSelectionControls;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../utils/std.dart';

class PlatformDefaultTextSelectionControls {
  static const defaultSelectionColor = Color(0xFFBBD6FB);
  PlatformDefaultTextSelectionControls._();

  static TextSelectionControls fromPlatform(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.iOS:
        return cupertinoTextSelectionControls;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return materialTextSelectionControls;
      case TargetPlatform.macOS:
        return cupertinoDesktopTextSelectionControls;
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      default:
        return desktopTextSelectionControls;
    }
  }

  static TextSelectionControls decorateFromPlatform(
      BuildContext context, TargetPlatform platform) {
    final hasCupertino =
        tryCatch(() => CupertinoLocalizations.of(context)) != null;
    final hasMaterial =
        tryCatch(() => MaterialLocalizations.of(context)) != null;
    final List<LocalizationsDelegate> delegates = List.from([
      !hasMaterial ? DefaultMaterialLocalizations.delegate : null,
      !hasCupertino ? DefaultCupertinoLocalizations.delegate : null,
    ].where((e) => e != null));
    Widget decorateAncestors(Widget child) {
      return Localizations.override(
          context: context, delegates: delegates, child: child);
    }

    return TextSelectionControlsDecorator(
      fromPlatform(platform),
      decorateHandle: decorateAncestors,
      decorateToolbar: decorateAncestors,
    );
  }
}

class TextSelectionControlsDecorator extends TextSelectionControls {
  final TextSelectionControls delegate;
  final Widget Function(Widget child)? decorateToolbar;
  final Widget Function(Widget child)? decorateHandle;
  TextSelectionControlsDecorator(
    this.delegate, {
    this.decorateToolbar,
    this.decorateHandle,
  });

  @override
  Widget buildHandle(
      BuildContext context, TextSelectionHandleType type, double textLineHeight,
      [VoidCallback? onTap]) {
    return (decorateHandle ?? (child) => child).call(Builder(
        builder: (context) =>
            delegate.buildHandle(context, type, textLineHeight)));
  }

  @override
  Widget buildToolbar(
      BuildContext context,
      Rect globalEditableRegion,
      double textLineHeight,
      Offset position,
      List<TextSelectionPoint> endpoints,
      TextSelectionDelegate delegate,
      ClipboardStatusNotifier? clipboardStatus,
      Offset? lastSecondaryTapDownPosition) {
    return (decorateToolbar ?? (child) => child).call(Builder(
        builder: (context) => this.delegate.buildToolbar(
            context,
            globalEditableRegion,
            textLineHeight,
            position,
            endpoints,
            delegate,
            clipboardStatus,
            lastSecondaryTapDownPosition)));
  }

  @override
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight) {
    return delegate.getHandleAnchor(type, textLineHeight);
  }

  @override
  Size getHandleSize(double textLineHeight) {
    return delegate.getHandleSize(textLineHeight);
  }
}
