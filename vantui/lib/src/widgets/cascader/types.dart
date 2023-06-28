import '../../utils/vo.dart';

abstract class INamedValueOption<T> extends INamedValue<T> {
  /// find option with expected value from list
  static T? findByValue<T extends INamedValueOption>(
      List<T> options, dynamic value) {
    return INamedValue.findByValue(options, value);
  }

  List<NamedValueOption>? get children;
  bool get disabled;

  set children(List<NamedValueOption>? children);
  set disabled(bool disabled);

  @override
  String toString() {
    return "${super.toString()},children=$children,disabled=$disabled";
  }

  @override
  bool operator ==(Object o) {
    return hashCode == o.hashCode ||
        o is INamedValueOption &&
            o.name == name &&
            o.value == value &&
            o.children == children &&
            o.disabled == disabled;
  }
}

class NamedValueOption<T> extends INamedValueOption<T> {
  @override
  String name;

  @override
  T value;

  @override
  List<NamedValueOption>? children;
  @override
  bool disabled;

  NamedValueOption(
    this.name,
    this.value, [
    this.children,
    this.disabled = false,
  ]);
}
