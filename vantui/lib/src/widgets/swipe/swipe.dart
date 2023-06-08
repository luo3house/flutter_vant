import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/utils/nil.dart';
import 'package:flutter_vantui/src/widgets/config/index.dart';
import 'package:tailstyle/tailstyle.dart';
import 'package:tuple/tuple.dart';

class IndicatorStatus extends Tuple2<int, int> {
  IndicatorStatus(super.item1, super.item2);
  int get active => item1;
  int get total => item2;
}

typedef IndicatorBuilder = Widget Function(IndicatorStatus e);
typedef HeightFromConstraint = double Function(BoxConstraints con);

class VanSwipe extends StatefulWidget {
  final Duration? autoplay;
  final Duration? duration;
  final int? initialIndex;
  final dynamic height;
  final double? aspectRatio;
  final dynamic indicator;
  final bool? gesture;
  final bool? loop;
  final int? count;
  final double? viewportFraction;
  final Widget Function(int index)? builder;
  const VanSwipe({
    this.autoplay,
    this.duration,
    this.initialIndex,
    this.height,
    this.aspectRatio,
    this.indicator,
    this.gesture,
    this.loop,
    this.count,
    this.builder,
    this.viewportFraction,
    super.key,
  });

  @override
  createState() => VanSwipeState();
}

class VanSwipeState extends State<VanSwipe> {
  final indicatePage = ValueNotifier(0);
  late PageController pager;
  Timer? timer;
  var mainAxisViewport = 0.0;

  bool get loop => widget.loop ?? false;
  bool get gesture => widget.gesture ?? true;
  int get count => widget.count ?? 1;
  int get initialIndex => widget.initialIndex ?? 0;
  Duration get duration => widget.duration ?? const Duration(milliseconds: 500);
  Duration get autoplay => widget.autoplay ?? const Duration(seconds: 3);
  double get viewportFraction => widget.viewportFraction ?? 1.0;
  int get basePage => (loop ? count * 10 : 0) + initialIndex;

  double getHeight(BoxConstraints con) {
    if (widget.height is double) {
      return widget.height as double;
    } else if (widget.height is HeightFromConstraint) {
      return (widget.height as HeightFromConstraint).call(con);
    } else if (widget.aspectRatio != null) {
      return con.maxWidth / (widget.aspectRatio as double);
    } else {
      return 150;
    }
  }

  stopTimer() {
    timer?.cancel();
  }

  startTimer() {
    stopTimer();
    if (autoplay == Duration.zero) return;
    timer = Timer.periodic(autoplay, (_) {
      final page = pager.page;
      if (page == null) return;
      if (page.floor() == pager.page) setIndex(page.floor() + 1);
    });
  }

  setIndex(int index) {
    final finalPage = loop ? basePage + (index % basePage) : index % count;
    if (pager.hasClients) {
      pager.animateToPage(
        finalPage,
        duration: duration,
        curve: Curves.ease,
      );
    }
  }

  bool _onPointerDown(PointerDownEvent e) {
    stopTimer();
    return false;
  }

  bool _onPointerUp(PointerUpEvent e) {
    startTimer();
    return false;
  }

  @override
  void initState() {
    super.initState();

    pager = PageController(
      initialPage: basePage,
      viewportFraction: viewportFraction,
    );
    pager.addListener(() {
      final page = pager.page ?? 0;
      indicatePage.value = (page % count).round();

      if (loop && page % count == 0) {
        pager.jumpToPage(basePage);
      }
    });
    startTimer();
  }

  @override
  void dispose() {
    pager.dispose();
    timer?.cancel();
    super.dispose();
  }

  defaultIndicatorBuilder(IndicatorStatus e) {
    final theme = VanConfig.ofTheme(context);
    const size = 6.0, gap = 6.0;
    final dot = TailBox()
        .bg(theme.gray3)
        .rounded(size / 2)
        .Container(width: size, height: size, child: nil);

    return Positioned(
      bottom: theme.paddingSm,
      left: 0,
      right: 0,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: gap,
        runSpacing: gap,
        children: List.generate(e.total, (index) {
          final selected = index == e.active;
          return selected ? dot : Opacity(opacity: 0.3, child: dot);
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);
    final loop = this.loop;
    final count = this.count;

    return LayoutBuilder(builder: (_, con) {
      mainAxisViewport = con.maxWidth;
      final itemWidth = con.maxWidth;
      final itemHeight = getHeight(con);

      Widget itemBuilder(int index) {
        final child = widget.builder?.call(index) ?? //
            Container(color: theme.gray7);

        return SizedBox(width: itemWidth, height: itemHeight, child: child);
      }

      final delegateBuilder = () {
        if (loop) {
          return (int index) => itemBuilder(index % count);
        } else {
          return itemBuilder;
        }
      }();

      final physics = gesture
          ? const ClampingScrollPhysics() //
          : const NeverScrollableScrollPhysics();

      final indicator = () {
        if (widget.indicator is Widget) {
          return widget.indicator as Widget;
        } else if (widget.indicator == false) {
          return nil;
        } else if (widget.indicator is IndicatorBuilder) {
          return ValueListenableBuilder(
            valueListenable: indicatePage,
            builder: (_, p, __) => widget.indicator(IndicatorStatus(p, count)),
          );
        } else {
          return ValueListenableBuilder(
            valueListenable: indicatePage,
            builder: (_, p, __) =>
                defaultIndicatorBuilder(IndicatorStatus(p, count)),
          );
        }
      }();

      return SizedBox(
        width: con.maxWidth,
        height: itemHeight,
        child: Listener(
          onPointerDown: _onPointerDown,
          onPointerUp: _onPointerUp,
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: true),
            child: Stack(children: [
              PageView.builder(
                physics: physics,
                controller: pager,
                itemCount: loop ? null : count,
                itemBuilder: (_, idx) => delegateBuilder(idx),
              ),
              indicator,
            ]),
          ),
        ),
      );
    });
  }
}
