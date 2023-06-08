import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/widgets/config/index.dart';
import 'package:flutter_vantui/src/widgets/tab/types.dart';
import 'package:tailstyle/tailstyle.dart';

import 'tab.dart';
import 'tab_list.dart';

class Tabs extends StatefulWidget {
  final bool? shrink;
  final dynamic active;
  final List<Tab>? children;
  final Function(NamedIndex e)? onChange;
  final bool? expanded;

  const Tabs({
    this.shrink,
    this.active,
    this.children,
    this.onChange,
    this.expanded,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return TabsState();
  }
}

class TabsState extends State<Tabs> {
  var active = '';

  setActive(dynamic active) {
    setState(() => this.active = _normalizeActive(active));
  }

  Iterable<Widget> _mapTabTitles(Iterable<Tab> children) {
    final theme = VanConfig.ofTheme(context);

    return List.generate(children.length, (index) {
      final child = children.elementAt(index);
      if (child.title is Widget) {
        return child.title;
      } else {
        return Center(
          child: TailTypo() //
              .font_size(theme.fontSizeMd)
              .Text("${child.title ?? child.name}"),
        );
      }
    });
  }

  String _normalizeActive(dynamic active) {
    final tabs = widget.children ?? [];
    if (active is int) {
      active = active.clamp(0, tabs.length);
      return tabs.length > active ? tabs.elementAt(active).name : this.active;
    } else {
      return "$active";
    }
  }

  @override
  void initState() {
    super.initState();
    setActive(widget.active);
  }

  @override
  void didUpdateWidget(covariant Tabs oldWidget) {
    super.didUpdateWidget(oldWidget);
    setActive(widget.active);
  }

  @override
  Widget build(BuildContext context) {
    final tabs = widget.children ?? [];

    final activeIndex = max(0, tabs.indexWhere((e) => e.name == active));

    final titles = _mapTabTitles(tabs);

    Widget child = Stack(children: List.of(tabs.map((tab) {
      final selected = active == tab.name;
      return Offstage(offstage: !selected, child: tab);
    })));
    if (widget.expanded == true) {
      child = Expanded(child: child);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TabList(
          shrink: widget.shrink,
          activeIndex: activeIndex,
          onTap: (index) {
            final name = tabs.elementAt(index).name;
            setState(() => active = name);
            widget.onChange?.call(NamedIndex(name, index));
          },
          children: List.of(titles),
        ),
        child,
      ],
    );
  }
}
