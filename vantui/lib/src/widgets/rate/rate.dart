import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../utils/nil.dart';
import '../../utils/std.dart';
import '../config/index.dart';
import '../form/types.dart';
import '../icon/index.dart';

class VanRate extends StatefulWidget implements FormItemChild<double> {
  @override
  final double? value;
  @override
  final Function(double v)? onChange;
  final int? count;
  final double? size;
  final dynamic voidIcon;
  final dynamic icon;
  final Color? color;
  final Color? voidColor;
  final double? gap;
  final bool? allowHalf;

  const VanRate({
    this.value,
    this.count,
    this.size,
    this.voidIcon,
    this.icon,
    this.color,
    this.voidColor,
    this.gap,
    this.allowHalf,
    this.onChange,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return VanRateState();
  }

  @override
  FormItemChild<double> cloneWithFormItemChild(
      {Function(double v)? onChange, double? value}) {
    return VanRate(
      value: value,
      count: count,
      size: size,
      color: color,
      voidColor: voidColor,
      gap: gap,
      allowHalf: allowHalf,
      onChange: onChange,
      key: key,
    );
  }
}

class VanRateState extends State<VanRate> {
  Offset? panBase;
  double lastReportChangeValue = 0;

  double get value => widget.value ?? 0;
  int get count => widget.count ?? 5;
  double get size => widget.size ?? 20;
  double get gap => widget.gap ?? 4;
  bool get allowHalf => widget.allowHalf ?? false;
  dynamic get voidIcon => widget.voidIcon ?? VanIcons.star_o;
  dynamic get icon => widget.icon ?? VanIcons.star;

  onPointerDown(Offset pos) {
    panBase = tryCatch(() => (context.findRenderObject() as RenderBox) //
        .localToGlobal(Offset.zero));
    lastReportChangeValue = 0;
  }

  onPointerMove(Offset pos) {
    final panBase = this.panBase;
    if (panBase == null) return;
    final newValue = pointer2value(pos.dx - panBase.dx);
    if (newValue != lastReportChangeValue) {
      lastReportChangeValue = newValue;
      widget.onChange?.call(newValue);
    }
  }

  onPointerUp(Offset pos) {
    if (panBase != null && lastReportChangeValue == 0) {
      final newValue = pointer2value(pos.dx - panBase!.dx);
      widget.onChange?.call(newValue);
    }
    panBase = null;
    lastReportChangeValue = 0;
  }

  pointer2value(double dx) {
    final starExtent = gap + size;
    final value = () {
      if (!allowHalf) {
        return (dx / starExtent).ceil();
      } else {
        final indexAt = max(0.0, dx / starExtent);

        final diff = dx % starExtent;
        if (indexAt == 0) {
          return 0;
        } else if (diff >= starExtent * .7) {
          return indexAt.ceil();
        } else if (diff >= starExtent * .25) {
          return indexAt.floor() + 0.5;
        } else {
          return indexAt.floor();
        }
      }
    }();
    return clampDouble(value.toDouble(), 0, count.toDouble());
  }

  Widget probeIcon(dynamic icon) {
    if (icon is Widget) {
      return icon;
    } else if (icon is IconData) {
      return Icon(icon);
    } else if (icon is String) {
      return Text(icon);
    } else {
      return nil;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    final color = widget.color ?? theme.dangerColor;
    final voidColor = widget.voidColor ?? theme.gray5;

    final icon = probeIcon(this.icon);
    final voidIcon = probeIcon(this.voidIcon);

    final baseStars = List.generate(count, (_) {
      return IconTheme(
        data: IconThemeData(color: voidColor, size: size),
        child: voidIcon,
      );
    });

    final filledStars = List.generate(count, (index) {
      final fillStar = IconTheme(
        data: IconThemeData(color: color, size: size),
        child: icon,
      );
      final min = index, max = index + 1;
      if (value >= max) {
        return fillStar;
      } else if (value > min && allowHalf) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(),
          height: size,
          width: size / 2,
          child: fillStar,
        );
      } else {
        return nil;
      }
    });

    final wraps = List.generate(count, (index) {
      final isLast = index == count - 1;
      return Stack(children: [
        baseStars[index],
        filledStars[index],
        SizedBox(width: size + (isLast ? 0 : gap)),
      ]);
    });

    return Listener(
      behavior: HitTestBehavior.opaque,
      onPointerDown: (e) => {if (e.down) onPointerDown(e.position)},
      onPointerMove: (e) => {if (e.down) onPointerMove(e.position)},
      onPointerUp: (e) => {onPointerUp(e.position)},
      child: Stack(children: [
        Row(mainAxisSize: MainAxisSize.min, children: wraps),
        Positioned.fill(child: GestureDetector(onVerticalDragStart: (e) {})),
      ]),
    );
  }
}
