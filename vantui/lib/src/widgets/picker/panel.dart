import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/widgets/_util/event_insensitive_box_decoration.dart';
import 'package:flutter_vantui/src/widgets/picker/extent.dart';
import 'package:tailstyle/tailstyle.dart';
import 'package:tuple/tuple.dart';

import '../../utils/std.dart';
import '../../utils/vo.dart';
import '../config/index.dart';
import 'column.dart';
import 'types.dart';

typedef GeneralColumns = List<List<PickerOption>>;
typedef NamedValueColumns = List<List<NamedValue>>;
typedef CascadeColumns = List<PickerOption>;

class PickerPanel extends StatefulWidget {
  final dynamic columns;
  final List? values;
  final Function(List values)? onChange;
  final bool? loop;

  PickerPanel({
    required this.columns,
    this.values,
    this.onChange,
    this.loop,
    super.key,
  }) {
    assert(
        columns is GeneralColumns ||
            columns is CascadeColumns ||
            columns is NamedValueColumns,
        "columns should be subtype of PickerOption[][], or PickerOption[] for cascading");
  }

  @override
  State<StatefulWidget> createState() {
    return PickerPanelState();
  }
}

class PickerPanelState extends State<PickerPanel> {
  static Tuple2<List<List<PickerOption>>, List> normalizeCascade(
      List<PickerOption>? hierColumns, List? values) {
    final normalizeValues = [];
    final normalizeColumns = <List<PickerOption>>[];
    int valueIndex = 0;
    while (hierColumns != null) {
      if (hierColumns.isEmpty) break;
      normalizeColumns.add(hierColumns);
      final value = tryCatch(() => values?[valueIndex]);
      final match = PickerOption.findByValue(hierColumns, value) ?? //
          hierColumns.first;
      hierColumns = match.children ?? [];
      normalizeValues.add(match.value);
      valueIndex++;
    }
    return Tuple2(normalizeColumns, normalizeValues);
  }

  // values & columns here should be normalized
  var values = <dynamic>[];
  var columns = <List<PickerOption>>[];
  late final List<GlobalKey<PickerColumnState>> keys;
  late final int columnCount;

  bool get loop => widget.loop == true;

  Tuple2<GeneralColumns, List> _normalize(dynamic columns, List? values) {
    if (columns is NamedValueColumns) {
      columns = List<List<PickerOption>>.of(
        columns.map(
          (os) => List<PickerOption>.of(
              os.map((o) => PickerOption.fromNamedValue(o))),
        ),
      );
    }
    return columns is CascadeColumns
        ? normalizeCascade(columns, values)
        : Tuple2(columns as GeneralColumns, values ?? const []);
  }

  _handleColumnChange(int colIndex, NamedValue selected) {
    final newValues = List<dynamic>.generate(columns.length, (_) => null)
      // ..setAll(0, values.sublist(0, colIndex + 1))
      ..setAll(0, values)
      ..setAll(colIndex, [selected.value]);
    // normalize for onChange
    final normalized = _normalize(widget.columns, newValues);
    columns = normalized.item1;
    values = normalized.item2;
    setState(() {});
    widget.onChange?.call(values);
  }

  @override
  void initState() {
    super.initState();
    // here normalize to probe length of columns
    final normalized = _normalize(widget.columns, widget.values);
    columns = normalized.item1;
    values = normalized.item2;
    columnCount = columns.length;
    keys = List.generate(columnCount, (_) => GlobalKey());
  }

  @override
  void didUpdateWidget(covariant PickerPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    // do nothing, should normalize at sequent build()
    // if (!ListUtil.shallowEq(values, widget.values ?? [])) {
    //   final normalized = _normalize(widget.columns, widget.values);
    //   columns = normalized.item1;
    //   values = normalized.item2;
    // }
  }

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);
    const extent = PickerExtent();

    final normalized = _normalize(widget.columns, widget.values);
    columns = normalized.item1;
    values = normalized.item2;

    final colChildren = List.generate(columns.length, (colIndex) {
      return PickerColumn(
        key: keys[colIndex],
        extent: extent,
        items: columns[colIndex],
        loop: loop,
        value: tryCatch(() => values[colIndex]),
        onChange: (selected) => _handleColumnChange(colIndex, selected),
      );
    });

    return LayoutBuilder(builder: (_, con) {
      if (con.maxHeight.isInfinite) con = con.copyWith(maxHeight: 264);
      return ConstrainedBox(
        constraints: con,
        child: Stack(alignment: Alignment.center, children: [
          Positioned.fill(child: TailBox().bg(theme.background2).Container()),
          Row(children: List.of(colChildren.map((child) {
            return Expanded(child: child);
          }))),
          const PositionedGradientMask(extent: extent),
          const PositionedHairline(extent: extent),
        ]),
      );
    });
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
