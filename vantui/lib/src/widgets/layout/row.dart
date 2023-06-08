import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/widgets/_util/widgets_group.dart';
import 'package:flutter_vantui/src/widgets/layout/col.dart';
import 'package:tailstyle/tailstyle.dart';

enum VanJustify { start, end, center, spaceAround, spaceBetween }

enum VanAlign { top, center, bottom }

class VanRow extends StatelessWidget {
  final List<Widget> children;
  final VanJustify? justify;
  final VanAlign? align;
  final double? gutter;
  final bool? wrap;

  const VanRow({
    required this.children,
    this.justify,
    this.align,
    this.gutter,
    this.wrap,
    super.key,
  });

  Iterable<Widget> mapChildren(double width) {
    offset(int value) => width * value / 24.0;
    span(int value) => width * value / 24.0;
    final gutter = this.gutter ?? 0;

    return children.map((child) {
      if (child is VanCol) {
        return Builder(builder: (context) {
          final group = WidgetsGroup.ofn<VanCol>(context);
          final pr = group?.isFirst(child) == true ? gutter : gutter / 2;
          final pl = group?.isLast(child) == true ? gutter : gutter / 2;
          final ml = offset(child.offset ?? 0);
          return TailBox().pl(pl).pr(pr).ml(ml).as((styled) {
            if (child.span == null) {
              return styled.Container(child: OverflowBox(child: child));
            } else {
              return styled.Container(width: span(child.span!), child: child);
            }
          });
        });
      } else {
        return child;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WidgetsGroup<Column>(
      children: children,
      builder: (children) {
        return LayoutBuilder(builder: (_, con) {
          final maxWidth = con.maxWidth;
          if (wrap == true) {
            final align = <VanAlign?, WrapCrossAlignment>{
              null: WrapCrossAlignment.start,
              VanAlign.top: WrapCrossAlignment.start,
              VanAlign.center: WrapCrossAlignment.center,
              VanAlign.bottom: WrapCrossAlignment.end,
            }[this.align]!;
            return Wrap(
              crossAxisAlignment: align,
              children: mapChildren(maxWidth).toList(growable: false),
            );
          } else {
            final justify = <VanJustify?, MainAxisAlignment>{
              null: MainAxisAlignment.start,
              VanJustify.start: MainAxisAlignment.start,
              VanJustify.center: MainAxisAlignment.center,
              VanJustify.end: MainAxisAlignment.end,
              VanJustify.spaceAround: MainAxisAlignment.spaceAround,
              VanJustify.spaceBetween: MainAxisAlignment.spaceBetween,
            }[this.justify]!;
            final align = <VanAlign?, CrossAxisAlignment>{
              null: CrossAxisAlignment.start,
              VanAlign.top: CrossAxisAlignment.start,
              VanAlign.center: CrossAxisAlignment.center,
              VanAlign.bottom: CrossAxisAlignment.end,
            }[this.align]!;
            return Row(
              mainAxisAlignment: justify,
              crossAxisAlignment: align,
              children: mapChildren(maxWidth).toList(growable: false),
            );
          }
        });
      },
    );
  }
}
