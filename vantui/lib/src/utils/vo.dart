import 'package:tuple/tuple.dart';

class NamedValue<T> extends Tuple2<String, T> {
  const NamedValue(String name, T value) : super(name, value);
  String get name => item1;
  T get value => item2;
  @override
  String toString() {
    return "$name=$value";
  }

  NamedValue<T> copyWith({String? name, T? value}) =>
      NamedValue(name ?? this.name, value ?? this.value);
}
