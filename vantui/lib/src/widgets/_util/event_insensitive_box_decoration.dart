import 'package:flutter/painting.dart';

class EventInsensitiveBoxDecoration extends BoxDecoration {
  static EventInsensitiveBoxDecoration from(BoxDecoration src) {
    return EventInsensitiveBoxDecoration(
      color: src.color,
      image: src.image,
      border: src.border,
      borderRadius: src.borderRadius,
      boxShadow: src.boxShadow,
      gradient: src.gradient,
      backgroundBlendMode: src.backgroundBlendMode,
      shape: src.shape,
    );
  }

  const EventInsensitiveBoxDecoration({
    super.color,
    super.image,
    super.border,
    super.borderRadius,
    super.boxShadow,
    super.gradient,
    super.backgroundBlendMode,
    super.shape,
  });

  @override
  bool hitTest(Size size, Offset position, {TextDirection? textDirection}) {
    return false;
  }
}
