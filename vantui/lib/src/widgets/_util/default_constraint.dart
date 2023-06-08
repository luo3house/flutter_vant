import 'package:flutter/widgets.dart';

class DefaultConstraint extends StatelessWidget {
  final double? maxHeight;
  final double? maxWidth;
  final Widget child;

  const DefaultConstraint({
    this.maxHeight,
    this.maxWidth,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, con) {
      if (maxHeight != null) {
        con = con.copyWith(
            maxHeight: con.maxHeight == double.infinity ? maxHeight! : null);
      }
      if (maxWidth != null) {
        con = con.copyWith(
            maxWidth: con.maxWidth == double.infinity ? maxWidth! : null);
      }
      return ConstrainedBox(constraints: con, child: child);
    });
  }
}
