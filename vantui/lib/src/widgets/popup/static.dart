import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../utils/rendering.dart';
import '../_util/with_dispose.dart';
import '../mask/index.dart';
import '../popup/content.dart';
import '../../utils/nil.dart';
import '../../utils/std.dart';
import '../config/index.dart';
import 'types.dart';

// @DocsId("popup")

class PopupStatic {
  static const routeNamePrefix = "_popup_route_";
  PopupStatic._();

  static PopupDisposeFn show(
    BuildContext context, {
    // @DocsProp("position", "top | bottom | left | right | center", "弹出层位置")
    PopupPosition? position,
    // @DocsProp("padding", "EdgeInsets", "内间距")
    EdgeInsets? padding,
    // @DocsProp("round", "bool", "圆角风格")
    bool? round,
    // @DocsProp("closeOnClickOverlay", "bool", "点击遮罩层关闭弹出层")
    bool? closeOnClickOverlay,
    // @DocsProp("constraints", "BoxConstraints | BoxConstraints Function(BoxConstraints con)", "内容尺寸约束")
    dynamic constraints,
    Widget? child,
    bool? safeArea,
    Function()? onAfterClose,
  }) {
    assert(constraints is BoxConstraints ||
        constraints is BoxConstraintsGetter ||
        constraints == null);

    final sizeHolder = ValueHolder(Size.zero);
    final name = "${routeNamePrefix}_${DateTime.now().millisecondsSinceEpoch}";
    position ??= PopupPosition.center;
    child ??= nil;
    safeArea ??= true;
    closeOnClickOverlay ??= true;

    final animCompleter = Completer<dynamic>();

    Function()? dispose;

    onInvalidate() {
      raf(() {
        if (!animCompleter.isCompleted) animCompleter.complete();
        onAfterClose?.call();
      });
    }

    final popupChild = Builder(
      builder: (_) => VanConfig.tryCopy(
        context,
        child: LayoutBuilder(
          builder: (_, layoutCon) => PopupContent(
            position: position,
            padding: padding,
            round: round,
            onLayout: (size) => sizeHolder.value = size,
            constraints: normalizeConstraint(position!, layoutCon, constraints),
            child: SafeArea(
              left: safeArea == true && position == PopupPosition.left,
              top: safeArea == true && position == PopupPosition.top,
              right: safeArea == true && position == PopupPosition.right,
              bottom: safeArea == true && position == PopupPosition.bottom,
              child: child!,
            ),
          ),
        ),
      ),
    );

    showGeneralDialog(
      context: context,
      barrierColor: MaskBody.defaultBg,
      barrierDismissible: closeOnClickOverlay,
      barrierLabel: "Dismiss",
      routeSettings: RouteSettings(name: name),
      pageBuilder: (context, anim, anim2) {
        dispose = () {
          if (tryCatch(() => ModalRoute.of(context)?.isCurrent) == true) {
            Navigator.maybeOf(context)?.pop();
          }
        };
        return popupChild;
      },
      transitionBuilder: createPopupRouteBuilder(
        position,
        sizeHolder,
        onInvalidate,
      ),
    );

    return () {
      dispose?.call();
      return animCompleter.future;
    };
  }

  static BoxConstraints normalizeConstraint(
      PopupPosition position, BoxConstraints layoutCon, dynamic userConOrFn) {
    const verti = {PopupPosition.top, PopupPosition.bottom};
    const horiz = {PopupPosition.left, PopupPosition.right};
    final constraints = userConOrFn is BoxConstraintsGetter
        ? userConOrFn(layoutCon)
        : (userConOrFn as BoxConstraints?) ?? const BoxConstraints();

    if (verti.contains(position)) {
      return constraints.copyWith(
        minWidth: double.infinity,
        maxWidth: double.infinity,
        maxHeight: constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : layoutCon.maxHeight * .85,
      );
    } else if (horiz.contains(position)) {
      return constraints.copyWith(
        minHeight: double.infinity,
        maxHeight: double.infinity,
        maxWidth: constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : layoutCon.maxWidth * .85,
      );
    } else {
      return constraints;
    }
  }

  static RouteTransitionsBuilder createPopupRouteBuilder(PopupPosition position,
      ValueHolder<Size> sizeHolder, Function() onInvalidate) {
    final offsetInterpolate = () {
      if (position == PopupPosition.left) {
        return (double x) => Offset(sizeHolder.value.width * (x - 1), 0);
      } else if (position == PopupPosition.right) {
        return (double x) => Offset(sizeHolder.value.width * (1 - x), 0);
      } else if (position == PopupPosition.top) {
        return (double x) => Offset(0, sizeHolder.value.height * (x - 1));
      } else if (position == PopupPosition.bottom) {
        return (double x) => Offset(0, sizeHolder.value.height * (1 - x));
      } else {
        return (double x) => Offset.zero;
      }
    }();

    final alignment = const <PopupPosition?, Alignment>{
      PopupPosition.left: Alignment.centerLeft,
      PopupPosition.right: Alignment.centerRight,
      PopupPosition.top: Alignment.topCenter,
      PopupPosition.bottom: Alignment.bottomCenter,
      PopupPosition.center: Alignment.center,
      null: Alignment.center,
    }[position]!;

    if (position == PopupPosition.center) {
      return (_, anim, anim2, child) {
        return WithDispose(
          onInvalidate,
          child: FadeTransition(
            opacity: CurvedAnimation(
              parent: anim,
              curve: Curves.easeOut,
              reverseCurve: Curves.easeIn,
            ),
            child: Center(child: child),
          ),
        );
      };
    } else {
      return (_, anim, anim2, child) {
        return AnimatedBuilder(
          animation: CurvedAnimation(
            parent: anim,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
          child: child,
          builder: (_, child) {
            return WithDispose(
              onInvalidate,
              child: Offstage(
                offstage: sizeHolder.value.isEmpty,
                child: Transform.translate(
                  offset: offsetInterpolate(anim.value),
                  child: Align(alignment: alignment, child: child),
                ),
              ),
            );
          },
        );
      };
    }
  }
}
