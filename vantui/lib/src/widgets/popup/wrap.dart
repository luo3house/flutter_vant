import 'package:flutter/widgets.dart';
import '../../utils/nil.dart';
import '../config/index.dart';
import '../mask/index.dart';
import 'content.dart';

import 'types.dart';

class VanPopupWrap extends StatefulWidget {
  final bool? show;
  final bool? overlay;
  final VanPopupPosition? position;
  final EdgeInsets? padding;
  final bool? round;
  final bool? closeOnClickOverlay;
  final Widget? child;
  final BoxConstraints? constraints;
  final Function()? onClose;
  final Function()? onInvalidate;

  const VanPopupWrap({
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
    super.key,
  });

  @override
  createState() => VanPopupState();
}

class VanPopupState extends State<VanPopupWrap> {
  var _show = false;
  Size? contentSize;
  BoxConstraints? layoutCon;

  double get contentW => contentSize?.width ?? 0;
  double get contentH => contentSize?.height ?? 0;

  @override
  void initState() {
    super.initState();
    _show = widget.show == true;
  }

  @override
  void didUpdateWidget(covariant VanPopupWrap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.show != widget.show || _show != widget.show) {
      _show = widget.show == true;
    }
  }

  hide() {
    widget.onClose?.call();
    setState(() => _show = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    final position = widget.position ?? VanPopupPosition.center;
    final constraints = widget.constraints ?? const BoxConstraints();
    final overlay = widget.overlay ?? true;
    final closeOnClickOverlay = widget.closeOnClickOverlay ?? true;

    var contentCon = () {
      const verti = {VanPopupPosition.top, VanPopupPosition.bottom};
      const horiz = {VanPopupPosition.left, VanPopupPosition.right};
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
      if (position == VanPopupPosition.left) {
        return Alignment.centerLeft;
      } else if (position == VanPopupPosition.right) {
        return Alignment.centerRight;
      } else if (position == VanPopupPosition.top) {
        return Alignment.topCenter;
      } else if (position == VanPopupPosition.bottom) {
        return Alignment.bottomCenter;
      } else {
        return Alignment.center;
      }
    }();

    final offsetInterpolate = () {
      if (position == VanPopupPosition.left) {
        return (double x) => Offset(contentW * (x - 1), 0);
      } else if (position == VanPopupPosition.right) {
        return (double x) => Offset(contentW * (1 - x), 0);
      } else if (position == VanPopupPosition.top) {
        return (double x) => Offset(0, contentH * (x - 1));
      } else if (position == VanPopupPosition.bottom) {
        return (double x) => Offset(0, contentH * (1 - x));
      } else {
        return (double x) => Offset.zero;
      }
    }();

    final double Function(double x) opacityInterpolate = () {
      if (position == VanPopupPosition.center) {
        return (double x) => x;
      } else {
        return (double x) => 1.0;
      }
    }();

    return TweenAnimationBuilder(
      onEnd: () => {if (!_show) widget.onInvalidate?.call()},
      tween: _show //
          ? Tween(begin: 1.0, end: 1.0)
          : Tween(begin: 0.0, end: 0.0),
      duration: theme.durationFast,
      curve: Curves.easeOut,
      builder: (_, x, __) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(),
          child: Stack(children: [
            Positioned.fill(
              child: x == 0 ? nil : Opacity(opacity: x, child: overlayFrag),
            ),
            Offstage(
              offstage: x == 0,
              child: IgnorePointer(
                ignoring: x != 1,
                child: Align(
                  alignment: alignment,
                  child: Transform.translate(
                    offset: offsetInterpolate(x),
                    child: Opacity(
                      opacity: opacityInterpolate(x),
                      child: content,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
}
