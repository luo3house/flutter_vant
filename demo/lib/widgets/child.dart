import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/flutter_vantui.dart';

class Child extends StatelessWidget {
  final Widget child;
  const Child(this.child, {super.key});
  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class NilChild extends Child {
  const NilChild(dynamic ignore, {super.key}) : super(nil);
}
