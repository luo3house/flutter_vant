import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/utils/nil.dart';
import 'package:flutter_vantui/src/widgets/config/index.dart';
import 'package:flutter_vantui/src/widgets/mask/index.dart';
import 'package:flutter_vantui/src/widgets/popup/content.dart';

import 'types.dart';

typedef _FragBuilder = List<Widget> Function(
  double x,
  Widget overlayFrag,
  Widget content,
);

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

    Positioned Function(Widget child) withPosition = () {
      if (position == VanPopupPosition.left) {
        return (child) => Positioned.fill(left: 0, right: null, child: child);
      } else if (widget.position == VanPopupPosition.top) {
        return (child) => Positioned.fill(top: 0, bottom: null, child: child);
      } else if (widget.position == VanPopupPosition.right) {
        return (child) => Positioned.fill(right: 0, left: null, child: child);
      } else if (widget.position == VanPopupPosition.bottom) {
        return (child) => Positioned.fill(bottom: 0, top: null, child: child);
      } else {
        return (child) => Positioned.fill(child: Center(child: child));
      }
    }();

    final content = VanPopupContent(
      position: widget.position,
      padding: widget.padding,
      round: widget.round,
      constraints: widget.constraints,
      child: widget.child,
      onLayout: (size) => contentSize = size,
    );

    final overlay = () {
      final overlay = widget.overlay ?? true;
      final closeOnClickOverlay = widget.closeOnClickOverlay ?? true;
      if (overlay) {
        return MaskBody(
          onTap: () => (closeOnClickOverlay ? hide : null)?.call(),
        );
      } else {
        return nil;
      }
    }();

    Offset Function(double) offsetInterpolate = () {
      double h() => contentSize?.height ?? 0.0;
      double w() => contentSize?.width ?? 0.0;
      if (position == VanPopupPosition.top) {
        return (x) => Offset(0, (x - 1) * h());
      } else if (position == VanPopupPosition.bottom) {
        return (x) => Offset(0, (1 - x) * h());
      } else if (position == VanPopupPosition.left) {
        return (x) => Offset((x - 1) * w(), 0);
      } else if (position == VanPopupPosition.right) {
        return (x) => Offset((1 - x) * w(), 0);
      } else {
        return (x) => const Offset(0, 0);
      }
    }();

    // ignore: prefer_function_declarations_over_variables
    _FragBuilder animFrags = (x, overlay, content) {
      final overlayFrag = Positioned.fill(
        child: Opacity(opacity: x, child: x == 0 ? nil : overlay),
      );

      if (position == VanPopupPosition.center) {
        return [
          overlayFrag,
          withPosition(Opacity(opacity: x, child: x == 0 ? nil : content)),
        ];
      } else {
        return [
          overlayFrag,
          withPosition(Transform.translate(
            offset: offsetInterpolate(x),
            child: Offstage(offstage: x == 0, child: content),
          )),
        ];
      }
    };

    return LayoutBuilder(builder: (_, con) {
      layoutCon = con;
      return TweenAnimationBuilder(
        onEnd: () => {if (!_show) widget.onInvalidate?.call()},
        tween: _show //
            ? Tween(begin: 1.0, end: 1.0)
            : Tween(begin: 0.0, end: 0.0),
        curve: Curves.easeOut,
        duration: theme.durationBase,
        builder: (_, x, child) => Stack(
          fit: StackFit.expand,
          children: animFrags(x, overlay, content),
        ),
      );
    });
  }
}
