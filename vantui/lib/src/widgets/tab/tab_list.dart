import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter_vantui/src/widgets/tab/extent.dart';
import 'package:tailstyle/tailstyle.dart';

class TabList extends StatefulWidget {
  final List<Widget>? children;
  final int? activeIndex;
  final bool? shrink;
  final Function(int index)? onTap;
  const TabList({
    this.children,
    this.activeIndex,
    this.shrink,
    this.onTap,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return TabListState();
  }
}

class TabListState extends State<TabList> {
  final scroller = ScrollController();
  final indicatorKey = GlobalKey<TabIndicatorState>();
  late TabListExtent extent;
  var tabSizeGetters = <Size? Function()>[];
  var activeIndex = 0;

  void scrollTo([int? index]) {
    final theme = VanConfig.ofTheme(context);
    final idx = index ?? activeIndex;
    final viewWidth = context.size?.width;
    if (viewWidth == null) return;

    final tabSizes = tabSizeGetters.map((get) => get());
    if (!tabSizes.fold(true, (pre, cur) => pre && cur != null)) return;

    final sizes = List<Size>.from(tabSizes);
    final scrollableWidth = sizes.fold(0.0, (pre, cur) => pre + cur.width);
    final tabWidth = sizes.elementAt(idx).width;
    final left = sizes.sublist(0, idx).fold(0.0, (pre, cur) => pre + cur.width);
    final dx = left - viewWidth / 2 + tabWidth / 2;

    if (scroller.hasClients) {
      scroller.animateTo(
        clampDouble(dx, 0, max(0, scrollableWidth - viewWidth)),
        duration: theme.durationBase,
        curve: Curves.easeOut,
      );
    }
  }

  _clearSizeGetters() {
    tabSizeGetters = List.generate(
      widget.children?.length ?? 0,
      (index) => () => null,
    );
  }

  @override
  void initState() {
    super.initState();
    _clearSizeGetters();
    extent = const TabListExtent();
    activeIndex = widget.activeIndex ?? 0;
    raf(() => scrollTo());
  }

  @override
  void dispose() {
    scroller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TabList oldWidget) {
    super.didUpdateWidget(oldWidget);
    _clearSizeGetters();
    raf(() => scrollTo());
    if (activeIndex != widget.activeIndex) {
      activeIndex = widget.activeIndex ?? 0;
    }
  }

  List<Widget> mapSizeGetter(Iterable<Widget> children) {
    return List.generate(children.length, (index) {
      return Builder(builder: (context) {
        tabSizeGetters.setAll(index, [() => context.size]);
        return children.elementAt(index);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    const height = 44.0;

    final children = widget.children ?? [];

    final shrink = widget.shrink == true || (widget.children?.length ?? 0) > 4;

    final tabs = List.generate(children.length, (index) {
      final typo = TailTypo().text_color(theme.gray7);

      withTap(Widget child) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => widget.onTap?.call(index),
          child: child);

      Widget child = TailBox()
          .px(theme.paddingXs)
          .Container(child: Center(child: children.elementAt(index)));

      if (!shrink) {
        child = Expanded(child: withTap(child));
      } else {
        child = withTap(ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 40),
          child: child,
        ));
      }

      if (activeIndex == index) typo.font_bold().text_color(theme.gray8);

      return DefaultTextStyle(
        style: typo.TextStyle(),
        child: child,
      );
    });

    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: mapSizeGetter(tabs),
          ),
        ),
        TabIndicator(
          key: indicatorKey,
          extent: extent,
          tabSizeGetters: tabSizeGetters,
          activeIndex: activeIndex,
        ),
      ],
    );

    final wrap = () {
      if (shrink) {
        return SingleChildScrollView(
          controller: scroller,
          scrollDirection: Axis.horizontal,
          child: body,
        );
      } else {
        return body;
      }
    }();

    return TailBox().bg(theme.background2).as((styled) {
      return styled.Container(
        height: height,
        child: wrap,
      );
    });
  }
}

class TabIndicator extends StatefulWidget {
  final TabListExtent extent;
  final List<Size? Function()> tabSizeGetters;
  final int activeIndex;
  const TabIndicator({
    required this.extent,
    required this.tabSizeGetters,
    required this.activeIndex,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => TabIndicatorState();
}

class TabIndicatorState extends State<TabIndicator> {
  List<Size>? sizes;

  refreshTabSizes() {
    final sizes = widget //
        .tabSizeGetters
        .map((get) => get())
        .toList(growable: false);
    if (sizes.fold(true, (pre, cur) => pre && cur != null)) {
      setState(() => this.sizes = List.from(sizes));
    }
  }

  @override
  void initState() {
    super.initState();
    raf(() => refreshTabSizes());
  }

  @override
  void didUpdateWidget(covariant TabIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    raf(() => refreshTabSizes());
  }

  @override
  Widget build(BuildContext context) {
    final activeIndex = widget.activeIndex;
    final sizes = this.sizes;
    const double height = 3.0;

    if (sizes == null || sizes.length <= activeIndex) {
      return const SizedBox(height: height);
    }

    final theme = VanConfig.ofTheme(context);
    final width = widget.extent.getIndicatorWidth();

    final line = TailBox().rounded(3).bg(theme.primaryColor).as((styled) {
      return styled.Container(width: width, height: height);
    });

    final tabWidth = sizes.elementAt(activeIndex).width;
    final left = sizes //
        .sublist(0, activeIndex)
        .fold(0.0, (pre, cur) => pre + cur.width);
    final offset = left + max(0.0, (tabWidth - width) / 2);

    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: offset),
      duration: theme.durationBase,
      curve: Curves.easeOut,
      builder: (_, dx, child) {
        return Transform.translate(
          offset: Offset(dx, 0),
          child: line,
        );
      },
    );
  }
}
