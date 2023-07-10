import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/widgets/config/index.dart';
import 'package:tailstyle/tailstyle.dart';

// @DocsId("switch")

class Switch extends StatelessWidget {
  // @DocsProp("value", "bool", "当前选中")
  final bool? value;
  // @DocsProp("size", "double", "大小")
  final double? size;
  // @DocsProp("disabled", "bool", "禁用状态")
  final bool? disabled;
  // @DocsProp("onChange", "Function(bool)", "选中变化触发")
  final Function(bool v)? onChange;
  // @DocsProp("bgOffColor", "Color", "关闭时背景颜色")
  final Color? bgOffColor;
  // @DocsProp("bgOnColor", "Color", "打开时背景颜色")
  final Color? bgOnColor;
  // @DocsProp("drawThumb", "Widget Function(bool)", "绘制滑块")
  final Widget Function(bool v)? drawThumb;

  const Switch({
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
