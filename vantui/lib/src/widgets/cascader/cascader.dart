import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:tailstyle/tailstyle.dart';
import 'package:tuple/tuple.dart';

import '../../utils/nil.dart';
import '../../utils/std.dart';
import '../button/pressable.dart';
import '../config/index.dart';
import '../icon/index.dart';
import '../tab/tab.dart';
import '../tab/tabs.dart';
import 'types.dart';

class VanCascader extends StatefulWidget {
  final List<INamedValueOption>? options;
  final List? values;
  final Function(List values)? onChange;
  final Function(List values, INamedValueOption selectedOption)? onOptionChange;
  final Function(List values)? onCascadeEnd;
  final bool? expands;

  const VanCascader({
    this.options,
    this.values,
    this.onChange,
    this.onOptionChange,
    this.onCascadeEnd,
    this.expands,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return VanCascaderState();
  }
}

class VanCascaderState extends State<VanCascader> {
  final currentTab = ValueNotifier(0);
  var options = <List<INamedValueOption>>[];
  var values = [];

  _onOptionTap(int index, INamedValueOption option) {
    final newValues =
        List<dynamic>.generate(max(values.length, index + 1), (_) => null)
          ..setAll(0, values.sublist(0, index))
          ..setAll(index, [option.value]);
    final tuple = normalizeCascade(widget.options, newValues);
    options = tuple.item1;
    values = tuple.item2;
    setState(() {});
    if (options.length > values.length) {
      currentTab.value = options.length - 1;
    } else {
      widget.onCascadeEnd?.call(values);
    }
    widget.onChange?.call(values);
    widget.onOptionChange?.call(values, option);
  }

  @override
  void initState() {
    super.initState();
    values = widget.values ?? [];
    currentTab.addListener(() {
      // raf(() => swipeKey.currentState?.setIndex(currentTab.value));
    });
  }

  @override
  void dispose() {
    currentTab.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant VanCascader oldWidget) {
    super.didUpdateWidget(oldWidget);
    values = widget.values ?? [];
    // if (widget.values != values && widget.values != oldWidget.values) {
    //   values = widget.values ?? [];
    //   currentTab.value = values.length;
    // }
  }

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    final tuple = normalizeCascade(widget.options, values);
    options = tuple.item1;
    values = tuple.item2;

    final matchOpts = List.generate(options.length, (index) {
      return INamedValueOption.findByValue(
        options[index],
        tryCatch(() => values[index]),
      );
    });

    final tabs = List.generate(options.length, (index) {
      final opts = options[index];
      return Tab(
        "hierarchy-level-$index",
        title: matchOpts[index]?.name ?? TailTypo().font_normal().Text("请选择"),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: opts.length,
          itemBuilder: (_, idx) {
            return CascaderOption(
              option: opts[idx],
              selected: matchOpts[index]?.value == opts[idx].value,
              onTap: () => _onOptionTap(index, opts[idx]),
            );
          },
        ),
      );
    });

    return ValueListenableBuilder(
      valueListenable: currentTab,
      builder: (_, index, __) {
        return Tabs(
          swipeable: true,
          shrinkTabs: true,
          active: index,
          onChange: (e) => currentTab.value = e.index,
          expands: widget.expands,
          children: tabs,
        );
      },
    );

    // return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    //   ValueListenableBuilder(
    //     valueListenable: currentTab,
    //     builder: (_, index, __) {
    //       return Tabs(
    //         shrinkTabs: true,
    //         active: index,
    //         onChange: (e) => currentTab.value = e.index,
    //         children: tabs,
    //       );
    //     },
    //   ),
    //   VanSwipe(
    //     key: swipeKey,
    //     autoplay: Duration.zero,
    //     duration: theme.durationBase,
    //     loop: false,
    //     gesture: false,
    //     count: tabs.length,
    //     builder: (index) {
    //       final matchOne = matchOpts[index];
    //       final options = colOptions[index] ?? [];
    //       return Container(
    //         color: theme.background2,
    //         child: ListView.builder(
    //           itemCount: options.length,
    //           itemBuilder: (context, idx) {
    //             final option = options[idx];
    //             return CascaderOption(
    //               option: option,
    //               selected: matchOne?.value == option.value,
    //               onTap: () => _onOptionTap(index, option),
    //             );
    //           },
    //         ),
    //       );
    //     },
    //   ),
    // ]);
  }
}

class CascaderOption extends StatelessWidget {
  final INamedValueOption option;
  final bool selected;
  final Function() onTap;
  const CascaderOption({
    required this.option,
    required this.selected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    final color = selected ? theme.primaryColor : theme.textColor;
    final fontWeight = selected ? FontWeight.bold : FontWeight.normal;

    return Pressable((pressed) {
      return DefaultTextStyle(
        style: DefaultTextStyle.of(context)
            .style
            .copyWith(color: color, fontWeight: fontWeight),
        child: IconTheme(
          data: IconTheme.of(context).copyWith(color: color),
          child: GestureDetector(
            onTap: onTap,
            child: TailBox()
                .bg(pressed ? theme.gray2 : const Color(0x00000000))
                .p(theme.paddingMd)
                .Container(
                  child: Row(children: [
                    Text(option.name),
                    const Expanded(child: nil),
                    selected ? const Icon(VanIcons.success) : nil,
                  ]),
                ),
          ),
        ),
      );
    });
  }
}

/// HO = [A(a(1), aa), B(b, bb(2))], V = [A, aa]
/// FO = [[A, B], [a, aa], [1]], NV = [A, aa]
///
/// HO = [A(a(1), aa), B(b, bb(2))], V = [A]
/// FO = [[A, B], [a, aa]], NV = [A]
Tuple2<List<List<T>>, List> normalizeCascade<T extends INamedValueOption>(
    List<T>? hierOptions, List? values) {
  values ??= [];
  final normalizeValues = [];
  final flattenOptions = <List<T>>[];
  int valueIndex = 0;
  while (hierOptions != null) {
    flattenOptions.add(hierOptions);
    final value = tryCatch(() => values?[valueIndex]);
    final match = INamedValueOption.findByValue(hierOptions, value);
    if (match == null) break;
    hierOptions = match.children as List<T>?;
    normalizeValues.add(match.value);
    valueIndex++;
  }
  return Tuple2(flattenOptions, normalizeValues);
}
