import 'package:flutter/widgets.dart';
import '../_util/has_next_widget.dart';

class VanCellGroup extends StatelessWidget {
  final List<Widget> children;

  const VanCellGroup({
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(children.length, (index) {
        return HasNextWidget(
          hasNext: index + 1 < children.length,
          child: children[index],
        );
      }),
    );
  }
}
