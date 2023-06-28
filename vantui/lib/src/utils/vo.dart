abstract class INamedValue<T> {
  static T? findByValue<T extends INamedValue>(List<T> options, dynamic value) {
    final matches = options.where((e) => e.value == value);
    return matches.isNotEmpty ? matches.first : null;
  }

  String get name;
  T get value;

  set name(String n);

  @override
  String toString() {
    return "name=$name,value=$value";
  }

  @override
  bool operator ==(Object o) {
    return o.hashCode == hashCode ||
        o is INamedValue && o.name == name && o.value == value;
  }
}

class NamedValue<T> extends INamedValue<T> {
  @override
  String name;
  @override
  final T value;

  NamedValue(this.name, this.value);
}
