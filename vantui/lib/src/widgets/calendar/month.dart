import 'package:flutter/widgets.dart';
import 'package:tailstyle/tailstyle.dart';

import '../../utils/date_util.dart';
import 'day.dart';
import 'extent.dart';

class CalendarMonth extends StatelessWidget {
  final DateTime date;
  final CalendarExtent extent;
  final Function(DateTime date) disabledDayIf;

  const CalendarMonth({
    required this.extent,
    required this.date,
    required this.disabledDayIf,
    super.key,
  });

  List<Widget> mapChildren(Iterable<Widget> children) {
    return List.of(children);
  }

  int get year => date.year;
  int get month => date.month;

  @override
  Widget build(BuildContext context) {
    final headerExtent = extent.getMonthHeaderHeight();
    final bodyHeight = extent.getMonthBodyHeight(year, month);
    final dayHeight = extent.getDayHeight();

    // Blank..1..N
    final firstDayIndex = DateUtil.getFirstDayOffset(year, month);
    final days = List.generate(
      firstDayIndex + DateUtil.getDaysInMonth(year, month),
      (index) {
        if (index < firstDayIndex) return null;
        return index - firstDayIndex + 1;
      },
    );

    final headerText = "$year年$month月";

    return LayoutBuilder(builder: (_, con) {
      final dayWidth = (con.maxWidth / 7).floor().toDouble();

      return TailBox().as((styled) {
        return styled.Container(
          width: con.maxWidth,
          height: bodyHeight,
          child: Stack(alignment: Alignment.center, children: [
            TailTypo()
                .text_color(const Color(0xCCF2F3F5))
                .font_size(160)
                .Text(month.toString()),
            Column(mainAxisSize: MainAxisSize.min, children: [
              SizedBox(
                height: headerExtent,
                child: TailTypo().font_bold().text_center().Text(headerText),
              ),
              Wrap(children: mapChildren(days.map((day) {
                if (day == null) {
                  return SizedBox(width: dayWidth, height: dayHeight);
                } else {
                  final date = DateTime(year, month, day);
                  return CalendarDay(
                    width: dayWidth,
                    extent: extent,
                    date: date,
                    disabled: disabledDayIf(date),
                  );
                }
              }))),
            ]),
          ]),
        );
      });
    });
  }
}
