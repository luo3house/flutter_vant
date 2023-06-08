import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/utils/nil.dart';

class VanCol extends StatelessWidget {
  final int? span;
  final int? offset;
  final Widget? child;
  const VanCol({this.span, this.offset, this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return child ?? nil;
  }
}
