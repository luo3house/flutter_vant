import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// HasNextWidget indicate the child that there is something behind it
class HasNextWidget extends SingleChildRenderObjectWidget {
  final bool hasNext;
  const HasNextWidget({
    super.key,
    super.child,
    this.hasNext = true,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return hasNext ? HasNextRenderBox() : RenderProxyBox();
  }
}

class HasNextRenderBox extends RenderProxyBox {}
