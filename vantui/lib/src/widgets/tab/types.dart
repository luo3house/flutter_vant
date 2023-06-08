import 'package:tuple/tuple.dart';

class NamedIndex extends Tuple2<String, int> {
  NamedIndex(super.item1, super.item2);
  String get name => item1;
  int get index => item2;
}
