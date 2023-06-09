import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/utils/nil.dart';
import 'package:flutter_vantui/src/widgets/calendar_fixedext/extent.dart';
import 'package:flutter_vantui/src/widgets/config/index.dart';
import 'package:tailstyle/tailstyle.dart';

class CalendarHeader extends StatelessWidget {
  final CalendarExtent extent;
  final DateTime? date;
  const CalendarHeader({
    super.key,
    required this.extent,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    final child = () {
      final date = this.date;
      if (date == null) return nil;
      return Center(
        child: TailTypo()
            .font_bold()
            .font_size(theme.fontSizeMd)
            .Text("${date.year}年${date.month}月"),
      );
    }();

    return SizedBox(
      height: extent.getHeaderHeight(),
      child: child,
    );
  }
}
