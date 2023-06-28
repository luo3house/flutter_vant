import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/utils/list_util.dart';
import 'package:flutter_vantui/src/utils/rendering.dart';
import 'package:flutter_vantui/src/utils/vo.dart';
import 'package:flutter_vantui/src/widgets/config/index.dart';
import 'package:tailstyle/tailstyle.dart';

import 'extent.dart';
import 'physics.dart';

class PickerColumn extends StatefulWidget {
  final PickerExtent extent;
  final List<INamedValue> items;
  final bool? loop;
  final dynamic value;
  final Function(INamedValue v)? onChange;

  PickerColumn({
    required this.extent,
    required this.items,
    this.loop,
    this.value,
    this.onChange,
    super.key,
  }) {
    assert(items.isNotEmpty, "should have at least 1 option");
  }

  @override
  State<StatefulWidget> createState() {
    return PickerColumnState();
  }
}

class PickerColumnState extends State<PickerColumn> {
  late FixedExtentScrollController scroller;

  List<INamedValue> get items => widget.items;
  int get currentIndex => scroller.selectedItem;
  int get currentTrueIndex => currentIndex % items.length;

  int? findIndexOfValue(dynamic value) {
    final index = items.indexWhere((e) => e.value == value);
    return index == -1 ? null : index;
  }

  goto(int? index, {bool animate = true}) {
    if (index == null) return;
    if (animate) {
      scroller.animateToItem(
        index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    } else {
      scroller.jumpToItem(index);
    }
  }

  @override
  void initState() {
    super.initState();
    scroller = FixedExtentScrollController(
      initialItem: findIndexOfValue(widget.value) ?? 0,
    );
  }

  @override
  void didUpdateWidget(covariant PickerColumn oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newIndex = findIndexOfValue(widget.value) ?? 0;
    if (!ListUtil.shallowEq(widget.items, oldWidget.items)) {
      raf(() => goto(newIndex, animate: false));
    } else if (currentTrueIndex != newIndex) {
      raf(() => goto(newIndex, animate: true));
    }
  }

  @override
  void dispose() {
    scroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    final loop = widget.loop == true;

    final childDelegate = () {
      final typo = TailTypo().text_color(theme.textColor);
      if (loop) {
        return ListWheelChildLoopingListDelegate(
          children: List.generate(items.length, (index) {
            return Center(child: typo.Text(items[index].name));
          }),
        );
      } else {
        return ListWheelChildListDelegate(
          children: List.generate(items.length, (index) {
            return Center(child: typo.Text(items[index].name));
          }),
        );
      }
    }();

    return LayoutBuilder(builder: (_, con) {
      final mainAxisViewport = con.maxHeight;
      return ListWheelScrollView.useDelegate(
        physics: SnapNearestScrollPhysics(
          widget.extent.getItemHeight(),
          parent: const BouncingScrollPhysics(),
        ),
        onSelectedItemChanged: (trueIndex) {
          widget.onChange?.call(items[trueIndex]);
        },
        controller: scroller,
        itemExtent: widget.extent.getItemHeight(),
        diameterRatio: mainAxisViewport / 2,
        childDelegate: childDelegate,
      );
    });
  }
}
