// ignore_for_file: unused_element

import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/utils/rendering.dart';
import 'package:flutter_vantui/src/utils/touch.dart';

import '../../utils/nil.dart';
import '../../utils/std.dart';
import '../config/index.dart';

class VanSwipeCell extends StatefulWidget {
  final Widget? left;
  final Widget? right;
  final dynamic Function()? beforeClose;
  final Widget? child;

  const VanSwipeCell({
    this.left,
    this.right,
    this.beforeClose,
    this.child,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return VanSwipeCellState();
  }
}

class VanSwipeCellState extends State<VanSwipeCell> {
  Size? leftSize;
  Size? rightSize;
  final touch = Touch();
  double currentOffset = 0;

  /// offset before pointer down
  double baseOffset = 0;

  var useAnim = false;

  double get leftW => leftSize?.width ?? 0;
  double get rightW => rightSize?.width ?? 0;
  dynamic Function() get beforeClose => widget.beforeClose ?? () async => true;

  close() {
    baseOffset = 0;
    currentOffset = 0;
    useAnim = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.pointerRouter.addGlobalRoute(handleGlobalRoute);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.pointerRouter.removeGlobalRoute(handleGlobalRoute);
    super.dispose();
  }

  handleGlobalRoute(PointerEvent e) {
    if (!e.down) return;
    tryCatch(() {
      final box = context.findRenderObject() as RenderBox;
      final size = box.size;
      final globalRect = Rect.fromPoints(
        box.localToGlobal(Offset.zero),
        box.localToGlobal(Offset(size.width, size.height)),
      );
      if (!globalRect.contains(e.position)) close();
    });
  }

  /// snap to nearest offset
  double snapDragOffset(double dragOffset) {
    if (dragOffset >= 0) {
      // snap left or main
      return dragOffset.abs() >= leftW / 2 ? leftW : 0;
    } else {
      // snap right or main
      return dragOffset.abs() >= rightW / 2 ? -rightW : 0;
    }
  }

  handleDragOffset(double negativableDragOffset) {
    currentOffset = baseOffset + negativableDragOffset;
    setState(() {});
  }

  handlePointerDown(Offset pos) {
    touch.clear();
    touch.touchStart(pos.dx, pos.dy);
  }

  handlePointerMove(Offset pos) {
    touch.touchMove(pos.dx, pos.dy);
    useAnim = false;
    handleDragOffset(touch.distanceX);
  }

  handlePointerUp(Offset pos) {
    touch.touchEnd(pos.dx, pos.dy);
    currentOffset = snapDragOffset(currentOffset);
    baseOffset = currentOffset;
    useAnim = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    final left = Builder(builder: (context) {
      raf(() => leftSize = tryCatch<Size?>(() => context.size));
      return widget.left ?? nil;
    });
    final right = Builder(builder: (context) {
      raf(() => rightSize = tryCatch<Size?>(() => context.size));
      return widget.right ?? nil;
    });
    final child = widget.child ?? nil;

    final leftWrap = Offstage(offstage: leftSize == null, child: left);
    final rightWrap = Offstage(offstage: rightSize == null, child: right);

    final clampOffset = currentOffset >= 0
        ? min(leftW, currentOffset.abs())
        : -min(rightW, currentOffset.abs());

    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: clampOffset),
      duration: useAnim ? theme.durationFast : Duration.zero,
      curve: const Cubic(.18, .89, .32, 1),
      builder: (_, x, child) => Transform.translate(
        offset: Offset(x, 0),
        child: child,
      ),
      child: _ChildrenOverflowableStack(clipBehavior: Clip.none, children: [
        Positioned(top: 0, bottom: 0, left: -leftW, child: leftWrap),
        Positioned(top: 0, bottom: 0, right: -rightW, child: rightWrap),
        Positioned(
          child: Listener(
            onPointerDown: (e) => handlePointerDown(e.position),
            onPointerMove: (e) => handlePointerMove(e.position),
            onPointerUp: (e) => handlePointerUp(e.position),
            child: GestureDetector(onHorizontalDragStart: (e) {}, child: child),
          ),
        ),
      ]),
    );
  }
}

class _ChildrenOverflowableStack extends Stack {
  _ChildrenOverflowableStack({
    super.key,
    super.alignment,
    super.textDirection,
    super.fit,
    super.clipBehavior,
    super.children,
  });

  @override
  _ChildrenOverflowableRenderStack createRenderObject(BuildContext context) {
    return _ChildrenOverflowableRenderStack(
      alignment: alignment,
      textDirection: textDirection ?? Directionality.maybeOf(context),
      fit: fit,
      clipBehavior: clipBehavior,
    );
  }
}

class _ChildrenOverflowableRenderStack extends RenderStack {
  _ChildrenOverflowableRenderStack({
    super.children,
    super.alignment,
    super.textDirection,
    super.fit,
    super.clipBehavior,
  });
  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (hitTestChildren(result, position: position) || hitTestSelf(position)) {
      result.add(BoxHitTestEntry(this, position));
      return true;
    }
    return false;
  }
}
