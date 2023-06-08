import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/utils/nil.dart';

import '../config/index.dart';

class Tab extends StatelessWidget {
  final String name;
  final dynamic title;
  final dynamic child;
  final Color? bgColor;

  const Tab(
    this.name, {
    this.title,
    this.child,
    this.bgColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    final bg = bgColor ?? theme.background2;

    return child is Widget ? Container(color: bg, child: child) : nil;
  }
}
