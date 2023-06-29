import 'package:flutter/widgets.dart';
import 'package:tailstyle/tailstyle.dart';

import '../../utils/nil.dart';
import '../config/index.dart';
import 'extent.dart';

class CalendarStickyHeader extends StatelessWidget {
  final CalendarExtent extent;
  final DateTime? date;
  const CalendarStickyHeader({
    required this.extent,
    this.date,
    super.key,
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
      height: extent.getStickyHeaderHeight(),
      child: child,
    );
  }
}
