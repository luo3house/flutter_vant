import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/widgets/config/index.dart';
import 'package:flutter_vantui/src/widgets/icon/index.dart';
import 'package:tailstyle/tailstyle.dart';

typedef InputByChecked = Widget Function(bool checked);

class CheckboxInput extends StatelessWidget {
  static const size = 20.0;

  final bool disabled;
  final bool checked;
  final BoxShape shape;
  final Color? checkedColor;
  final dynamic icon;

  const CheckboxInput({
    required this.disabled,
    required this.checked,
    required this.shape,
    this.checkedColor,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (this.icon is InputByChecked) {
      return SizedBox(
        width: size,
        height: size,
        child: (this.icon as InputByChecked).call(checked),
      );
    }

    final theme = VanConfig.ofTheme(context);
    final checkedColor = this.checkedColor ?? theme.primaryColor;
    final rounded = shape == BoxShape.circle ? size / 2 : 0.0;

    final bgOn = checkedColor;
    final bgOff = bgOn.withAlpha(0);

    final borderColorOn = checkedColor;
    final borderColorOff = theme.gray5;

    final colorOn = theme.white;
    final colorOff = theme.white.withAlpha(0);

    final colorDisabledOn = theme.gray5;
    final colorDisabledOff = colorDisabledOn.withAlpha(0);

    final icon = () {
      final icon = this.icon;
      if (icon is Widget) {
        return icon;
      } else if (icon is IconData) {
        return Icon(icon);
      } else {
        return const VanIcon(VanIcons.success);
      }
    }();

    final box = TailBox().rounded(rounded);

    if (disabled) {
      return box.bg(theme.borderColor).border(theme.gray5).as((styled) {
        return styled.Container(
          width: size,
          height: size,
          child: IconTheme(
            data: IconTheme.of(context).copyWith(
              color: checked ? colorDisabledOn : colorDisabledOff,
            ),
            child: icon,
          ),
        );
      });
    } else {
      return TweenAnimationBuilder(
        tween: checked //
            ? Tween(begin: 1.0, end: 1.0)
            : Tween(begin: 0.0, end: 0.0),
        duration: theme.durationFast,
        builder: (_, x, __) {
          return box
              .bg(Color.lerp(bgOff, bgOn, x))
              .border(Color.lerp(borderColorOff, borderColorOn, x))
              .as((styled) {
            return styled.Container(
              width: size,
              height: size,
              child: IconTheme(
                data: IconTheme.of(context).copyWith(
                  color: Color.lerp(colorOff, colorOn, x),
                ),
                child: icon,
              ),
            );
          });
        },
      );
    }
  }
}
