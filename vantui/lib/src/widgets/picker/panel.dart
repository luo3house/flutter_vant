import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/widgets/_util/event_insensitive_box_decoration.dart';
import 'package:flutter_vantui/src/widgets/picker/extent.dart';
import 'package:tailstyle/tailstyle.dart';
import 'package:tuple/tuple.dart';

import '../../utils/std.dart';
import '../../utils/vo.dart';
import '../cascader/types.dart';
import '../config/index.dart';
import 'column.dart';

typedef GeneralColumns = List<List<INamedValueOption>>;
typedef CascadeColumns = List<INamedValueOption>;

// @DocsId("picker")

class PickerOption extends NamedValueOption {
  PickerOption(
    super.name,
    super.value, [
    super.children,
    super.disabled = false,
  ]);
}

class PickerPanel extends StatefulWidget {
  // @DocsProp("columns", "List<NamedValue | PickerOption> | List<List<NamedValue | PickerOption>>", "带子级联选项、或多维固定选项")
  final dynamic columns;
  // @DocsProp("values", "List", "当前值列表")
  final List? values;
  // @DocsProp("onChange", "Function(List)", "值变化回调")
  final Function(List values)? onChange;
  // @DocsProp("loop", "bool", "循环选项列")
  final bool? loop;

  PickerPanel({
    required this.columns,
    this.values,
    this.onChange,
    this.loop,
    super.key,
  }) {
    assert(columns is GeneralColumns || columns is CascadeColumns,
        "columns should be subtype of PickerOption[][], or PickerOption[] for cascading, got: ${columns.runtimeType}");
  }

  @override
  State<StatefulWidget> createState() {
    return PickerPanelState();
  }
}

class PickerPanelState extends State<PickerPanel> {
  // values & columns here should be normalized
  var values = <dynamic>[];
  var columns = <List<INamedValueOption>>[];
  late final List<GlobalKey<PickerColumnState>> keys;
  late final int columnCount;

  bool get loop => widget.loop == true;

  Tuple2<GeneralColumns, List> _normalize(dynamic columns, List? values) {
    return columns is CascadeColumns
        ? normalizePick(columns, values)
        : Tuple2(columns as GeneralColumns, values ?? const []);
  }

  _handleColumnChange(int colIndex, INamedValue selected) {
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
          const _PositionedGradientMask(extent),
          const _PositionedHairline(extent),
        ]),
      );
    });
  }
}

class _PositionedHairline extends StatelessWidget {
  final PickerExtent extent;

  const _PositionedHairline(this.extent);

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);
    final borderColor = theme.borderColor;

    return Positioned.fill(
      left: theme.paddingMd,
      right: theme.paddingMd,
      top: null,
      bottom: null,
      child: TailBox().border_t(borderColor).border_b(borderColor).as((s) {
        return Container(
          height: extent.getItemHeight(),
          decoration: EventInsensitiveBoxDecoration.from(s.BoxDecoration()),
        );
      }),
    );
  }
}

class _PositionedGradientMask extends StatelessWidget {
  final PickerExtent extent;
  const _PositionedGradientMask(this.extent);

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);
    final height = extent.getItemHeight();
    final gradientBg = theme.isDark ? theme.black : theme.white;
    final graident = [
      gradientBg.withOpacity(.9),
      gradientBg.withOpacity(.4),
    ];
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

/// HO = [A(a(1), aa), B(b, bb(2))], V = [A, aa]
/// FO = [[A, B], [a, aa], [1]], NV = [A, aa, 1]
Tuple2<List<List<T>>, List> normalizePick<T extends INamedValueOption>(
    List<T>? hierOptions, List? values) {
  final normalizeValues = [];
  final flattenOptions = <List<T>>[];
  int valueIndex = 0;
  while (hierOptions != null) {
    if (hierOptions.isEmpty) break;
    flattenOptions.add(hierOptions);
    final value = tryCatch(() => values?[valueIndex]);
    final match = INamedValue.findByValue(hierOptions, value) ?? //
        hierOptions!.first;
    hierOptions = List<T>.from(match.children ?? []);
    normalizeValues.add(match.value);
    valueIndex++;
  }
  return Tuple2(flattenOptions, normalizeValues);
}
