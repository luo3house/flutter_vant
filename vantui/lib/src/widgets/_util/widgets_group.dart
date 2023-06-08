import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../utils/nil.dart';
import '../../utils/std.dart';

class WidgetsGroup<WidgetElem> extends StatelessWidget {
  static WidgetsGroup<WidgetElem>? ofn<WidgetElem>(BuildContext context) {
    return tryCatch(() => Provider.of<WidgetsGroup<WidgetElem>>(context));
  }

  final List<Widget> children;
  final Widget Function(List<Widget> children)? builder;

  const WidgetsGroup({
    this.children = const [],
    this.builder,
    super.key,
  });

  int indexOf(dynamic cell) => children.indexOf(cell);

  bool isFirst(dynamic cell) {
    final index = indexOf(cell);
    return index == 0;
  }

  bool isLast(dynamic cell) {
    final index = indexOf(cell);
    return index != -1 && index + 1 == children.length;
  }

  bool hasNext(dynamic cell) {
    final index = indexOf(cell);
    return index != -1 && index + 1 < children.length;
  }

  Widget buildChild() {
    return builder?.call(children) ?? nil;
  }

  @override
  Widget build(BuildContext context) {
    return Provider<WidgetsGroup<WidgetElem>>.value(
      value: this,
      child: buildChild(),
    );
  }
}
