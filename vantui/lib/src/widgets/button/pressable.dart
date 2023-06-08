import 'package:flutter/widgets.dart';

class Pressable extends StatefulWidget {
  final PointerDownEventListener? onPointerDown;
  final PointerMoveEventListener? onPointerMove;
  final PointerUpEventListener? onPointerUp;
  final Function(bool pressed) builder;

  const Pressable(
    this.builder, {
    this.onPointerDown,
    this.onPointerMove,
    this.onPointerUp,
    super.key,
  });

  @override
  createState() => PressableState();
}

class PressableState extends State<Pressable> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) => [
        widget.onPointerDown?.call(event),
        setState(() => pressed = event.down)
      ],
      onPointerMove: (event) => {
        widget.onPointerMove?.call(event),
      },
      onPointerUp: (event) => [
        widget.onPointerUp?.call(event),
        setState(() => pressed = event.down)
      ],
      child: widget.builder(pressed),
    );
  }
}
