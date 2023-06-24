import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Hidden extends SingleChildRenderObjectWidget {
  final bool hidden;
  const Hidden({
    this.hidden = true,
    super.child,
    super.key,
  });

  @override
  RenderHidden createRenderObject(BuildContext context) {
    return RenderHidden(hidden: hidden);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderHidden renderObject) {
    renderObject.hidden = hidden;
  }
}

class RenderHidden extends RenderProxyBox {
  bool hidden;
  RenderHidden({required this.hidden});

  @override
  bool paintsChild(covariant RenderBox child) {
    super.paintsChild(child);
    return true;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) {
      return;
    }
    final alpha = Color.getAlphaFromOpacity(hidden ? 0 : 1);
    layer = context.pushOpacity(offset, alpha, super.paint,
        oldLayer: layer as OpacityLayer?);
    assert(() {
      layer!.debugCreator = debugCreator;
      return true;
    }());
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty("hidden", value: hidden));
  }
}
