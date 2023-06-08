import 'package:dart_date/dart_date.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/widgets/calendar_fixedext/extent.dart';
import 'package:flutter_vantui/src/widgets/calendar_fixedext/header.dart';
import 'package:flutter_vantui/src/widgets/calendar_fixedext/selection_provider.dart';
import 'package:flutter_vantui/src/widgets/calendar_fixedext/weekdays.dart';
import 'package:flutter_vantui/src/widgets/config/index.dart';
import 'package:tuple/tuple.dart';

import 'month.dart';

enum CalendarType { single, multiple, range }

class Calendar extends StatefulWidget {
  final DateTime? minDate;
  final DateTime? maxDate;
  final double? dayHeight;
  final bool? shrinkWrap;
  final CalendarType? type;
  final dynamic value;
  final Function(List<DateTime> values)? onChange;

  const Calendar({
    this.minDate,
    this.maxDate,
    this.dayHeight,
    this.shrinkWrap,
    this.type,
    this.value,
    this.onChange,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return CalendarState();
  }
}

class CalendarState extends State<Calendar> {
  final controller = ScrollController();
  var values = <DateTime>[];
  var offset = ValueNotifier(0.0);

  CalendarType get type => widget.type ?? CalendarType.single;

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
    controller.addListener(() => offset.value = controller.offset);
    values = _normalizeValue(widget.value);
  }

  @override
  void didUpdateWidget(covariant Calendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    values = _normalizeValue(widget.value);
  }

  @override
  void dispose() {
    controller.dispose();
    offset.dispose();
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

    final extent = CalendarExtent(dayHeight: widget.dayHeight);

    bool isDayDisabled(DateTime date) =>
        date.isBefore(minDate) || date.isAfter(maxDate);

    final selectionRange = () {
      if (type != CalendarType.range) return null;
      return Tuple2(
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
        color: theme.background2,
        child: Column(children: [
          ValueListenableBuilder(
            valueListenable: offset,
            builder: (_, offset, __) {
              return CalendarHeader(
                extent: extent,
                date: months.elementAt(extent.getIndexByDeltaY(offset)),
              );
            },
          ),
          CalendarWeekdays(extent: extent),
          Expanded(
            child: CustomScrollView(
              controller: controller,
              slivers: [
                SliverFixedExtentList(
                  itemExtent: extent.getMonthBodyHeight(),
                  delegate: SliverChildBuilderDelegate(
                    childCount: months.length,
                    (_, i) {
                      final date = months.elementAt(i);
                      return CalendarMonth(
                        extent: extent,
                        year: date.year,
                        month: date.month,
                        disabledDayIf: isDayDisabled,
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
