import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:tailstyle/tailstyle.dart';

class NestedNamedValue extends NamedValue {
  List<NestedNamedValue>? children;
  NestedNamedValue(super.item1, super.item2, [this.children]);
}

class VanCascader extends StatefulWidget {
  static List<List<NestedNamedValue>?> flattenOptionsByValues(
    List<NestedNamedValue> options,
    List<dynamic> values,
  ) {
    List<NestedNamedValue>? tmp = options;
    var list = <List<NestedNamedValue>?>[tmp];
    for (var i = 0; i < values.length; i++) {
      final children = tryCatch(
        () => tmp?.firstWhere((e) => e.value == values[i]),
      )?.children;
      tmp = children;
      list.add(children);
    }
    return list;
  }

  static List<NestedNamedValue?> matchOptionsByValues(
    List<NestedNamedValue> options,
    List<dynamic> values,
  ) {
    final flatten = flattenOptionsByValues(options, values);
    return List.generate(
      values.length,
      (index) => tryCatch<NestedNamedValue?>(
        () => flatten[index]?.firstWhere((e) => e.value == values[index]),
      ),
    );
  }

  final List<NestedNamedValue>? options;
  final List? values;
  final Function(List values)? onChange;

  const VanCascader({
    this.options,
    this.values,
    this.onChange,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return VanCascaderState();
  }
}

class VanCascaderState extends State<VanCascader> {
  final swipeKey = GlobalKey<VanSwipeState>();
  final currentTab = ValueNotifier(0);
  var values = [];

  _onOptionTap(int index, NestedNamedValue option) {
    values = List.generate(max(values.length, index + 1), (_) => null)
      ..setAll(0, values)
      ..setAll(index, [option.value]);
    if (option.children != null) currentTab.value++;
    setState(() {});
    widget.onChange?.call(values);
  }

  @override
  void initState() {
    super.initState();
    values = widget.values ?? [];
    currentTab.addListener(() {
      raf(() => swipeKey.currentState?.setIndex(currentTab.value));
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
    if (widget.values != values && widget.values != oldWidget.values) {
      values = widget.values ?? [];
      currentTab.value = values.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    final colOptions = VanCascader.flattenOptionsByValues(
      widget.options ?? [],
      values,
    );

    final matchOpts = List.generate(colOptions.length, (index) {
      return tryCatch(() => colOptions
          .elementAt(index)
          ?.firstWhere((e) => e.value == values[index]));
    });

    final tabs = List.generate(currentTab.value + 1, (index) {
      return Tab(
        "hierarchy-level-$index",
        title: matchOpts[index]?.name ?? TailTypo().font_normal().Text("请选择"),
      );
    });

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      ValueListenableBuilder(
        valueListenable: currentTab,
        builder: (_, index, __) {
          return Tabs(
            shrink: true,
            active: index,
            onChange: (e) => currentTab.value = e.index,
            children: tabs,
          );
        },
      ),
      VanSwipe(
        key: swipeKey,
        autoplay: Duration.zero,
        duration: theme.durationBase,
        loop: false,
        gesture: false,
        count: tabs.length,
        builder: (index) {
          final matchOne = matchOpts[index];
          final options = colOptions[index] ?? [];
          return Container(
            color: theme.background2,
            child: ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, idx) {
                final option = options[idx];
                return CascaderOption(
                  option: option,
                  selected: matchOne?.value == option.value,
                  onTap: () => _onOptionTap(index, option),
                );
              },
            ),
          );
        },
      ),
    ]);
  }
}

class CascaderOption extends StatelessWidget {
  final NestedNamedValue option;
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
                    selected ? const VanIcon(VanIcons.success) : nil,
                  ]),
                ),
          ),
        ),
      );
    });
  }
}
