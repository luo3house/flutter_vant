import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';

// @DocsId("grid")
// @DocsWidget("Grid 宫格")

class GridPage extends StatelessWidget {
  final Uri location;
  const GridPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("Basic Usage"),
      // @DocsDemo("基本用法")
      const Grid(children: [
        GridItem(icon: VanIcons.photo_o, text: "Text"),
        GridItem(icon: VanIcons.photo_o, text: "Text"),
        GridItem(icon: VanIcons.photo_o, text: "Text"),
        GridItem(icon: VanIcons.photo_o, text: "Text"),
      ]),
      // @DocsDemo

      const DocTitle("Custom column length"),
      // @DocsDemo("自定义列数")
      Grid(
        columnNum: 3,
        children: List.generate(
            6, (index) => const GridItem(icon: VanIcons.photo_o, text: "Text")),
      ),
      // @DocsDemo

      const DocTitle("Custom content"),
      // @DocsDemo("自定义内容")
      Grid(columnNum: 3, children: [
        GridItem(
            child: Image.network(
                "https://fastly.jsdelivr.net/npm/@vant/assets/apple-1.jpeg")),
        GridItem(
            child: Image.network(
                "https://fastly.jsdelivr.net/npm/@vant/assets/apple-2.jpeg")),
        GridItem(
            child: Image.network(
                "https://fastly.jsdelivr.net/npm/@vant/assets/apple-3.jpeg")),
      ]),
      // @DocsDemo

      const DocTitle("Square"),
      // @DocsDemo("正方形格子")
      Grid(
        columnNum: 4,
        children: List.generate(
          8,
          (index) => const GridItem(
            icon: VanIcons.photo_o,
            text: "Text",
          ),
        ),
      ),
      // @DocsDemo

      const DocTitle("Gutter"),
      // @DocsDemo("格子间距")
      const Grid(columnNum: 4, gutter: 10, children: [
        GridItem(icon: VanIcons.photo_o, text: "Text"),
        GridItem(icon: VanIcons.photo_o, text: "Text"),
        GridItem(icon: VanIcons.photo_o, text: "Text"),
        GridItem(icon: VanIcons.photo_o, text: "Text"),
        GridItem(icon: VanIcons.photo_o, text: "Text"),
        GridItem(icon: VanIcons.photo_o, text: "Text"),
        GridItem(icon: VanIcons.photo_o, text: "Text"),
        GridItem(icon: VanIcons.photo_o, text: "Text"),
      ]),
      // @DocsDemo

      const DocTitle("Horizontal"),
      // @DocsDemo("内容横排")
      Grid(
        columnNum: 3,
        children: List.generate(
          3,
          (index) => const GridItem(
            direction: Axis.horizontal,
            icon: VanIcons.photo_o,
            text: "Text",
          ),
        ),
      ),
      // @DocsDemo

      //
      const DocTitle("Clickable"),
      // @DocsDemo("点击触发事件")
      Grid(
        columnNum: 3,
        children: List.generate(
          3,
          (index) => const GridItem(
            clickable: true,
            direction: Axis.horizontal,
            icon: VanIcons.photo_o,
            text: "Text",
          ),
        ),
      ),
      // @DocsDemo

      const DocTitle("Badge"),
      // @DocsDemo("带徽标")
      const Grid(columnNum: 2, children: [
        GridItem(dot: true, icon: VanIcons.home_o, text: "Text"),
        GridItem(badge: "99+", icon: VanIcons.search, text: "Text"),
      ]),
      // @DocsDemo
    ]);
  }
}
