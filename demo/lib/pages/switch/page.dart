import 'package:flutter/widgets.dart';
import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter_vantui/flutter_vantui.dart';

// @DocsId("switch")
// @DocsWidget("Switch 开关")

class SwitchPage extends StatelessWidget {
  final Uri location;
  const SwitchPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      WithModel(false, (model) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DocTitle("基础用法"),
            DocPadding(
              // @DocsDemo("基础用法")
              VanSwitch(
                onChange: (v) => model.value = v,
                value: model.value,
              ),
              // @DocsDemo
            ),
            const DocTitle("禁用状态"),
            DocPadding(
              // @DocsDemo("禁用状态")
              VanSwitch(
                value: model.value,
                disabled: true,
              ),
              // @DocsDemo
            ),
          ],
        );
      }),

      //
      const DocTitle("自定义大小"),
      DocPadding(WithModel(true, (model) {
        // @DocsDemo("自定义大小")
        return VanSwitch(
          value: model.value,
          onChange: (v) => model.value = v,
          size: 20,
        );
        // @DocsDemo
      })),

      const DocTitle("自定义颜色"),
      DocPadding(WithModel(true, (model) {
        // @DocsDemo("自定义颜色")
        return VanSwitch(
          value: model.value,
          onChange: (v) => model.value = v,
          bgOnColor: const Color(0xFFEE0A24),
        );
        // @DocsDemo
      })),

      //
      const DocTitle("自定义按钮"),
      DocPadding(WithModel(true, (model) {
        // @DocsDemo("自定义按钮")
        return VanSwitch(
          value: model.value,
          onChange: (v) => model.value = v,
          drawThumb: (v) => Icon(v ? VanIcons.success : VanIcons.cross),
        );
        // @DocsDemo
      })),

      const DocTitle("搭配单元格使用"),
      // @DocsDemo("搭配单元格使用")
      VanCell(
        title: "标题",
        center: true,
        value: WithModel(true, (model) {
          return VanSwitch(
            value: model.value,
            onChange: (v) => model.value = v,
          );
        }),
      ),
      // @DocsDemo
    ]);
  }
}
