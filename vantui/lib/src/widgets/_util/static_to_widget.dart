import 'package:flutter/widgets.dart';

import '../../utils/nil.dart';
import '../../utils/rendering.dart';

class StaticToWidget extends StatefulWidget {
  final Future Function() Function() showFn;
  final bool show;
  const StaticToWidget(this.showFn, {required this.show, super.key});

  @override
  State<StatefulWidget> createState() {
    return StaticToWidgetState();
  }
}

class StaticToWidgetState extends State<StaticToWidget> {
  Future Function()? _staticDispose;
  Function()? _rafDispose;

  _postRaf() {
    _rafDispose?.call();
    _rafDispose = raf(() {
      if (widget.show && _staticDispose == null) {
        _staticDispose = widget.showFn();
      } else {
        _staticDispose?.call().then((_) => _postRaf());
        _staticDispose = null;
      }
    });
  }

  @override
  void dispose() {
    _rafDispose?.call();
    _rafDispose = null;
    _staticDispose?.call();
    _staticDispose = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _postRaf();
    return nil;
  }
}
