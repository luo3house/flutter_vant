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
      DocTitle("基本用法"),
      // @DocsDemo("基本用法")
      CellGroup(children: [
        Cell(title: "单元格", value: "内容"),
        Cell(title: "单元格", value: "内容", label: "描述信息"),
      ]),
      // @DocsDemo

      DocTitle("图标"),
      // @DocsDemo("图标")
      Cell(title: "单元格", value: "内容", icon: VanIcons.location_o),
      // @DocsDemo

      //
      DocTitle("右侧箭头 & 图标"),
      // @DocsDemo("右侧箭头 & 图标")
      Cell(title: "单元格", arrow: VanIcons.arrow),
      Cell(title: "单元格", value: "内容", arrow: VanIcons.arrow),
      Cell(title: "单元格", value: "内容", arrow: VanIcons.arrow_down),
      // @DocsDemo

      //
      DocTitle("垂直居中"),
      // @DocsDemo("垂直居中")
      Cell(title: "单元格", value: "内容", label: "描述信息", center: true),
      // @DocsDemo

      //
      DocTitle("单元格组"),
      // @DocsDemo("单元格组")
      CellGroup(children: [
        Cell(title: "单元格", value: "内容"),
        Cell(title: "单元格", value: "内容", label: "描述信息"),
      ]),
      // @DocsDemo

      //
      DocTitle("点击触发事件"),
      // @DocsDemo("点击触发事件")
      CellGroup(children: [
        Cell(title: "单元格", value: "内容", clickable: true),
        Cell(title: "单元格", value: "内容", label: "描述信息", clickable: true),
      ]),
      // @DocsDemo
    ]);
  }
}
