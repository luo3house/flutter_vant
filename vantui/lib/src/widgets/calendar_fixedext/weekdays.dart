import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter_vantui/src/widgets/calendar_fixedext/extent.dart';
import 'package:tailstyle/tailstyle.dart';

class CalendarWeekdays extends StatelessWidget {
  final CalendarExtent extent;
  const CalendarWeekdays({
    required this.extent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    const shadow = BoxShadow(
      color: Color(0x297D7E80),
      offset: Offset(0, 2),
      blurRadius: 10,
    );

    return TailBox().bg(theme.background2).shadow([shadow]).as((styled) {
      return styled.Container(
        height: extent.getWeekdaysHeight(),
        child: Row(
          children: List.of("日一二三四五六".split("").map((char) {
            return Expanded(child: Center(child: Text(char)));
          })),
        ),
      );
    });
  }
}
