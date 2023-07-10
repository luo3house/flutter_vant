import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/utils/nil.dart';
import 'package:flutter_vantui/src/widgets/config/index.dart';
import 'package:flutter_vantui/src/widgets/toast/content.dart';

import 'types.dart';

class ToastWrap extends StatefulWidget {
  static const defaultDuration = Duration(milliseconds: 2000);

  final bool? show;
  final VanToastPosition? position;
  final Duration? duration;
  final bool? overlay;
  final bool? closeOnClickOverlay;

  final VanToastType? type;
  final EdgeInsets? padding;
  final dynamic icon;
  final dynamic child;

  final Function()? onInvalidate;

  const ToastWrap({
    this.show,
    this.position,
    this.duration,
    this.overlay,
    this.closeOnClickOverlay,
    this.type,
    this.padding,
    this.icon,
    this.child,
    this.onInvalidate,
    super.key,
  });

  @override
  createState() => ToastWrapState();
}

class ToastWrapState extends State<ToastWrap> {
  bool _show = false;
  bool _anim = false;
  Timer? showTimer;

  void show([Duration? duration]) {
    final dur = duration ?? widget.duration ?? ToastWrap.defaultDuration;
    showTimer?.cancel();
    showTimer = Timer(dur, () => hide());
    _anim = true;
    setState(() => _show = true);
  }

  void hide([bool immediate = false]) {
    showTimer?.cancel();
    if (immediate) {
      _anim = false;
      widget.onInvalidate?.call();
    }
    setState(() => _show = false);
  }

  @override
  void initState() {
    super.initState();
    if (widget.show == true) {
      show();
    }
  }

  @override
  void dispose() {
    showTimer?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ToastWrap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.show != widget.show) {
      _show = widget.show == true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    final position = widget.position ?? VanToastPosition.center;

    final tween = <bool, Tween<double>>{
      true: Tween(begin: 0.0, end: 1.0),
      false: Tween(begin: 1.0, end: 0.0),
    }[_show]!;

    final content = ToastContent(
      type: widget.type,
      padding: widget.padding,
      icon: widget.icon,
      child: widget.child,
    );

    final child = () {
      if (!_anim && !_show) return nil;
      return TweenAnimationBuilder(
        tween: tween,
        curve: Curves.easeOut,
        duration: theme.durationBase,
        child: content,
        builder: (_, x, child) {
          if (x == 0) return nil;
          return Opacity(opacity: x, child: child);
        },
        onEnd: () {
          if (!_show) widget.onInvalidate?.call();
        },
      );
    }();

    return LayoutBuilder(builder: (_, con) {
      final contentFrag = () {
        if (position == VanToastPosition.center) {
          return Center(child: child);
        } else {
          final offset = con.maxHeight * .2;
          final top = position == VanToastPosition.top ? offset : null;
          final bottom = position == VanToastPosition.bottom ? offset : null;
          return Positioned(
            top: top,
            bottom: bottom,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: con.maxWidth),
              child: child,
            ),
          );
        }
      }();

      final overlay = widget.overlay == true;
      final closeOnClickOverlay = widget.closeOnClickOverlay == true;

      return Stack(alignment: Alignment.center, children: [
        Positioned.fill(
          child: IgnorePointer(
            ignoring: !overlay && widget.type != VanToastType.loading,
            child: GestureDetector(
              onTap: () => (closeOnClickOverlay ? hide : null)?.call(),
              child: Container(color: const Color(0x00000000)),
            ),
          ),
        ),
        contentFrag,
      ]);
    });
  }
}
