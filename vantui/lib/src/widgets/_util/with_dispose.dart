import 'package:flutter/widgets.dart';

class WithDispose extends StatefulWidget {
  final Function() onDispose;
  final Widget child;
  const WithDispose(
    this.onDispose, {
    required this.child,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return WithDisposeState();
  }
}

class WithDisposeState extends State<WithDispose> {
  @override
  void dispose() {
    widget.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
