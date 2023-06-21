import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/widgets/config/index.dart';
import 'package:tailstyle/tailstyle.dart';

class VanSwitch extends StatelessWidget {
  final bool? value;
  final double? size;
  final bool? disabled;
  final Function(bool v)? onChange;
  final Color? bgOffColor;
  final Color? bgOnColor;
  final Widget Function(bool v)? drawThumb;

  const VanSwitch({
    this.value,
    this.size,
    this.disabled,
    this.onChange,
    this.bgOffColor,
    this.bgOnColor,
    this.drawThumb,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);
    final value = this.value ?? false;
    final disabled = this.disabled ?? false;
    final size = this.size ?? 26.0;
    final bgOffColor = this.bgOffColor ?? const Color(0x29787880);
    final bgOnColor = this.bgOnColor ?? theme.primaryColor;

    const p = 2.0;
    final width = size * 1.8 + p + p;
    final height = size * 1 + p + p;

    final rounded = size;

    final thumbSize = size;
    final thumbBg = theme.white;
    final thumbLeft = value == true ? width - thumbSize - p : p;

    const thumbShadow = BoxShadow(
      offset: Offset(0, 3),
      blurRadius: 1,
      color: Color.fromRGBO(0, 0, 0, 0.05),
    );

    final pit = TweenAnimationBuilder(
      tween: value == true
          ? Tween(begin: 1.0, end: 1.0)
          : Tween(begin: 0.0, end: 0.0),
      duration: theme.durationBase,
      builder: (_, x, __) => TailBox()
          .bg(Color.lerp(bgOffColor, bgOnColor, x))
          .rounded(rounded)
          .Container(width: width, height: height),
    );

    final thumbIconTheme =
        IconTheme.of(context).copyWith(color: value ? bgOnColor : bgOffColor);

    final thumbTextStyle =
        TailTypo().text_color(value ? bgOnColor : bgOffColor).TextStyle();

    final thumb = TweenAnimationBuilder(
      tween: Tween(begin: thumbLeft, end: thumbLeft),
      duration: theme.durationBase,
      builder: (_, x, child) => Transform.translate(
        offset: Offset(x, 0),
        child: child,
      ),
      curve: const Cubic(.3, 1.05, .4, 1.05),
      child: DefaultTextStyle.merge(
        style: thumbTextStyle,
        child: IconTheme.merge(
          data: thumbIconTheme,
          child: TailBox()
              .shadow(const [thumbShadow])
              .rounded(rounded)
              .bg(thumbBg)
              .Container(
                width: thumbSize,
                height: thumbSize,
                clipBehavior: Clip.hardEdge,
                child: drawThumb?.call(value),
              ),
        ),
      ),
    );

    return SizedBox(
      width: width,
      height: height,
      child: GestureDetector(
        onTap: () => (disabled ? null : onChange)?.call(!value),
        child: Opacity(
          opacity: disabled ? theme.disabledOpacity : 1,
          child: Stack(alignment: Alignment.centerLeft, children: [pit, thumb]),
        ),
      ),
    );
  }
}
