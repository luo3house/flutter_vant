import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';
import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:tailstyle/tailstyle.dart';

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
            DocPadding(VanSwitch(
              onChange: (v) => model.value = v,
              value: model.value,
            )),
            const DocTitle("禁用状态"),
            DocPadding(VanSwitch(
              value: model.value,
              disabled: true,
            )),
          ],
        );
      }),

      //
      const DocTitle("自定义大小"),
      DocPadding(WithModel(true, (model) {
        return VanSwitch(
          value: model.value,
          onChange: (v) => model.value = v,
          size: 20,
        );
      })),

      //
      const DocTitle("自定义颜色"),
      DocPadding(WithModel(true, (model) {
        return VanSwitch(
          value: model.value,
          onChange: (v) => model.value = v,
          bgOnColor: const Color(0xFFEE0A24),
        );
      })),

      //
      const DocTitle("自定义按钮"),
      DocPadding(WithModel(true, (model) {
        return VanSwitch(
          value: model.value,
          onChange: (v) => model.value = v,
          drawThumb: (v) => Icon(v ? VanIcons.success : VanIcons.cross),
        );
      })),

      //
      const DocTitle("搭配单元格使用"),
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
    ]);
  }
}
