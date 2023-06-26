import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/widgets/_util/with_raf.dart';
import 'package:flutter_vantui/src/widgets/_util/with_value.dart';
import 'package:flutter_vantui/src/widgets/config/index.dart';
import 'package:flutter_vantui/src/widgets/tab/types.dart';
import 'package:tailstyle/tailstyle.dart';

import '../../utils/nil.dart';
import '../../utils/std.dart';
import 'tab.dart';
import 'tab_list.dart';

typedef TabsBuilder = Widget Function(TabsState state);
typedef IScrollerAnimateToIndex = void Function(
    int index, Duration duration, Curve curve);

class Tabs extends StatefulWidget {
  final bool? shrinkTabs;
  final dynamic active;
  final List<Tab>? children;
  final Function(NamedIndex e)? onChange;
  final bool? expands;
  final bool? keepAlive;
  final bool? animated;
  final bool? swipeable;
  final TabsBuilder? builder;

  const Tabs({
    this.shrinkTabs,
    this.active,
    this.children,
    this.onChange,
    this.expands,
    this.keepAlive,
    this.animated,
    this.swipeable,
    this.builder,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return TabsState();
  }
}

class TabsState extends State<Tabs> {
  PageController? _pager;
  Timer? _scrollEventHandlePause;
  BuildContext? tabListContext;
  var _active = '';

  List<Tab> get tabs => widget.children ?? [];
  int get activeIndex => max(0, tabs.indexWhere((e) => e.name == _active));
  bool get swipeable => widget.swipeable == true;
  bool get animated => widget.animated == true;
  bool get expands => widget.expands == true;

  setActive(dynamic active) {
    _active = _normalizeActive(active);
    setState(() => animateToIndex(activeIndex));
  }

  animateToIndex(int index, {IScrollerAnimateToIndex? animateToImpl}) {
    final theme = VanConfig.ofTheme(context);
    final duration = theme.durationFast;
    _scrollEventHandlePause?.cancel();
    _scrollEventHandlePause = Timer(
      duration,
      () => _scrollEventHandlePause = null,
    );
    animateToImpl ??= (index, duration, curve) {
      if (_pager?.hasClients == true) {
        _pager?.animateToPage(
          index,
          duration: duration,
          curve: curve,
        );
      }
    };
    animateToImpl(activeIndex, duration, Curves.easeOut);
  }

  handleScrollToActiveIndexEvent(int activeIndex) {
    if (this.activeIndex == activeIndex || _scrollEventHandlePause != null) {
      return;
    }
    _active = tabs[activeIndex].name;
    setState(() {});
  }

  _handleTabContentPointerDown(Offset pos) {
    final tabListRect = tryCatch(() {
      if (tabListContext == null) return null;
      final box = tabListContext?.findRenderObject() as RenderBox;
      final size = box.size;
      final tl = box.localToGlobal(Offset.zero);
      final br = tl.translate(size.width, size.height);
      return Rect.fromPoints(tl, br);
    });
    if (tabListRect != null && !tabListRect.contains(pos)) {
      // pointer down at tab content
      _scrollEventHandlePause?.cancel();
      _scrollEventHandlePause = null;
    }
  }

  _handleTabListTap(int activeIndex) {
    final name = tabs.elementAt(activeIndex).name;
    setActive(name);
    widget.onChange?.call(NamedIndex(name, activeIndex));
  }

  Widget offstageBuilder(TabsState state) {
    final tabs = this.tabs, activeIndex = this.activeIndex;
    return Stack(
      children: List.generate(tabs.length, (index) {
        final selected = activeIndex == index;
        final tab = tabs[index];
        final keepAlive = tab.keepAlive ?? widget.keepAlive ?? false;
        Widget child = Offstage(
          offstage: !selected,
          child: selected || keepAlive ? tab : nil,
        );
        if (expands) child = Expanded(child: child);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [child],
        );
      }),
    );
  }

  // ref: https://stackoverflow.com/questions/54522980/flutter-adjust-height-of-pageview-horizontal-listview-based-on-current-child
  Widget swipeShrinkBuilder(TabsState state) {
    final tabs = this.tabs;
    // ignore: prefer_const_literals_to_create_immutables
    return WithValue(shouldSync: (a, b) => false, <int, Size>{}, (mSizes) {
      final sizes = mSizes.value;
      return WithValue(
        shouldSync: (a, b) => b != null && a != b,
        sizes[activeIndex]?.height,
        (mMemoHeight) {
          final heightOrLastHeight = mMemoHeight.value ?? 0.0;
          return SizedBox(
            height: heightOrLastHeight,
            child: PageView(
              controller: _pager,
              physics: swipeable
                  ? const ClampingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              children: List.generate(tabs.length, (index) {
                final tab = tabs[index];
                if (tab.keepAlive == true) {
                  if (kDebugMode) {
                    print(
                        "Warning: keepAlive within independent Swipeable Tabs will not work, related Tab: ${tab.name}");
                  }
                }
                return OverflowBox(
                  maxHeight: double.infinity,
                  child: WithRaf(
                    (c) => tryCatch(() {
                      if (!sizes.containsKey(index)) {
                        sizes[index] = c.size ?? Size.zero;
                        mSizes.value = Map.from(sizes);
                      }
                    }),
                    child: tab,
                  ),
                );
              }),
            ),
          );
        },
      );
    });
  }

  Widget swipeExpandsBuilder(TabsState state) {
    final tabs = this.tabs;
    return PageView(
      controller: _pager,
      physics: swipeable
          ? const ClampingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      children: List.generate(tabs.length, (index) {
        final tab = tabs[index];
        if (tab.keepAlive == true) {
          if (kDebugMode) {
            print(
                "Warning: keepAlive within independent Swipeable Tabs will not work, related Tab: ${tab.name}");
          }
        }
        return tab;
      }),
    );
  }

  Iterable<Widget> _mapTabListItems(Iterable<Tab> children) {
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
    final tabs = this.tabs;
    if (active is int) {
      active = active.clamp(0, tabs.length);
      return tabs.length > active ? tabs.elementAt(active).name : _active;
    } else {
      return "$active";
    }
  }

  @override
  void initState() {
    super.initState();
    setActive(widget.active);
    final activeIndex = this.activeIndex;
    if (animated || swipeable) {
      _pager = PageController(
        initialPage: activeIndex,
        keepPage: widget.keepAlive == true,
      )..addListener(() {
          final scrollIndex = _pager?.page?.round();
          if (scrollIndex != null) handleScrollToActiveIndexEvent(scrollIndex);
        });
    }
  }

  @override
  void dispose() {
    _pager?.dispose();
    _scrollEventHandlePause?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Tabs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active != _active) {
      setActive(widget.active);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabs = this.tabs, activeIndex = this.activeIndex;
    assert(tabs.isNotEmpty, "at least 1 tab is required");

    final tabList = Builder(builder: (context) {
      tabListContext = context;
      return TabList(
        shrink: widget.shrinkTabs,
        activeIndex: activeIndex,
        onTap: (index) => _handleTabListTap(index),
        children: List.of(_mapTabListItems(tabs)),
      );
    });

    final defaultBuilder = animated || swipeable
        ? expands
            ? swipeExpandsBuilder
            : swipeShrinkBuilder
        : offstageBuilder;

    Widget child = (widget.builder ?? defaultBuilder).call(this);

    if (expands) {
      child = Expanded(child: child);
    }

    return Listener(
      onPointerDown: (e) => _handleTabContentPointerDown(e.position),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [tabList, child],
      ),
    );
  }
}
