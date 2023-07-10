import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter_vantui/src/utils/date_util.dart';
import 'package:flutter_vantui/src/widgets/form/types.dart';
import 'package:tailstyle/tailstyle.dart';
import 'package:tuple/tuple.dart';

class Slider extends StatefulWidget implements FormItemChild<double> {
  @override
  final double? value;
  @override
  final Function(double v)? onChange;
  final double? min;
  final double? max;
  final double? step;
  final Function(double v)? onChangeEnd;
  final Widget Function(double v)? drawThumb;
  final Color? activeBg;
  final Color? inactiveBg;
  final double? barHeight;

  const Slider({
    this.value,
    this.min,
    this.max,
    this.step,
    this.onChange,
    this.onChangeEnd,
    this.drawThumb,
    this.activeBg,
    this.inactiveBg,
    this.barHeight,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return SliderState();
  }

  @override
  FormItemChild<double> cloneWithFormItemChild(
      {Function(double v)? onChange, double? value}) {
    return Slider(
      value: value,
      min: min,
      max: max,
      step: step,
      onChange: onChange,
      onChangeEnd: onChangeEnd,
      drawThumb: drawThumb,
      key: key,
    );
  }
}

class SliderState extends State<Slider> {
  PointerData? pointer;
  bool instant = false;
  double value = 0;
  double? lastReportedValue;

  double get min => widget.min ?? 0;
  double get max => widget.max ?? 100;
  double? get step => widget.step;

  onPointerDown(Offset pos) {
    pointer = tryCatch(() {
      final renderBox = context.findRenderObject() as RenderBox;
      return PointerData(
        renderBox.localToGlobal(Offset.zero).dx,
        pos.dx,
        renderBox.size.width / (max - min),
        value,
        DateUtil.nowms(),
      );
    });
  }

  onPointerMove(Offset pos) {
    final pointer = this.pointer;
    if (pointer == null) return;

    final delta = pos.dx - pointer.posStart;

    // debounce
    if (delta <= 5 && DateUtil.nowms() - 20 < pointer.msStart) {
      return;
    }

    value = snapValue(pointer.valueStart + delta / pointer.vpx);

    instant = true;
    setState(() {});
    if (lastReportedValue != value) {
      lastReportedValue = value;
      widget.onChange?.call(value);
    }
  }

  onPointerUp(Offset pos) {
    final pointer = this.pointer;
    if (pointer != null && lastReportedValue == null) {
      final delta = pos.dx - (pointer.boxStart + this.value * pointer.vpx);
      final value = snapValue(pointer.valueStart + delta / pointer.vpx);
      if (value != this.value) {
        this.value = value;
        setState(() {});
        widget.onChange?.call(value);
      }
    }
    if (value != widget.value) {
      widget.onChangeEnd?.call(value);
    }
    this.pointer = null;
    lastReportedValue = null;
  }

  // V0.85, S0.1 -> 0.9
  // V0.84, S0.1 -> 0.8
  // V0.48, S1.0 -> 0
  // V4.80, S5.0 -> 5
  // V6.10, S3.0 -> 6
  double snapValue(double value) {
    final step = this.step;
    final wideValue = () {
      if (step == null) return value; // no restricted
      return ((value / step).round() * step);
    }();
    return clampDouble(wideValue, min, max);
  }

  @override
  void initState() {
    super.initState();
    assert(min < max);
    assert(step == null || (min % step! == 0 && (max % step! == 0)));
    instant = true;
    value = widget.value ?? 0;
  }

  @override
  void didUpdateWidget(covariant Slider oldWidget) {
    super.didUpdateWidget(oldWidget);
    value = widget.value ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);
    final value = clampDouble(this.value, min, max);
    final instant = this.instant;
    this.instant = false;

    final barHeight = widget.barHeight ?? 2.0;

    final inactiveBg = widget.inactiveBg ?? theme.gray3;
    final activeBg = widget.activeBg ?? theme.primaryColor;

    return LayoutBuilder(builder: (_, con) {
      final left = value / max * con.maxWidth;

      final inactiveBar = TailBox() //
          .bg(inactiveBg)
          .rounded(999)
          .Container(height: barHeight, width: con.maxWidth);

      final activeBar = TailBox() //
          .bg(activeBg)
          .rounded(999)
          .Container(height: barHeight, width: con.maxWidth);

      const shadow = BoxShadow(
        offset: Offset(0, 1),
        blurRadius: 2,
        color: Color.fromRGBO(0, 0, 0, 0.5),
      );

      const thumbSize = 24.0;
      final thumb = () {
        const thumbBg = Color(0xFFFFFFFF);
        final drawThumb = widget.drawThumb;
        if (drawThumb != null) {
          return drawThumb(value);
        } else {
          return Transform.translate(
            offset: const Offset(-thumbSize / 2, 0),
            child: TailBox()
                .shadow([shadow])
                .bg(thumbBg)
                .rounded(thumbSize / 2)
                .Container(width: thumbSize, height: thumbSize),
          );
        }
      }();

      return Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: (e) => {if (e.down) onPointerDown(e.position)},
        onPointerMove: (e) => {if (e.down) onPointerMove(e.position)},
        onPointerUp: (e) => {onPointerUp(e.position)},
        child: Stack(alignment: Alignment.centerLeft, children: [
          const SizedBox(height: thumbSize),
          inactiveBar,
          TweenAnimationBuilder(
            tween: Tween(begin: 0.0, end: left),
            duration: instant ? Duration.zero : theme.durationFast,
            builder: (_, x, child) => Transform.scale(
              alignment: Alignment.centerLeft,
              scaleX: x / con.maxWidth,
              child: child,
            ),
            child: activeBar,
          ),
          Positioned(
            child: TweenAnimationBuilder(
              tween: Tween(begin: 0.0, end: left),
              duration: instant ? Duration.zero : theme.durationFast,
              builder: (_, x, child) => Transform.translate(
                offset: Offset(x, 0),
                child: child,
              ),
              child: thumb,
            ),
          ),
          Positioned.fill(child: GestureDetector(onVerticalDragStart: (e) {})),
        ]),
      );
    });
  }
}

class PointerData extends Tuple5<double, double, double, double, int> {
  const PointerData(
      super.item1, super.item2, super.item3, super.item4, super.item5);

  /// left-top pos of render box
  double get boxStart => item1;

  /// pos of pointer down
  double get posStart => item2;

  /// value per pixel
  double get vpx => item3;

  /// value freezed at pointer down
  double get valueStart => item4;

  /// time since pointer down
  int get msStart => item5;
}
