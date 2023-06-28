import '../../utils/vo.dart';

enum TimePickerColumn { hour, minute, second }

typedef OptionFilter = List<INamedValue> Function(List<INamedValue> options);
