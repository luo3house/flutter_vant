import 'package:flutter/widgets.dart';

class WithValue<T> extends StatefulWidget {
  final T value;
  final Widget Function(ValueNotifier<T> model) builder;

  const WithValue(
    this.value,
    this.builder, {
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return WithModelState<T>();
  }
}

class WithModelState<T> extends State<WithValue<T>> {
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
    value.value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: value,
      builder: (_, v, __) => widget.builder(value),
    );
  }
}
