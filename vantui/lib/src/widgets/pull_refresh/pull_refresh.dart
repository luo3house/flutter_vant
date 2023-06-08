import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/utils/touch.dart';
import 'package:flutter_vantui/src/widgets/_util/safe_setstate.dart';
import 'package:tailstyle/tailstyle.dart';
import 'package:tuple/tuple.dart';

import '../../utils/nil.dart';
import '../config/index.dart';

enum PullRefreshStatus {
  ready, // is ready for recognize pull gesture
  pull, // is in pulling
  refresh, // is in refreshing
  stay, // have refreshed successfully and staying at a while
  back, // is rolling back to ready
}

class HeadArgs extends Tuple4<double, double, double, PullRefreshStatus> {
  const HeadArgs(super.item1, super.item2, super.item3, super.item4);

  /// 0.0 - headHeight, or > headHeight if overflow
  double get visibleHeight => item1;

  /// 0.0 - 1.0, or > 1.0 if overflow
  double get visibleRatio => item2;

  double get headHeight => item3;

  /// one of [PullRefreshStatus.pull], [PullRefreshStatus.refresh], [PullRefreshStatus.stay]
  PullRefreshStatus get status => item4;
}

typedef HeadBuilder = Widget Function(HeadArgs args);

class VanPullRefresh extends StatefulWidget {
  final Future Function()? onRefresh;
  final double? headHeight;
  final HeadBuilder? drawHead;
  final ScrollController? controller;
  final Widget? child;

  const VanPullRefresh({
    this.onRefresh,
    this.headHeight,
    this.drawHead,
    this.controller,
    this.child,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return VanPullRefreshState();
  }
}

class VanPullRefreshState extends State<VanPullRefresh> with SafeSetStateMixin {
  static const _ready = PullRefreshStatus.ready;
  static const _pull = PullRefreshStatus.pull;
  static const _refresh = PullRefreshStatus.refresh;
  static const _stay = PullRefreshStatus.stay;
  static const _back = PullRefreshStatus.back;

  final touch = _Touch();
  var status = _ready;
  var ignoreTouchTrigger = false;
  var currentOffset = 0.0;

  double get headHeight => widget.headHeight ?? 40;
  bool satisfyRefresh() => currentOffset >= headHeight;
  Duration get stayDuration => const Duration(seconds: 1);
  Future Function() get onRefresh =>
      widget.onRefresh ??
      () => Future.delayed(const Duration(milliseconds: 500));

  refresh() => _doRefresh();

  _doRefresh() {
    currentOffset = headHeight;
    status = _refresh;
    setState(() {});
    onRefresh().then((_) {
      status = _stay;
      setState(() {});
      return Future.delayed(stayDuration, () {
        status = _back;
        currentOffset = 0;
        setState(() {});
      });
    }).catchError((err) {
      status = _back;
      setState(() {});
      throw err;
    });
  }

  void handleAgnosticDrag(double negativableDragOffset) {
    if (status != _pull) return;
    if (negativableDragOffset > 0) {
      status = _ready;
      currentOffset = 0;
      return setState(() {});
    }
    currentOffset = negativableDragOffset.abs();
    setState(() {});
  }

  void handleScrollNotification(double negativableOffset) {
    // print("from scroll: ${negativableOffset}");
    ignoreTouchTrigger = true;
    handleAgnosticDrag(
      negativableOffset + (touch.negativableOffset ?? 0),
    );
  }

  void onAnimationEnd() {
    // print("onAnimationEnd");

    if (status == _back) {
      status = _ready;
      setState(() {});
    }
  }

  void handlePointerDown(Offset pos) {
    ignoreTouchTrigger = (widget.controller?.offset ?? 0) != 0;
    touch.clear();
    touch.touchStart(pos.dx, pos.dy);

    // print("handlePointerDown: ${pos}");

    if (status == _ready) {
      status = _pull;
      setState(() {});
    }
  }

  void handlePointerMove(Offset pos) {
    final touch = this.touch;
    if (!ignoreTouchTrigger) {
      touch.touchMove(pos.dx, pos.dy);
      // print("from touch: ${touch.negativableOffset}");
      handleAgnosticDrag(touch.negativableOffset);
    }
    // print("handlePointerMove: ${pos}");
  }

  void handlePointerUp(Offset pos) {
    // print("handlePointerUp: ${pos}");

    if (status == _pull && satisfyRefresh()) {
      _doRefresh();
    } else if ([_refresh, _stay].contains(status)) {
    } else if (currentOffset > 0) {
      currentOffset = 0;
      status = _back;
      setState(() {});
    }
  }

  Widget defaultDrawHead(HeadArgs args) {
    final text = <PullRefreshStatus, String>{
      _refresh: '刷新中',
      _stay: '刷新成功',
    }[status];
    return Center(child: Text(text ?? '下拉刷新'));
  }

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    final shouldUseAnim = [_back, _refresh].contains(status);
    final shouldShowHead = [_pull, _refresh, _stay].contains(status);

    final headTextStyle = TailTypo() //
        .text_color(theme.textColor2)
        .font_size(theme.fontSizeMd);

    final headArgs = HeadArgs(
      currentOffset,
      currentOffset / headHeight,
      headHeight,
      status,
    );

    final headLimitOverflow = ClipRect(
      clipBehavior: Clip.hardEdge,
      child: OverflowBox(
        alignment: Alignment.bottomCenter,
        minHeight: 0,
        maxHeight: headHeight,
        child: shouldShowHead
            ? (widget.drawHead ?? defaultDrawHead).call(headArgs)
            : nil,
      ),
    );

    final animatedHead = TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: currentOffset),
      duration: shouldUseAnim //
          ? theme.durationFast
          : Duration.zero,
      builder: (_, y, headLimitOverflow) => SizedBox(
        height: y,
        child: headLimitOverflow,
      ),
      child: headLimitOverflow,
    );

    final animatedChild = TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: currentOffset),
      duration: shouldUseAnim //
          ? theme.durationFast
          : Duration.zero,
      onEnd: () => onAnimationEnd(),
      builder: (_, y, child) => Transform.translate(
        offset: Offset(0, y),
        child: child,
      ),
      child: widget.child,
    );

    return Stack(
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          left: 0,
          right: 0,
          child: DefaultTextStyle(
            style: headTextStyle.TextStyle(),
            child: animatedHead,
          ),
        ),
        Listener(
          onPointerDown: (e) => handlePointerDown(e.position),
          onPointerMove: (e) => handlePointerMove(e.position),
          onPointerUp: (e) => handlePointerUp(e.position),
          child: NotificationListener<ScrollNotification>(
            onNotification: (e) {
              handleScrollNotification(e.metrics.pixels);
              return false;
            },
            child: ClipRect(
              clipBehavior: Clip.hardEdge,
              child: animatedChild,
            ),
          ),
        ),
      ],
    );
  }
}

class _Touch extends Touch {
  // >= 0, positive scrolling
  // < 0, negative scrolling
  get negativableOffset => -distanceY;
}
