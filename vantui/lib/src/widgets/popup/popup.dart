import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/widgets.dart';
import '../../utils/nil.dart';
import '../config/index.dart';
import '../mask/index.dart';
import '../teleport_overlay/teleport_overlay.dart';
import 'content.dart';

import 'types.dart';

class Popup extends StatefulWidget {
  final dynamic show;
  final bool? overlay;
  final PopupPosition? position;
  final EdgeInsets? padding;
  final bool? round;
  final bool? closeOnClickOverlay;
  final Widget? child;
  final BoxConstraints? constraints;
  final Function()? onClose;
  final Function()? onInvalidate;
  final dynamic teleport;

  Popup({
    this.show,
    this.overlay,
    this.position,
    this.padding,
    this.round,
    this.closeOnClickOverlay,
    this.child,
    this.constraints,
    this.onClose,
    this.onInvalidate,
    this.teleport,
    super.key,
  }) {
    assert(show is ValueNotifier<bool> || show is bool?,
        "show should be typeof ValueNotifier or bool");
  }

  @override
  createState() => VanPopupState();
}

class VanPopupState extends State<Popup> {
  var _show = false;
  Function()? showSubscribeDispose;
  Size? contentSize;
  BoxConstraints? layoutCon;

  double get contentW => contentSize?.width ?? 0;
  double get contentH => contentSize?.height ?? 0;
  PopupPosition get position => widget.position ?? PopupPosition.center;
  BoxConstraints get constraints =>
      widget.constraints ?? const BoxConstraints();
  bool get overlay => widget.overlay ?? true;
  bool get closeOnClickOverlay => widget.closeOnClickOverlay ?? true;

  bool backInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    if (stopDefaultButtonEvent) return false;
    if (_show) {
      if (closeOnClickOverlay) hide();
      return true;
    } else {
      return false;
    }
  }

  _assignNormalizedShowValue(dynamic show) {
    _show = _PopupShowValue.isShow(widget.show);
    showSubscribeDispose = _PopupShowValue.subscribe(widget.show, () {
      if (_show != _PopupShowValue.isShow(widget.show)) {
        _show = _PopupShowValue.isShow(widget.show);
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _assignNormalizedShowValue(widget.show);
    BackButtonInterceptor.add(backInterceptor);
  }

  @override
  void dispose() {
    showSubscribeDispose?.call();
    BackButtonInterceptor.remove(backInterceptor);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Popup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.show != widget.show || _show != widget.show) {
      showSubscribeDispose?.call();
      _assignNormalizedShowValue(widget.show);
    }
  }

  hide() {
    widget.onClose?.call();
    _show = false;
    setState(() {});
    _PopupShowValue.setShow(widget.show, _show);
  }

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    final teleport = widget.teleport;

    var contentCon = () {
      const verti = {PopupPosition.top, PopupPosition.bottom};
      const horiz = {PopupPosition.left, PopupPosition.right};
      if (verti.contains(position)) {
        return constraints.copyWith(
            minWidth: double.infinity, maxWidth: double.infinity);
      } else if (horiz.contains(position)) {
        return constraints.copyWith(
            minHeight: double.infinity, maxHeight: double.infinity);
      } else {
        return constraints;
      }
    }();

    final content = VanPopupContent(
      position: widget.position,
      padding: widget.padding,
      round: widget.round,
      constraints: contentCon,
      onLayout: (size) => contentSize = size,
      child: widget.child,
    );

    final overlayFrag = () {
      final onTap = closeOnClickOverlay ? hide : null;
      return overlay ? MaskBody(onTap: () => onTap?.call()) : nil;
    }();

    final alignment = () {
      if (position == PopupPosition.left) {
        return Alignment.centerLeft;
      } else if (position == PopupPosition.right) {
        return Alignment.centerRight;
      } else if (position == PopupPosition.top) {
        return Alignment.topCenter;
      } else if (position == PopupPosition.bottom) {
        return Alignment.bottomCenter;
      } else {
        return Alignment.center;
      }
    }();

    final offsetInterpolate = () {
      if (position == PopupPosition.left) {
        return (double x) => Offset(contentW * (x - 1), 0);
      } else if (position == PopupPosition.right) {
        return (double x) => Offset(contentW * (1 - x), 0);
      } else if (position == PopupPosition.top) {
        return (double x) => Offset(0, contentH * (x - 1));
      } else if (position == PopupPosition.bottom) {
        return (double x) => Offset(0, contentH * (1 - x));
      } else {
        return (double x) => Offset.zero;
      }
    }();

    final double Function(double x) opacityInterpolate = () {
      if (position == PopupPosition.center) {
        return (double x) => x;
      } else {
        return (double x) => 1.0;
      }
    }();

    Widget buildAnimatedContent(double x) {
      // draw or not
      if (x == 0) return nil;
      Widget child;
      // with opacity
      child = Opacity(opacity: opacityInterpolate(x), child: content);
      // with transform
      child = Transform.translate(offset: offsetInterpolate(x), child: child);
      // with alignment
      child = Align(alignment: alignment, child: child);
      // with offstage
      child = Offstage(offstage: x == 0 || contentSize == null, child: child);
      return child;
    }

    Widget child = TweenAnimationBuilder(
      onEnd: () => {if (!_show) widget.onInvalidate?.call()},
      tween: _show //
          ? Tween(begin: 1.0, end: 1.0)
          : Tween(begin: 0.0, end: 0.0),
      duration: theme.durationFast,
      curve: Curves.easeOut,
      builder: (_, x, __) {
        return IgnorePointer(
          ignoring: x != 1,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(),
            child: Stack(children: [
              Positioned.fill(
                child: x == 0 ? nil : Opacity(opacity: x, child: overlayFrag),
              ),
              buildAnimatedContent(x),
            ]),
          ),
        );
      },
    );

    final defaultTeleport = Overlay.of(context);
    if (teleport is OverlayState ||
        (defaultTeleport != null && teleport != false)) {
      final to = teleport is OverlayState ? teleport : defaultTeleport;
      child = TeleportOverlay(to: to, child: child);
    }

    return child;
  }
}

/// _PopupShowValue handles bool, ValueNotifier value
class _PopupShowValue {
  static bool isShow(dynamic show) {
    if (show is bool) {
      return show;
    } else if (show is ValueNotifier) {
      return show.value == true;
    } else {
      return false;
    }
  }

  static void setShow(dynamic show, bool value) {
    if (show is ValueNotifier<bool>) {
      show.value = value;
    }
  }

  static Function() subscribe(dynamic show, Function() cb) {
    if (show is ValueNotifier) {
      show.addListener(cb);
      return () => show.removeListener(cb);
    } else {
      return () {};
    }
  }
}
