import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// short for ValueListenableBuilder
class WatchModel<T extends ValueListenable> extends StatelessWidget {
  final T listenable;
  final Widget Function(T) builder;
  const WatchModel(this.listenable, this.builder, {super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: listenable,
      builder: (_, __, ___) => builder(listenable),
    );
  }
}
