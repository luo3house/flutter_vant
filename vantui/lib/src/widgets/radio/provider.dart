import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/widgets/_util/value_provider.dart';

class VanRadioGroupProvider extends ValueProvider<String?> {
  static VanRadioGroupProvider? ofn(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VanRadioGroupProvider>();
  }

  const VanRadioGroupProvider({
    super.value,
    super.onChange,
    super.child,
    super.key,
  });
}
