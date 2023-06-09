import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tailstyle/tailstyle.dart';

import '../../utils/nil.dart';
import '../../utils/rendering.dart';
import '../config/index.dart';

class VanBadge extends StatefulWidget {
  final dynamic content;
  final int? max;
  final bool? showZero;
  final Color? color;
  final bool? dot;
  final Widget? child;
  final double? dx;
  final double? dy;

  const VanBadge({
    this.content,
    this.max,
    this.showZero,
    this.color,
    this.dot,
    this.child,
    this.dx,
    this.dy,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return VanBadgeState();
  }
}

class VanBadgeState extends State<VanBadge> {
  Size? size;

  double get w => size?.width ?? 0;
  double get h => size?.height ?? 0;

  @override
  Widget build(BuildContext context) {
    final badge = Builder(builder: (context) {
      raf(() {
        if (mounted) {
          final badgeSize = context.size;
          if (badgeSize != size) setState(() => size = badgeSize);
        }
      });
      return BadgeBody(
        content: widget.content,
        max: widget.max,
        showZero: widget.showZero,
        color: widget.color,
        dot: widget.dot,
      );
    });

    return Stack(clipBehavior: Clip.none, fit: StackFit.loose, children: [
      widget.child ?? nil,
      Positioned(
        right: 0,
        top: 0,
        child: Transform.translate(
          offset: Offset(w / 2, -h / 2) //
              .translate(widget.dx ?? 0, widget.dy ?? 0),
          child: Offstage(offstage: size == null, child: badge),
        ),
      ),
    ]);
  }
}

class BadgeBody extends StatelessWidget {
  final dynamic content;
  final int? max;
  final bool? showZero;
  final Color? color;
  final bool? dot;

  const BadgeBody({
    this.content,
    this.max,
    this.showZero,
    this.color,
    this.dot,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    final showZero = this.showZero ?? false;
    final dot = this.dot ?? false;

    final rounded = theme.radiusMax;
    final bg = color ?? theme.dangerColor;

    final textStyle = TailTypo()
        .text_color(theme.white)
        .font_size(theme.fontSizeSm)
        .TextStyle();

    final iconTheme = IconThemeData(size: 10, color: theme.white);

    final px = dot ? 0.0 : 3.0;
    final width = dot ? 8.0 : null;
    final height = <dynamic, double>{
      'dot': 8,
      true: 16,
    }[dot ? 'dot' : content is IconData];

    final child = () {
      if (dot) {
        return nil;
      } else if (content == 0 && !showZero) {
        return nil;
      } else if (content is Widget) {
        return content as Widget;
      } else if (content is num && max != null && content > max!) {
        return Text("$max+");
      } else if (content is IconData) {
        return Icon(content as IconData);
      } else {
        return Text("$content");
      }
    }();

    return DefaultTextStyle(
      style: textStyle,
      child: IconTheme(
        data: iconTheme,
        child: TailBox()
            .bg(bg)
            .px(px)
            .rounded(rounded)
            .Container(width: width, height: height, child: child),
      ),
    );
  }
}
