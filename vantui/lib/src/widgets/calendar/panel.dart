import 'dart:collection';

import 'package:dart_date/dart_date.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/widgets/_util/with_delayed.dart';
import 'package:flutter_vantui/src/widgets/_util/with_raf.dart';
import '../../utils/rendering.dart';
import '../../utils/std.dart';
import '../config/index.dart';
import 'extent.dart';
import 'header.dart';
import 'selection_provider.dart';
import 'weekdays.dart';
import 'package:tuple/tuple.dart';

import 'month.dart';

enum CalendarType { single, multiple, range }

class CalendarPanel extends StatefulWidget {
  final DateTime? minDate;
  final DateTime? maxDate;
  final double? dayHeight;
  final CalendarType? type;
  final dynamic value;
  final Function(List<DateTime> values)? onChange;
  final bool? expands;

  const CalendarPanel({
    this.minDate,
    this.maxDate,
    this.dayHeight,
    this.type,
    this.value,
    this.onChange,
    this.expands,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return CalendarPanelState();
  }
}

class CalendarPanelState extends State<CalendarPanel> {
  late CalendarExtent extent;
  final controller = ScrollController();
  final offsetDateIndexMap = SplayTreeMap<double, int>();
  final currentStickyIndex = ValueNotifier(0);
  var values = <DateTime>[];

  CalendarType get type => widget.type ?? CalendarType.single;
  bool get expands => widget.expands == true;

  List<DateTime> _normalizeValue(dynamic value) {
    if (value is List) {
      return List<DateTime>.from(value);
    } else if (value is DateTime) {
      return [value];
    } else if (value == null) {
      return [];
    }
    assert(false, "unrecognized value type: ${value.runtimeType}");
    return [];
  }

  @override
  void initState() {
    super.initState();
    extent = CalendarExtent(dayHeight: widget.dayHeight);
    controller.addListener(() {
      currentStickyIndex.value = extent.getStickyIndexByScrollOffset(
        controller.offset,
        offsetDateIndexMap,
      );
    });
    values = _normalizeValue(widget.value);
  }

  @override
  void didUpdateWidget(covariant CalendarPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    values = _normalizeValue(widget.value);
    if (widget.dayHeight != oldWidget.dayHeight) {
      extent = CalendarExtent(dayHeight: widget.dayHeight);
      offsetDateIndexMap.clear();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    currentStickyIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    final now = DateTime.now();
    final minDate = widget.minDate ?? now;
    final maxDate = widget.maxDate ?? now.endOfYear.subMilliseconds(1);
    assert(maxDate.millisecondsSinceEpoch > minDate.millisecondsSinceEpoch);

    final months = () {
      final list = <DateTime>[minDate];
      var tmp = minDate;
      while (tmp.year != maxDate.year || tmp.month != maxDate.month) {
        list.add(tmp = tmp.addMonths(1));
      }
      return list;
    }();

    bool isDayDisabled(DateTime date) =>
        date.isBefore(minDate) || date.isAfter(maxDate);

    final selectionRange = () {
      if (type != CalendarType.range) return null;
      return Tuple2(
        // ignore: prefer_is_empty
        values.length > 0 ? values[0] : null,
        values.length > 1 ? values[1] : null,
      );
    }();

    final selectionMultiple = () {
      if (type == CalendarType.range) return null;
      return values;
    }();

    onDayTap(DateTime date) {
      date = date.startOfDay;
      if (type == CalendarType.single) {
        setState(() => values = [date]);
        widget.onChange?.call(values);
      } else if (type == CalendarType.multiple) {
        final index = values.indexWhere((e) => e.equals(date));
        setState(() {
          if (index != -1) {
            values.removeAt(index);
          } else {
            values.add(date);
          }
        });
        widget.onChange?.call(values);
      } else if (type == CalendarType.range) {
        if (values.isEmpty) {
          // select from
          setState(() => values = [date]);
        } else if (values.length == 1) {
          // select to
          if (values[0].isBefore(date)) {
            setState(() => values.add(date));
            widget.onChange?.call(values);
          } else if (values[0].isAfter(date)) {
            // but to is before from, so reset from
            setState(() => values = [date]);
          } else {
            // from = to, do nothing
          }
        } else if (values.length == 2) {
          // re-select
          setState(() => values = [date]);
        }
      }
    }

    return CalendarSelectionProvider(
      range: selectionRange,
      multiple: selectionMultiple,
      onDaySelect: onDayTap,
      child: Container(
        constraints: !expands //
            ? const BoxConstraints.tightFor(height: 264)
            : null,
        color: theme.background2,
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          ValueListenableBuilder(
            valueListenable: currentStickyIndex,
            builder: (_, index, __) => CalendarHeader(
              extent: extent,
              date: months[index],
            ),
          ),
          CalendarWeekdays(extent: extent),
          Expanded(
            child: CustomScrollView(
              controller: controller,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: months.length,
                    (sliverCtx, monthIndex) {
                      final date = months.elementAt(monthIndex);
                      final constraints = BoxConstraints.tightFor(
                        height: extent.getMonthBodyHeight(
                          date.year,
                          date.month,
                        ),
                      );
                      return WithRaf(
                        (indexCtx) {
                          tryCatch(() {
                            offsetDateIndexMap.putIfAbsent(
                              getChildOffsetInSliverList(sliverCtx, indexCtx) ??
                                  0,
                              () => monthIndex,
                            );
                          });
                        },
                        child: WithDelayed(
                          constraints: constraints,
                          () => CalendarMonth(
                            extent: extent,
                            date: date,
                            disabledDayIf: isDayDisabled,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
