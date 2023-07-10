import 'package:demo/widgets/child.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/flutter_vantui.dart';

// @DocsId("indexbar")
// @DocsWidget("IndexBar 索引列表")

class IndexBarPage extends StatelessWidget {
  final Uri location;
  const IndexBarPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    final alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("");

    const NilChild(
      // @DocsDemo("基本用法")
      IndexBar(children: [
        IndexBarAnchor("A"),
        Cell(title: "文本"),
        Cell(title: "文本"),
        Cell(title: "文本"),

        //
        IndexBarAnchor("B"),
        Cell(title: "文本"),
        Cell(title: "文本"),
        Cell(title: "文本"),

        // ...
      ]),
      // @DocsDemo
    );

    const NilChild(
      // @DocsDemo("自定义索引列表")
      IndexBar(children: [
        IndexBarAnchor("1", child: Text("标题1")),
        Cell(title: "文本"),
        Cell(title: "文本"),
        Cell(title: "文本"),
        IndexBarAnchor("2", child: Text("标题2")),
        Cell(title: "文本"),
        Cell(title: "文本"),
        Cell(title: "文本"),

        // ...
      ]),
      // @DocsDemo
    );

    return Tabs(expands: true, active: "基本用法", children: [
      Tab(
        "基本用法",
        bgColor: const Color(0x00000000),
        child: IndexBar(
          children: List.of(
            alphabet.map((anchorName) {
              return [
                IndexBarAnchor(anchorName),
                Cell(title: "Text $anchorName", clickable: true),
                Cell(title: "Text $anchorName", clickable: true),
                Cell(title: "Text $anchorName", clickable: true),
              ];
            }).expand((el) => el),
          ),
        ),
      ),
      Tab(
        "自定义索引列表",
        bgColor: const Color(0x00000000),
        child: IndexBar(
          children: List.of(
            alphabet.map((anchorName) {
              return [
                IndexBarAnchor(anchorName, child: Text("#$anchorName")),
                Cell(title: "Text $anchorName", clickable: true),
                Cell(title: "Text $anchorName", clickable: true),
                Cell(title: "Text $anchorName", clickable: true),
              ];
            }).expand((el) => el),
          ),
        ),
      ),
    ]);
  }
}
