import 'package:tuple/tuple.dart';

class GridUtil {
  GridUtil._();

  static GutterResult gutter(double dim, int len, double gap) {
    // final itemDim = ((dim - gap) / len) - gap;
    final itemDim = (dim - gap * (len - 1)) / len;
    return GutterResult(itemDim, gap);
  }
}

// [Item1 Dim] - L[Item2 Dim] - L[ItemN Dim]
class GutterResult extends Tuple2<double, double> {
  const GutterResult(double itemDim, double subsequentLeft)
      : super(itemDim, subsequentLeft);

  double get itemDim => item1;
  double get subsequentLeft => item2;
}
