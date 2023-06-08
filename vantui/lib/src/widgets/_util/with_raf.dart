import 'package:flutter/widgets.dart';

import '../../utils/rendering.dart';

class WithRaf extends StatelessWidget {
  final Function(BuildContext context) onRaf;
  final Widget child;

  const WithRaf(
    this.onRaf, {
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    raf(() => {onRaf(context)});
    return child;
  }
}
