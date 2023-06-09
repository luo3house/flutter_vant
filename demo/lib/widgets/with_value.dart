import 'package:flutter/widgets.dart';

class WithModel<T> extends StatefulWidget {
  final T initial;
  final Widget Function(ValueNotifier<T> model) builder;

  const WithModel(
    this.initial,
    this.builder, {
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return WithValueState<T>();
  }
}

class WithValueState<T> extends State<WithModel<T>> {
  late ValueNotifier<T> value;
  @override
  void initState() {
    super.initState();
    value = ValueNotifier(widget.initial);
  }

  @override
  void dispose() {
    value.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: value,
      builder: (_, v, __) => widget.builder(value),
    );
  }
}
