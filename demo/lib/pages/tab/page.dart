import 'package:demo/widgets/with_value.dart';
import 'package:flutter/widgets.dart';
import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:tailstyle/tailstyle.dart';

// @DocsId("tab")
// @DocsWidget("Tab 标签页")

class TabPage extends StatelessWidget {
  final Uri location;
  const TabPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    final tabBox = TailBox().px().px(15).py(30);
    return ListView(children: [
      const DocTitle("基本用法"),
      // @DocsDemo("基本用法")
      Tabs(active: "标签 1", children: [
        Tab("标签 1", child: tabBox.Container(child: const Text("标签 1"))),
        Tab("标签 2", child: tabBox.Container(child: const Text("标签 2"))),
        Tab("标签 3", child: tabBox.Container(child: const Text("标签 3"))),
        Tab("标签 4", child: tabBox.Container(child: const Text("标签 4"))),
      ]),
      // @DocsDemo

      const DocTitle("收缩布局"),
      // @DocsDemo("收缩布局")
      Tabs(active: "标签 1", children: [
        Tab("标签 1", child: tabBox.Container(child: const Text("标签 1"))),
        Tab("标签 2", child: tabBox.Container(child: const Text("标签 2"))),
        Tab("标签 3", child: tabBox.Container(child: const Text("标签 3"))),
        Tab("标签 4", child: tabBox.Container(child: const Text("标签 4"))),
        Tab("标签 5", child: tabBox.Container(child: const Text("标签 5"))),
        Tab("标签 6", child: tabBox.Container(child: const Text("标签 6"))),
        Tab("标签 7", child: tabBox.Container(child: const Text("标签 7"))),
        Tab("标签 8", child: tabBox.Container(child: const Text("标签 8"))),
      ]),
      // @DocsDemo

      const DocTitle("自定义标签"),
      // @DocsDemo("自定义标签")
      WithModel("1", (model) {
        final title = Row(mainAxisSize: MainAxisSize.min, children: const [
          Icon(VanIcons.more_o),
          SizedBox(width: 5),
          Text("标签")
        ]);
        return Tabs(active: model.value, children: [
          Tab(
            "1",
            title: title,
            child: tabBox.Container(child: const Text("标签 1")),
          ),
          Tab(
            "2",
            title: title,
            child: tabBox.Container(child: const Text("标签 2")),
          ),
        ]);
      }),
      // @DocsDemo

      const DocTitle("切换动画"),
      // @DocsDemo("切换动画")
      Tabs(active: "标签 1", animated: true, children: [
        Tab("标签 1", child: tabBox.Container(child: const Text("标签 1"))),
        Tab("标签 2", child: tabBox.Container(child: const Text("标签 2"))),
        Tab("标签 3", child: tabBox.Container(child: const Text("标签 3"))),
        Tab("标签 4", child: tabBox.Container(child: const Text("标签 4"))),
      ]),
      // @DocsDemo

      const DocTitle("手势滑动"),
      // @DocsDemo("手势滑动")
      Tabs(active: "标签 1", swipeable: true, children: [
        Tab("标签 1", child: tabBox.Container(child: const Text("标签 1"))),
        Tab("标签 2", child: tabBox.Container(child: const Text("标签 2"))),
        Tab("标签 3", child: tabBox.Container(child: const Text("标签 3"))),
        Tab("标签 4", child: tabBox.Container(child: const Text("标签 4"))),
      ]),
      // @DocsDemo

      const DocTitle("滚动导航"),
      // @DocsDemo("滚动导航")
      Builder(builder: (context) {
        const len = 6;
        final tabs = List.generate(len, (i) => Tab("标签 $i"));
        final tabContents = List.generate(
          len,
          (i) => TailBox().px(10).as((s) {
            return s.Container(child: Text("标签 $i 区域"));
          }),
        );
        const contentExtent = 80.0;
        final tabsKey = GlobalKey<TabsState>();
        tabsState() => tabsKey.currentState;
        return WithModel(ScrollController(), (model) {
          final contentScroller = model.value;
          return Tabs(
            key: tabsKey,
            children: tabs,
            onChange: (e) => tabsState()?.animateToIndex(
              e.index,
              animateToImpl: (index, duration, curve) {
                contentScroller.animateTo(
                  e.index * contentExtent,
                  duration: duration,
                  curve: curve,
                );
              },
            ),
            builder: (_) => WithModel(ScrollController(), (model) {
              return NotificationListener<ScrollNotification>(
                onNotification: (e) {
                  final scrollIndex =
                      (e.metrics.pixels / contentExtent).floor();
                  tabsState()?.handleScrollToActiveIndexEvent(scrollIndex);
                  return false;
                },
                child: Container(
                  color: const Color(0xFFFFFFFF),
                  height: 100,
                  child: ListView(
                    controller: contentScroller,
                    itemExtent: contentExtent,
                    children: tabContents,
                  ),
                ),
              );
            }),
          );
        });
      }),
      // @DocsDemo

      const SizedBox(height: 50),
    ]);
  }
}
