import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:tuple/tuple.dart';

import 'std.dart';
import 'vo.dart';

class NestedNamedValue extends NamedValue {
  List<NestedNamedValue>? children;
  NestedNamedValue(super.item1, super.item2, [this.children]);
}

class CascadeUtil {
  CascadeUtil._();

  static final childrenFetchable = [];

  /// e.g. 1
  /// - options: [ a(a1,a2), b(b1,b2,b3) ]
  /// - values: a, a1
  /// - out: [ [a, b], [a1, a2], null ]
  /// e.g. 2
  /// - options: [ a(a1,a2), b(b1,b2,b3) ]
  /// - values: b
  /// - out: [ [a, b], [b1, b2, b3] ]
  static List<List<NestedNamedValue>?> flattenOptionsByValues(
    List<NestedNamedValue> options,
    List<dynamic> values,
  ) {
    List<NestedNamedValue>? tmp = options;
    var list = <List<NestedNamedValue>?>[tmp];
    for (var i = 0; i < values.length; i++) {
      final children = tryCatch(
        () => tmp?.firstWhere((e) => e.value == values[i]),
      )?.children;
      tmp = children;
      list.add(children);
    }
    return list;
  }

  /// e.g. 1
  /// - options: [ a(a1,a2), b(b1,b2,b3) ]
  /// - values: [ a ]
  /// - out: [ a(a1,a2) ]
  ///
  /// e.g. 2
  /// - options: [ a(a1,a2), b(b1,b2,b3) ]
  /// - values: [ a, a1 ]
  /// - out: [ a(a1,a2), a1 ]
  static List<NestedNamedValue?> matchOptionsByValues(
    List<NestedNamedValue> options,
    List<dynamic> values,
  ) {
    final flatten = flattenOptionsByValues(options, values);
    return List.generate(
      values.length,
      (index) => tryCatch<NestedNamedValue?>(
        () => flatten[index]?.firstWhere((e) => e.value == values[index]),
      ),
    );
  }

  static bool isCascadeOptions(List<NestedNamedValue> option) {
    return getMaxDepth(option) > 0;
  }

  static int getMaxDepth(List<NestedNamedValue> option, [int depth = 0]) {
    return option
        .map((e) =>
            e.children != null ? getMaxDepth(e.children!, depth + 1) : depth)
        .reduce((pre, cur) => pre > cur ? pre : cur);
  }
}

abstract class CascadeDataSource extends ChangeNotifier {
  int depthLen();
  List<NestedNamedValue> optionsAt(int depth, List<dynamic> values);

  static final zero = CascadeDataSourceDelegate(
    (_) => 0,
    (depth, values, _) => [],
  );

  static fromFlatOptions(List<List<NestedNamedValue>> optionsCols) {
    return CascadeDataSourceDelegate(
      (_) => optionsCols.length,
      (depth, _, __) => optionsCols[depth],
    );
  }

  static fromNestedOptions(List<NestedNamedValue> nestedOptions) {
    final depthLen = CascadeUtil.getMaxDepth(nestedOptions);
    return CascadeDataSourceDelegate(
      (_) => depthLen,
      (depth, values, _) {
        values = List.generate(depth, (index) => null)..setAll(0, values);
        var options = nestedOptions;
        NestedNamedValue? option;
        while (values.isNotEmpty) {
          if (depth == 0) break;
          final value = values.removeAt(0);
          option = tryCatch(
            () => options.firstWhere((e) => e.value == value),
          );
          options = option?.children ?? [];
          depth--;
        }
        return options;
      },
    );
  }

  static fromFetchableOptions(
    List<NestedNamedValue> nestedOptions,
    Future<List<NestedNamedValue>> Function(
      NestedNamedValue option,
      List values,
    )
        fetch,
  ) {
    assert(nestedOptions != CascadeUtil.childrenFetchable);
    final fillOptions = List.of(nestedOptions);
    var depthLen = CascadeUtil.getMaxDepth(nestedOptions);
    return CascadeDataSourceDelegate(
      (_) => depthLen,
      (depth, values, this_) {
        values = List.generate(depth, (index) => null)..setAll(0, values);
        var options = fillOptions;
        NestedNamedValue? option;
        while (values.isNotEmpty) {
          if (depth == 0) break;
          final value = values.removeAt(0);
          option = tryCatch(
            () => options.firstWhere((e) => e.value == value),
          );
          options = option?.children ?? [];
          depth--;
        }
        if (option != null && options == CascadeUtil.childrenFetchable) {
          fetch(option, values).then((options) {
            option!.children = options;
            this_.notifyListeners();
          });
        }
        return options;
      },
    );
  }
}

class CascadeDataSourceDelegate extends Tuple2<
        int Function(CascadeDataSource this_),
        List<NestedNamedValue> Function(
            int depth, List<dynamic> values, CascadeDataSource this_)>
    with ChangeNotifier
    implements CascadeDataSource {
  CascadeDataSourceDelegate(super.item1, super.item2);

  @override
  int depthLen() => item1.call(this);
  @override
  List<NestedNamedValue> optionsAt(int depth, List<dynamic> values) =>
      item2.call(depth, values, this);
}
