import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/child.dart';
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
        return Child(
          // @DocsDemo("基本用法")
          Radio(
            checked: model.value,
            onChange: (v) => model.value = v,
            label: "单选框",
          ),
          // @DocsDemo
        );
      })),

      //
      const DocTitle("单选框组"),
      DocPadding(WithModel<String?>("1", (model) {
        return Child(
          // @DocsDemo("单选框组")
          RadioGroup(
            value: model.value,
            onChange: (name) => model.value = name,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Radio(name: "1", label: "单选框 1"),
                SizedBox(height: 10),
                Radio(name: "2", label: "单选框 2"),
              ],
            ),
          ),
          // @DocsDemo
        );
      })),

      //
      const DocTitle("水平排列"),
      DocPadding(WithModel<String?>("2", (model) {
        return Child(
          // @DocsDemo("水平排列")
          RadioGroup(
            value: model.value,
            onChange: (name) => model.value = name,
            child: Row(children: const [
              Radio(name: "1", label: "单选框 1"),
              SizedBox(width: 10),
              Radio(name: "2", label: "单选框 2"),
            ]),
          ),
          // @DocsDemo
        );
      })),
    ]);
  }
}
