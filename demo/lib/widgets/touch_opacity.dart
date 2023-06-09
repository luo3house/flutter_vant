import 'package:flutter/widgets.dart';

class TouchOpacity extends StatefulWidget {
  final Widget child;
  final void Function()? onTap;

  const TouchOpacity({
    super.key,
    this.child = const SizedBox(),
    this.onTap,
  });

  @override
  createState() => _TouchOpacity();
}

class _TouchOpacity extends State<TouchOpacity> {
  var press = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: (e) => setState(() => press = true),
        onPointerUp: (e) => setState(() => press = false),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap,
          child: Opacity(
            opacity: press ? .65 : 1,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
