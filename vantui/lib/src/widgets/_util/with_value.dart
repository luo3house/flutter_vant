import 'package:flutter/widgets.dart';

class WithValue<T> extends StatefulWidget {
  final T value;
  final Widget Function(ValueNotifier<T> model) builder;

  /// compare between value in state and value from widget
  final bool Function(T a, T b)? shouldSync;

  const WithValue(
    this.value,
    this.builder, {
    this.shouldSync,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _WithValueState<T>();
  }
}

class _WithValueState<T> extends State<WithValue<T>> {
  late ValueNotifier<T> value;
  @override
  void initState() {
    super.initState();
    value = ValueNotifier(widget.value);
  }

  @override
  void dispose() {
    value.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant WithValue<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final shouldSync = widget.shouldSync ?? ((a, b) => a != b);
    if (shouldSync(value.value, widget.value)) {
      value.value = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: value,
      builder: (_, v, __) => widget.builder(value),
    );
  }
}
