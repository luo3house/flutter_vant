import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';

class CalendarPage extends StatelessWidget {
  final Uri location;
  const CalendarPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("Basic Usage"),
      SizedBox(
        height: 300,
        child: VanCalendar(
          minDate: DateTime(2010, 01, 14),
          maxDate: DateTime(2010, 09, 13),
          type: VanCalendarType.range,
          // ignore: avoid_print
          onChange: (values) => print(values),
        ),
      ),
    ]);
  }
}
