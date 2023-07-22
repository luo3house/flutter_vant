import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Request a callback After Frame
Function() raf(Function() cb) {
  var flag = true;
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    if (flag) cb();
  });
  return () => flag = false;
}

/// Get child offset from sliver list
double? getChildOffsetInSliverList(
  BuildContext sliverContext,
  BuildContext childContext,
) {
  assert(sliverContext is SliverMultiBoxAdaptorElement);

  AbstractNode? childRO = childContext.findRenderObject();
  while (childRO != null) {
    if (childRO is RenderIndexedSemantics) break;
    childRO = childRO.parent;
  }
  assert(childRO is RenderIndexedSemantics, "seems child is not a list item");

  final sliverRO = (sliverContext as SliverMultiBoxAdaptorElement).renderObject;
  return sliverRO.childScrollOffset(childRO as RenderIndexedSemantics);
}

bool isLastChild(BuildContext context) {
  final ro = context.findRenderObject();
  final childrenRO =
      AbstractNodeUtil.findParent<ContainerRenderObjectMixin>(ro);
  final childRO = AbstractNodeUtil.findParentBefore(ro, childrenRO);
  return childrenRO?.lastChild == childRO;
}

class AbstractNodeUtil {
  AbstractNodeUtil._();

  /// A > B > C > here, T = A, result = A
  /// A > B > C > here, T = D, result = null
  static T? findParent<T extends AbstractNode>(AbstractNode? here) {
    AbstractNode? parent = here?.parent;
    while (parent != null) {
      if (parent is T) break;
      parent = parent.parent;
    }
    return parent as T?;
  }

  /// A > B > C > here, expect = A, result = B
  /// A > B > C > here, expect = C, result = ro
  static AbstractNode? findParentBefore(
      AbstractNode? here, AbstractNode? expect) {
    AbstractNode? parent = here;
    while (parent != null) {
      if (parent.parent == expect) break;
      parent = parent.parent;
    }
    return parent;
  }
}

class ExtentListUtil {
  ExtentListUtil._();

  static Map<T, double> extents2offsets<T>(Map<T, double> extentsOfT) {
    var offset = 0.0;
    final offsetsOfT = <T, double>{};
    for (final e in extentsOfT.entries) {
      offsetsOfT[e.key] = offset;
      offset += e.value;
    }
    return offsetsOfT;
  }

  static T? offset2containingT<T>(
      SplayTreeMap<double, T> offsetsOfT, double offset,
      {int? startAt}) {
    assert(startAt == null || startAt < offsetsOfT.length);
    var offsetReached = 0.0;
    for (var i = startAt ?? 0; i < offsetsOfT.length; i++) {
      final offsetExpect = offsetsOfT.keys.elementAt(i);
      if (offset < offsetExpect) break;
      offsetReached = offsetExpect;
    }
    return offsetsOfT[offsetReached];
  }
}
