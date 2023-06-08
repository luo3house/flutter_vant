import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter_vantui/src/widgets/_util/widgets_group.dart';
import 'package:flutter_vantui/src/widgets/cell/_flex.dart';
import 'package:tailstyle/tailstyle.dart';

class VanCell extends StatelessWidget {
  final dynamic title;
  final dynamic value;
  final String? label;
  final dynamic icon;
  final dynamic arrow;
  final bool? center;
  final bool? clickable;
  final Function()? onTap;

  const VanCell({
    this.title,
    this.value,
    this.label,
    this.icon,
    this.arrow,
    this.center,
    this.clickable,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);
    final cellGroup = WidgetsGroup.ofn<VanCellGroup>(context);
    final flexProvider = CellFlexProvider.of(context);

    final center = this.center == true;

    const px = 16.0;
    const py = 10.0;

    final prefix = () {
      if (icon is Widget) {
        return TailBox().mr(4).Container(child: icon);
      }
      if (icon is VanIconData) {
        return TailBox().mr(4).Container(child: VanIcon(icon));
      }
      return nil;
    }();

    final title = () {
      if (this.title is Widget) return this.title as Widget;
      if (this.title == null) return nil;
      return Text(this.title.toString());
    }();

    final label = () {
      if (this.label == null) return nil;
      return TailBox().mt(theme.paddingBase).Container(
            child: TailTypo()
                .text_color(theme.textColor2)
                .text_left()
                .Text(this.label.toString()),
          );
    }();

    final value = () {
      if (this.value is Widget) return this.value;
      if (this.value == null) return nil;
      return TailTypo()
          .text_color(theme.textColor2)
          .text_right()
          .Text(this.value.toString());
    }();

    final arrow = () {
      if (this.arrow is Widget) {
        return TailBox().ml(4).Container(child: this.arrow);
      } else if (this.arrow is VanIconData) {
        return TailBox().ml(4).Container(child: VanIcon(this.arrow));
      } else {
        return nil;
      }
    }();

    final align = <bool?, CrossAxisAlignment>{
      null: CrossAxisAlignment.start,
      false: CrossAxisAlignment.start,
      true: CrossAxisAlignment.center,
    }[center]!;

    final underline = () {
      if (cellGroup?.hasNext(this) == true) {
        return TailBox().bg(theme.borderColor).Container(height: 1);
      } else {
        return nil;
      }
    }();

    final clickable = this.clickable == true;

    return DefaultTextStyle.merge(
      style: TailTypo()
          .font_size(theme.fontSizeMd)
          .line_height(20 / theme.fontSizeMd)
          .TextStyle(),
      child: GestureDetector(
        onTap: () => (clickable ? onTap : null)?.call(),
        child: Pressable(
          (pressed) {
            final bg = clickable && pressed //
                ? theme.activeColor
                : theme.background2;
            return Column(children: [
              TailBox().bg(bg).px(px).py(py).as((styled) {
                return styled.Container(
                  child: Row(crossAxisAlignment: align, children: [
                    flexProvider.flexLeft(Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [prefix, title],
                        ),
                        label
                      ],
                    )),
                    flexProvider.flexRight(LayoutBuilder(builder: (_, con) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: value,
                            ),
                          ),
                          arrow
                        ],
                      );
                    })),
                  ]),
                );
              }),
              underline,
            ]);
          },
        ),
      ),
    );
  }
}
