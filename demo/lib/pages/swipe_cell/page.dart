import 'package:demo/widgets/child.dart';
import 'package:flutter/widgets.dart';
import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter_vantui/flutter_vantui.dart';

// @DocsId("swipe_cell")
// @DocsWidget("SwipeCell 滑动单元格")

class SwipeCellPage extends StatelessWidget {
  final Uri location;
  const SwipeCellPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("基本用法"),
      // @DocsDemo("基本用法")
      SwipeCell(
        left: const Button(square: true, text: "选择", type: ButtonType.primary),
        right: Row(mainAxisSize: MainAxisSize.min, children: const [
          Button(square: true, text: "删除", type: ButtonType.danger),
          Button(square: true, text: "收藏", type: ButtonType.primary),
        ]),
        child: const Cell(title: "横扫", value: "内容"),
      ),
      // @DocsDemo

      //
      const DocTitle("点击关闭"),
      WithModel(GlobalKey<SwipeCellState>(), (model) {
        final key = model.value;
        return Child(
          // @DocsDemo("点击关闭")
          SwipeCell(
            key: key, // GlobalKey<VanSwipeCellState>()
            right: Row(mainAxisSize: MainAxisSize.min, children: [
              Button(
                square: true,
                text: "删除",
                type: ButtonType.danger,
                onTap: () => key.currentState?.close(),
              ),
              Button(
                square: true,
                text: "收藏",
                type: ButtonType.primary,
                onTap: () => key.currentState?.close(),
              ),
            ]),
            child: const Cell(title: "单元格", value: "内容"),
          ),
          // @DocsDemo
        );
      }),

      const DocTitle("自定义渲染"),
      // @DocsDemo("自定义渲染")
      WithModel(
        List.generate(3, (_) => GlobalKey<SwipeCellState>()),
        (model) {
          right(GlobalKey<SwipeCellState> key) {
            return Row(mainAxisSize: MainAxisSize.min, children: [
              Button(
                type: ButtonType.warning,
                square: true,
                text: "置顶",
                onTap: () => key.currentState?.close(),
              ),
              Button(
                type: ButtonType.danger,
                square: true,
                text: "删除",
                onTap: () => key.currentState?.close(),
              ),
            ]);
          }

          return Column(mainAxisSize: MainAxisSize.min, children: [
            SwipeCell(
              key: model.value[0],
              right: right(model.value[0]),
              child: const Cell(
                prefix: Badge(
                  dot: true,
                  child: Icon(VanIcons.smile_comment_o, size: 28),
                ),
                title: "友人 A",
                label: "今晚去吃寿司怎么样？",
              ),
            ),
            SwipeCell(
              key: model.value[1],
              right: right(model.value[1]),
              child: const Cell(
                prefix: Badge(
                  content: 40,
                  child: Icon(VanIcons.orders_o, size: 28),
                ),
                title: "生活号",
                label: "紧急扩散！！为什么这不能吃那不能吃？",
              ),
            ),
            SwipeCell(
              key: model.value[2],
              right: right(model.value[2]),
              child: const Cell(
                prefix: Icon(VanIcons.bullhorn_o, size: 28),
                title: "水电费",
                label: "本月水电费用已出单",
              ),
            ),
          ]);
        },
      ),
      // @DocsDemo
    ]);
  }
}
