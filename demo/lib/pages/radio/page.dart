import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';

// @DocsId("radio")
// @DocsWidget("Radio 单选框")

class RadioPage extends StatelessWidget {
  final Uri location;
  const RadioPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("Basic Usage"),
      DocPadding(WithModel(false, (model) {
        // @DocsDemo("基本用法")
        return VanRadio(
          checked: model.value,
          onChange: (v) => model.value = v,
          label: "单选框",
        );
        // @DocsDemo
      })),

      //
      const DocTitle("单选框组"),
      DocPadding(WithModel<String?>("1", (model) {
        // @DocsDemo("单选框组")
        return VanRadioGroup(
          value: model.value,
          onChange: (name) => model.value = name,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              VanRadio(name: "1", label: "单选框 1"),
              SizedBox(height: 10),
              VanRadio(name: "2", label: "单选框 2"),
            ],
          ),
        );
        // @DocsDemo
      })),

      //
      const DocTitle("水平排列"),
      DocPadding(WithModel<String?>("2", (model) {
        // @DocsDemo("水平排列")
        return VanRadioGroup(
          value: model.value,
          onChange: (name) => model.value = name,
          child: Row(children: const [
            VanRadio(name: "1", label: "单选框 1"),
            SizedBox(width: 10),
            VanRadio(name: "2", label: "单选框 2"),
          ]),
        );
        // @DocsDemo
      })),
    ]);
  }
}
