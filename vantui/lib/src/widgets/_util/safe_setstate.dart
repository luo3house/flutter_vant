import 'package:flutter/widgets.dart';

mixin SafeSetStateMixin<T extends StatefulWidget> on State<T> {
  bool _canSetState = false;
  @override
  void initState() {
    super.initState();
    _canSetState = true;
  }

  @override
  void dispose() {
    _canSetState = false;
    super.dispose();
  }

  @override
  setState(VoidCallback fn) {
    if (!_canSetState) return;
    super.setState(fn);
  }
}
