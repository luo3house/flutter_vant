import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import '../_util/has_next_widget.dart';
import '_flex.dart';
import 'package:tailstyle/tailstyle.dart';

class VanCell extends StatefulWidget {
  final dynamic title;
  final dynamic value;
  final String? label;
  final dynamic icon;
  final dynamic arrow;
  final bool? center;
  final Widget? prefix;
  final bool? clickable;
  final Function()? onTap;

  const VanCell({
    this.title,
    this.value,
    this.label,
    this.icon,
    this.arrow,
    this.prefix,
    this.center,
    this.clickable,
    this.onTap,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return VanCellState();
  }
}

class VanCellState extends State<VanCell> {
  bool hasNext = false;

  bool get center => widget.center == true;
  dynamic get icon => widget.icon;
  dynamic get title => widget.title;
  String? get label => widget.label;
  dynamic get value => widget.value;
  dynamic get arrow => widget.arrow;
  bool get clickable => widget.clickable == true;
  Function()? get onTap => widget.onTap;

  @override
  void initState() {
    super.initState();
    raf(() {
      tryCatch(() {
        if (mounted) {
          setState(() {
            hasNext = AbstractNodeUtil.findParent<HasNextRenderBox>(
                    context.findRenderObject()) !=
                null;
          });
        }
      });
    });
  }

  Widget probeIcon(dynamic icon) {
    if (icon is Widget) {
      return TailBox().mr(4).Container(child: icon);
    }
    if (icon is IconData) {
      return TailBox().mr(4).Container(child: Icon(icon));
    }
    return nil;
  }

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);
    final flexProvider = CellFlexProvider.of(context);

    final underline = () {
      if (hasNext) {
        return Container(color: theme.borderColor, height: 1);
      } else {
        return nil;
      }
    }();

    const px = 16.0;
    const py = 10.0;

    final prefix = probeIcon(widget.prefix);

    final icon = probeIcon(widget.icon);

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
                .font_size(theme.fontSizeSm)
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
      var arrow = this.arrow;
      if (arrow == true) arrow = VanIcons.arrow;
      if (arrow is Widget) {
        return TailBox().ml(4).Container(child: arrow);
      } else if (arrow is IconData) {
        return TailBox().ml(4).Container(child: Icon(arrow));
      } else {
        return nil;
      }
    }();

    final align = <bool?, CrossAxisAlignment>{
      null: CrossAxisAlignment.start,
      false: CrossAxisAlignment.start,
      true: CrossAxisAlignment.center,
    }[center]!;

    final left = flexProvider.flexLeft(Row(
      children: [
        prefix,
        SizedBox(width: prefix == nil ? 0 : px / 2),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [icon, title],
            ),
            label,
          ],
        )
      ],
    ));

    final right = () {
      if (widget.value == null && widget.arrow == null) {
        return nil;
      } else {
        return flexProvider.flexRight(LayoutBuilder(builder: (_, con) {
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
        }));
      }
    }();

    return DefaultTextStyle.merge(
      style: TailTypo().font_size(theme.fontSizeMd).TextStyle(),
      child: GestureDetector(
        onTap: () => (clickable ? onTap : null)?.call(),
        child: Pressable(
          (pressed) {
            final bg = clickable && pressed //
                ? theme.activeColor
                : theme.background2;
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                TailBox().bg(bg).px(px).py(py).Container(
                      child: Row(
                        crossAxisAlignment: align,
                        children: [left, right],
                      ),
                    ),
                Positioned(
                  bottom: 0,
                  left: theme.paddingMd,
                  right: theme.paddingMd,
                  child: underline,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
