import '../../utils/vo.dart';

enum TimePickerColumn { hour, minute, second }

typedef OptionFilter = List<NamedValue> Function(List<NamedValue> options);
