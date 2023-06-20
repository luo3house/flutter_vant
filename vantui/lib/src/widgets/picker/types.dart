import '../../utils/vo.dart';

class PickerOption extends NamedValue {
  static PickerOption fromNamedValue(NamedValue o) =>
      PickerOption(o.name, o.value);

  static PickerOption? findByValue(List<PickerOption> options, dynamic value) {
    final matches = options.where((e) => e.value == value);
    return matches.isNotEmpty ? matches.first : null;
  }

  final List<PickerOption>? children;
  final bool? disabled;

  const PickerOption(String name, dynamic value, [this.children, this.disabled])
      : super(name, value);

  bool get isDisabled => disabled == true;
}
