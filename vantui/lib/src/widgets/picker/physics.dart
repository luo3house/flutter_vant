import 'package:flutter/widgets.dart';

class SnapNearestScrollPhysics extends ScrollPhysics {
  final double itemExtent;
  const SnapNearestScrollPhysics(this.itemExtent, {super.parent});

  @override
  ScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SnapNearestScrollPhysics(itemExtent, parent: buildParent(ancestor));
  }

  double offset2index(double offset) {
    return offset / itemExtent;
  }

  double index2offset(double index) {
    return index * itemExtent;
  }

  double _getTargetPixels(
    ScrollMetrics position,
    Tolerance tolerance,
    double velocity,
  ) {
    double index = offset2index(position.pixels);
    if (velocity < -tolerance.velocity) {
      index -= 0.5;
    } else if (velocity > tolerance.velocity) {
      index += 0.5;
    }
    return index2offset(index.roundToDouble());
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    if ((velocity < 0.0) || (velocity > 0.0)) {
      return super.createBallisticSimulation(position, velocity);
    }
    final Tolerance tolerance = this.tolerance;
    final double target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels) {
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    }
    return parent?.createBallisticSimulation(position, velocity);
  }

  @override
  bool get allowImplicitScrolling => false;
}
