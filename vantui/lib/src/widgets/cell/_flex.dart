import 'package:flutter/widgets.dart';

import '../../utils/nil.dart';

class CellFlexProvider extends InheritedWidget {
  static CellFlexProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CellFlexProvider>() ??
        const CellFlexProvider();
  }

  final Widget Function(Widget child)? flexLeftDelegate;
  final Widget Function(Widget child)? flexRightDelegate;

  const CellFlexProvider({
    super.key,
    super.child = nil,
    this.flexLeftDelegate,
    this.flexRightDelegate,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  Widget flexLeft(Widget child) {
    return (flexLeftDelegate ?? (child) => Expanded(child: child)).call(child);
  }

  Widget flexRight(Widget child) {
    return (flexRightDelegate ?? (child) => Expanded(child: child)).call(child);
  }
}
