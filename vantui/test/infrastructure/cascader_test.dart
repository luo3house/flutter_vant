import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_vantui/src/widgets/cascader/index.dart';

void main() {
  test("getFlatOptionsByValues basic", () {
    final options = [
      NestedNamedValue("a", "a", [
        NestedNamedValue("a.1", "a.1"),
        NestedNamedValue("a.2", "a.2"),
      ]),
      NestedNamedValue("b", "b", [
        NestedNamedValue("b.1", "b.1"),
        NestedNamedValue("b.2", "b.2"),
        NestedNamedValue("b.3", "b.3"),
      ]),
    ];
    final flatOptions =
        VanCascader.flattenOptionsByValues(options, ["a", "a.1"]);
    // [listOf(a,b), listOf(a.1, a.2), listOf()]
    expect(flatOptions.length, 3);
    expect(flatOptions[0], options);
    expect(flatOptions[1], options[0].children);
    expect(flatOptions[2], null);
  });

  test("getFlatOptionsByValues basic2", () {
    final options = [
      NestedNamedValue("a", "a", [
        NestedNamedValue("a.1", "a.1"),
        NestedNamedValue("a.2", "a.2"),
      ]),
      NestedNamedValue("b", "b", [
        NestedNamedValue("b.1", "b.1"),
        NestedNamedValue("b.2", "b.2"),
        NestedNamedValue("b.3", "b.3"),
      ]),
    ];
    final flatOptions = VanCascader.flattenOptionsByValues(options, ["b"]);
    // [listOf(a,b), listOf(b.1, b.2, b.3)]
    expect(flatOptions.length, 2);
    expect(flatOptions[0], options);
    expect(flatOptions[1], options[1].children);
  });
}
