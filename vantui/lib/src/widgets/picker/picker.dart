import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/utils/list_util.dart';
import 'package:flutter_vantui/src/widgets/_util/event_insensitive_box_decoration.dart';
import 'package:flutter_vantui/src/widgets/picker/extent.dart';
import 'package:tailstyle/tailstyle.dart';

import '../../utils/std.dart';
import '../../utils/vo.dart';
import '../config/index.dart';
import 'column.dart';

class VanPicker extends StatefulWidget {
  final List<List<NamedValue>> columns;
  final List? values;
  final Function(List values, int colIndex)? onChange;
  final bool? loop;

  VanPicker({
    required this.columns,
    this.values,
    this.onChange,
    this.loop,
    super.key,
  }) {
    assert(columns.isNotEmpty, "shoud have at least 1 column");
  }

  @override
  State<StatefulWidget> createState() {
    return VanPickerState();
  }
}

class VanPickerState extends State<VanPicker> {
  var keys = <GlobalKey<PickerColumnState>>[];
  var values = <dynamic>[];

  List<List<NamedValue>> get columns => widget.columns;
  bool get loop => widget.loop == true;

  handleColumnChange(int colIndex, NamedValue selected) {
    final newValues = List<dynamic>.generate(columns.length, (_) => null)
      // ..setAll(0, values.sublist(0, colIndex + 1))
      ..setAll(0, values)
      ..setAll(colIndex, [selected.value]);
    values = newValues;
    setState(() {});
    widget.onChange?.call(values, colIndex);
  }

  @override
  void initState() {
    super.initState();
    keys = List.generate(columns.length, (_) => GlobalKey());
    values = widget.values ?? [];
  }

  @override
  void didUpdateWidget(covariant VanPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (columns.length != oldWidget.columns.length) {
      keys = List.generate(columns.length, (_) => GlobalKey());
    }
    if (!ListUtil.shallowEq(values, widget.values ?? [])) {
      values = [...?widget.values];
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);
    const extent = PickerExtent();

    final columns = this.columns;
    // final values = List<dynamic>.generate(columns.length, (colIndex) {
    //   var value = tryCatch(() => this.values.elementAt(colIndex));
    //   value ??= tryCatch(() => columns.elementAt(colIndex).first.value);
    //   return value;
    // });

    final colChildren = List.generate(columns.length, (colIndex) {
      return PickerColumn(
        key: keys[colIndex],
        extent: extent,
        items: columns[colIndex],
        loop: loop,
        value: tryCatch(() => values[colIndex]),
        onChange: (selected) => handleColumnChange(colIndex, selected),
      );
    });

    return Stack(alignment: Alignment.center, children: [
      Positioned.fill(child: TailBox().bg(theme.background2).Container()),
      Row(
        children: List.of(colChildren.map((child) {
          return Expanded(child: child);
        })),
      ),
      const PositionedGradientMask(extent: extent),
      const PositionedHairline(extent: extent),
    ]);
  }
}

class PositionedHairline extends StatelessWidget {
  final PickerExtent extent;

  const PositionedHairline({
    required this.extent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    return Positioned.fill(
      left: theme.paddingMd,
      right: theme.paddingMd,
      top: null,
      bottom: null,
      child: TailBox().border_t(theme.gray3).border_b(theme.gray3).as((s) {
        return Container(
          height: extent.getItemHeight(),
          decoration: EventInsensitiveBoxDecoration.from(s.BoxDecoration()),
        );
      }),
    );
  }
}

class PositionedGradientMask extends StatelessWidget {
  final PickerExtent extent;
  const PositionedGradientMask({
    required this.extent,
    super.key,
  });

  static const graident = [
    Color.fromRGBO(255, 255, 255, .9),
    Color.fromRGBO(255, 255, 255, .4),
  ];

  @override
  Widget build(BuildContext context) {
    final height = extent.getItemHeight();
    return Positioned.fill(
      child: Column(children: [
        Expanded(
          child: TailBox().bg_gradient_to_b(graident).as((s) {
            return Container(
              decoration: EventInsensitiveBoxDecoration.from(s.BoxDecoration()),
            );
          }),
        ),
        SizedBox(height: height),
        Expanded(
          child: TailBox().bg_gradient_to_t(graident).as((s) {
            return Container(
              decoration: EventInsensitiveBoxDecoration.from(s.BoxDecoration()),
            );
          }),
        ),
      ]),
    );
  }
}
