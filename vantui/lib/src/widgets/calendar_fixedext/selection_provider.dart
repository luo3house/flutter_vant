import 'package:dart_date/dart_date.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class CalendarSelectionProvider extends StatelessWidget {
  static CalendarSelectionProvider of(BuildContext context) {
    return Provider.of<CalendarSelectionProvider>(context);
  }

  final Tuple2<DateTime?, DateTime?>? range;

  final List<DateTime>? multiple;

  final Function(DateTime date)? onDaySelect;

  final Widget? child;

  const CalendarSelectionProvider({
    this.range,
    this.multiple,
    this.onDaySelect,
    super.key,
    this.child,
  });

  bool isSelected(DateTime date) {
    return multiple?.where((elem) => elem.equals(date)).isNotEmpty == true;
  }

  bool isRangeFirst(DateTime date) {
    return range?.item1?.equals(date) == true;
  }

  bool isRangeLast(DateTime date) {
    return range?.item2?.equals(date) == true;
  }

  bool isRangeContains(DateTime date) {
    return range?.item1?.isSameOrBefore(date) == true &&
        range?.item2?.isSameOrAfter(date) == true;
  }

  @override
  Widget build(BuildContext context) {
    return Provider<CalendarSelectionProvider>.value(
      value: this,
      child: child,
    );
  }
}
