class ListUtil {
  ListUtil._();

  static bool eq<T>(List<T> a1, List<T> a2, bool Function(T a, T b) test) {
    if (a1.length != a2.length) return false;
    for (var i = 0; i < a1.length; i++) {
      if (!test(a1.elementAt(i), a2.elementAt(i))) {
        return false;
      }
    }
    return true;
  }

  static bool shallowEq(List a1, List a2) {
    return eq(a1, a2, (a, b) => a == b);
  }
}

extension ListUtilExt on List {
  bool isFirst(dynamic cell) {
    final index = indexOf(cell);
    return index == 0;
  }

  bool isLast(dynamic cell) {
    final index = indexOf(cell);
    return index != -1 && index + 1 == length;
  }

  bool hasNext(dynamic cell) {
    final index = indexOf(cell);
    return index != -1 && index + 1 < length;
  }
}
