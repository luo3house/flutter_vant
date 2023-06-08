import 'dart:ui';

class Touch {
  double startX = 0;
  double startY = 0;
  // last reported
  double lastX = 0;
  double lastY = 0;
  // delta since last move, i.e. moveDeltas.last
  double dx = 0;
  double dy = 0;
  // delta since start, i.e. target - start
  double distanceX = 0;
  double distanceY = 0;
  // deltas between
  List<Offset> moveDeltas = [];

  touchStart(double x, double y) {
    startX = x;
    startY = y;
    lastX = x;
    lastY = y;
    dx = 0;
    dy = 0;
    distanceX = 0;
    distanceY = 0;
    moveDeltas = [];
  }

  touchMove(double x, double y) {
    dx = x - lastX;
    dy = y - lastY;
    lastX - x;
    lastY - y;
    distanceX = x - startX;
    distanceY = y - startY;
    moveDeltas.add(Offset(dx, dy));
  }

  touchEnd(double x, double y) {
    dx = x - lastX;
    dy = y - lastY;
    lastX - x;
    lastY - y;
    distanceX = x - startX;
    distanceY = y - startY;
  }

  clear() {
    startX = 0;
    startY = 0;
    lastX = 0;
    lastY = 0;
    dx = 0;
    dy = 0;
    distanceX = 0;
    distanceY = 0;
    moveDeltas = [];
  }
}
