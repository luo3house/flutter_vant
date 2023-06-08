import 'package:flutter/widgets.dart';

class VanMask extends StatelessWidget {
  final Color? bg;
  final Function()? onTap;
  const VanMask({
    this.bg,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: MaskBody(bg: bg, onTap: onTap),
    );
  }
}

class MaskBody extends StatelessWidget {
  final Color? bg;
  final Function()? onTap;
  const MaskBody({
    this.bg,
    this.onTap,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final bg = this.bg ?? const Color(0xB3000000);
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Container(color: bg),
    );
  }
}
