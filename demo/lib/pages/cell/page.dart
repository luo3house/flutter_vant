import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';

// @DocsId("cell")
// @DocsWidget("Cell 单元格")

class CellPage extends StatelessWidget {
  final Uri location;
  const CellPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: const [
      DocTitle("Basic Usage"),
      // @DocsDemo("基本用法")
      VanCellGroup(children: [
        VanCell(title: "单元格", value: "内容"),
        VanCell(title: "单元格", value: "内容", label: "描述信息"),
      ]),
      // @DocsDemo

      DocTitle("With Icon"),
      // @DocsDemo("图标")
      VanCell(title: "单元格", value: "内容", icon: VanIcons.location_o),
      // @DocsDemo

      //
      DocTitle("Arrow"),
      // @DocsDemo("右侧箭头 & 图标")
      VanCell(title: "单元格", arrow: VanIcons.arrow),
      VanCell(title: "单元格", value: "内容", arrow: VanIcons.arrow),
      VanCell(title: "单元格", value: "内容", arrow: VanIcons.arrow_down),
      // @DocsDemo

      //
      DocTitle("Vertical Align"),
      // @DocsDemo("垂直居中")
      VanCell(title: "单元格", value: "内容", label: "描述信息", center: true),
      // @DocsDemo

      //
      DocTitle("Group"),
      // @DocsDemo("单元格组")
      VanCellGroup(children: [
        VanCell(title: "单元格", value: "内容"),
        VanCell(title: "单元格", value: "内容", label: "描述信息"),
      ]),
      // @DocsDemo

      //
      DocTitle("Clickable"),
      // @DocsDemo("点击触发事件")
      VanCellGroup(children: [
        VanCell(title: "单元格", value: "内容", clickable: true),
        VanCell(title: "单元格", value: "内容", label: "描述信息", clickable: true),
      ]),
      // @DocsDemo
    ]);
  }
}
