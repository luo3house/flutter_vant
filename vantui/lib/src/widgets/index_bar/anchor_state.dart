import 'package:flutter/widgets.dart';

class AnchorState extends InheritedWidget {
  static AnchorState? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AnchorState>();

  final bool selected;
  const AnchorState({
    required this.selected,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
