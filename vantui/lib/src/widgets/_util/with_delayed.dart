import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../utils/nil.dart';
import '../../utils/rendering.dart';

class WithDelayed extends StatefulWidget {
  final BoxConstraints? constraints;
  final Widget Function() builder;

  const WithDelayed(
    this.builder, {
    this.constraints,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return WithDelayedState();
  }
}

class WithDelayedState extends State<WithDelayed> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    raf(() => {if (mounted) setState(() => show = true)});
    return LayoutBuilder(builder: (_, con) {
      return ConstrainedBox(
        constraints: widget.constraints ?? con,
        child: show ? widget.builder.call() : nil,
      );
    });
  }
}
