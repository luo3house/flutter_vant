import 'package:flutter/widgets.dart';

enum PopupPosition { top, bottom, left, right, center }

class NullableSize {
  static const zero = NullableSize(0, 0);
  static NullableSize onlyWidth(double width) => NullableSize(width, null);
  static NullableSize onlyHeight(double height) => NullableSize(null, height);

  final double? width;
  final double? height;
  const NullableSize(this.width, this.height);
}

typedef PopupDisposeFn = Future<dynamic> Function();

typedef BoxConstraintsGetter = BoxConstraints Function(BoxConstraints con);
