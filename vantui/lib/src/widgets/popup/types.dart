enum VanPopupPosition { top, bottom, left, right, center }

class NullableSize {
  static const zero = NullableSize(0, 0);
  static NullableSize onlyWidth(double width) => NullableSize(width, null);
  static NullableSize onlyHeight(double height) => NullableSize(null, height);

  final double? width;
  final double? height;
  const NullableSize(this.width, this.height);
}
