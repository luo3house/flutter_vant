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

class SwipeIndicatorBuilder {
  final Widget Function(IndicatorStatus e) builder;
  const SwipeIndicatorBuilder(this.builder);
}

typedef HeightFromConstraint = double Function(BoxConstraints con);

class Swipe extends StatefulWidget {
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
  final Function(int index)? onChange;
  final List<Widget>? children;
  final Widget Function(int index)? builder;
  final bool? padEnds;
  const Swipe({
    this.autoplay,
    this.duration,
    this.initialIndex,
    this.height,
    this.aspectRatio,
    this.indicator,
    this.gesture,
    this.loop,
    this.count,
    this.viewportFraction,
    this.onChange,
    this.children, // either children or builder is mandatory
    this.builder, // either children or builder is mandatory
    this.padEnds,
    super.key,
  });

  @override
  createState() => SwipeState();
}

class SwipeState extends State<Swipe> {
  final indicatePage = ValueNotifier(0);
  late PageController pager;
  late _SwipePageHelper _helper;
  Timer? autoplayTimer;

  bool get loop => widget.loop ?? false;
  bool get gesture => widget.gesture ?? true;
  int get count => widget.count ?? widget.children?.length ?? 1;
  int get initialIndex => widget.initialIndex ?? 0;
  Duration get duration => widget.duration ?? const Duration(milliseconds: 500);
  Duration get autoplay => widget.autoplay ?? Duration.zero;
  double get viewportFraction => widget.viewportFraction ?? 1.0;
  bool get padEnds => widget.padEnds ?? true;

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

  stopAutoplayTimer() {
    autoplayTimer?.cancel();
  }

  startAutoplayTimer() {
    stopAutoplayTimer();
    if (autoplay == Duration.zero) return;
    autoplayTimer = Timer.periodic(autoplay + duration, (_) {
      final pageFloat = pager.page;
      if (pageFloat == null || pageFloat.floor() != pageFloat) return;
      final page = pageFloat.floor();
      if (loop) {
        final realPage = _helper.page2realPage(page);
        pager.jumpTo(
          _helper.realPage2px(
            realPage,
            pager.position.viewportDimension,
          ),
        );
        setIndex(realPage + 1);
      } else {
        final nextPage = (page + 1) % count;
        setIndex(nextPage);
      }
    });
  }

  setIndex(int index) {
    stopAutoplayTimer();
    startAutoplayTimer();
    if (pager.hasClients) {
      pager.animateToPage(
        _helper.realPage2page(index),
        duration: duration,
        curve: Curves.ease,
      );
    }
  }

  bool _onPointerDown(PointerDownEvent e) {
    stopAutoplayTimer();
    return false;
  }

  bool _onPointerUp(PointerUpEvent e) {
    startAutoplayTimer();
    return false;
  }

  initPageHelper() {
    _helper = _SwipePageHelper(loop ? 10000 : 0, count);
  }

  @override
  void initState() {
    super.initState();
    initPageHelper();
    pager = PageController(
      initialPage: _helper.basePage + initialIndex,
      viewportFraction: viewportFraction,
    );
    pager.addListener(() {
      final page = pager.page;
      if (page != null) {
        final realPage = _helper.page2realPage(page.round());
        indicatePage.value = realPage;
      }
    });
    indicatePage.addListener(() {
      widget.onChange?.call(indicatePage.value);
    });
    startAutoplayTimer();
  }

  @override
  void didUpdateWidget(covariant Swipe oldWidget) {
    super.didUpdateWidget(oldWidget);
    initPageHelper();
  }

  @override
  void dispose() {
    autoplayTimer?.cancel();
    pager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);
    final loop = this.loop;
    final count = this.count;

    final children = Map.fromEntries(
      List.generate(
        widget.children?.length ?? 0,
        (i) => MapEntry(i, widget.children!.elementAt(i)),
      ),
    );

    return LayoutBuilder(builder: (_, con) {
      final itemSize = Size(con.maxWidth, getHeight(con));
      final builder = widget.builder ??
          (idx) => children[idx] ?? Container(color: theme.gray7);

      final physics = gesture
          ? const ClampingScrollPhysics() //
          : const NeverScrollableScrollPhysics();

      final indicator = () {
        if (widget.indicator is Widget) {
          return widget.indicator as Widget;
        } else if (widget.indicator == false) {
          return nil;
        } else if (widget.indicator is SwipeIndicatorBuilder) {
          return ValueListenableBuilder(
            valueListenable: indicatePage,
            builder: (_, p, __) => (widget.indicator as SwipeIndicatorBuilder)
                .builder(IndicatorStatus(p, count)),
          );
        } else {
          return ValueListenableBuilder(
            valueListenable: indicatePage,
            builder: (_, p, __) =>
                _DefaultSwipeIndicator(IndicatorStatus(p, count)),
          );
        }
      }();

      return SizedBox(
        width: con.maxWidth,
        height: itemSize.height,
        child: Listener(
          onPointerDown: _onPointerDown,
          onPointerUp: _onPointerUp,
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Stack(children: [
              PageView.builder(
                physics: physics,
                controller: pager,
                itemCount: loop ? null : count,
                padEnds: padEnds,
                itemBuilder: (_, idx) => SizedBox.fromSize(
                  size: itemSize,
                  child: builder(_helper.page2realPage(idx)),
                ),
              ),
              indicator,
            ]),
          ),
        ),
      );
    });
  }
}

class _DefaultSwipeIndicator extends StatelessWidget {
  final IndicatorStatus status;
  const _DefaultSwipeIndicator(this.status);

  @override
  Widget build(BuildContext context) {
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
        children: List.generate(status.total, (index) {
          final selected = index == status.active;
          return selected ? dot : Opacity(opacity: 0.3, child: dot);
        }),
      ),
    );
  }
}

class _SwipePageHelper {
  final int basePage;
  final int count;
  const _SwipePageHelper(this.basePage, this.count);

  int get minPage => basePage;
  int get maxPage => basePage + count;

  int page2realPage(int page) => (page - basePage) % count;
  int realPage2page(int rPage) => rPage + basePage;

  double realPage2px(int rPage, double viewport) =>
      realPage2page(rPage) * viewport;
}
