import 'package:flutter/widgets.dart';

import '../../utils/nil.dart';

class ValueProvider<T> extends InheritedWidget {
  static ValueProvider<T>? ofn<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ValueProvider<T>>();
  }

  final T value;
  final Function(T value)? onChange;
  final Function(T a, T b)? updateShouldNotifyDelegate;

  const ValueProvider({
    required this.value,
    this.onChange,
    this.updateShouldNotifyDelegate,
    super.child = nil,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant ValueProvider<T> oldWidget) {
    return updateShouldNotifyDelegate?.call(oldWidget.value, value) ??
        oldWidget.value != value;
  }
}
