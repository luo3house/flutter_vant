import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';

class CellPage extends StatelessWidget {
  final Uri location;
  const CellPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: const [
      DocTitle("Basic Usage"),
      VanCellGroup(children: [
        VanCell(title: "单元格", value: "内容"),
        VanCell(title: "单元格", value: "内容", label: "描述信息"),
      ]),

      //
      DocTitle("With Icon"),
      VanCell(title: "单元格", value: "内容", icon: VanIcons.location_o),

      //
      DocTitle("Arrow"),
      VanCell(title: "单元格", arrow: VanIcons.arrow),
      VanCell(title: "单元格", value: "内容", arrow: VanIcons.arrow),
      VanCell(title: "单元格", value: "内容", arrow: VanIcons.arrow_down),

      //
      DocTitle("Vertical Align"),
      VanCell(title: "单元格", value: "内容", label: "描述信息", center: true),

      //
      DocTitle("Group"),
      VanCellGroup(children: [
        VanCell(title: "单元格", value: "内容"),
        VanCell(title: "单元格", value: "内容", label: "描述信息"),
      ]),

      //
      DocTitle("Clickable"),
      VanCellGroup(children: [
        VanCell(title: "单元格", value: "内容", clickable: true),
        VanCell(title: "单元格", value: "内容", label: "描述信息", clickable: true),
      ]),
    ]);
  }
}
