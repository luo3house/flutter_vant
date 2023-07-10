import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/child.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show Icons;

// @DocsId("checkbox")
// @DocsWidget("Checkbox 复选框")

class CheckboxPage extends StatelessWidget {
  final Uri location;
  const CheckboxPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      NilChild(
        // @DocsDemo("基本用法")
        Checkbox(
          label: "复选框",
          checked: true,
          onChange: (checked) => {},
        ),
        // @DocsDemo
      ),

      const DocTitle("基本用法"),
      DocPadding(WithModel(
        false,
        (model) => Checkbox(
          label: "复选框",
          checked: model.value,
          onChange: (v) => model.value = v,
        ),
      )),

      //
      const DocTitle("禁用状态"),
      const DocPadding(
        // @DocsDemo("禁用状态")
        Checkbox(label: "复选框", disabled: true),
        // @DocsDemo
      ),
      const SizedBox(height: 8),
      const DocPadding(
        Checkbox(label: "复选框", disabled: true, checked: true),
      ),

      const DocTitle("Shape"),
      const NilChild(
        // @DocsDemo("形状")
        Checkbox(shape: BoxShape.rectangle, checked: true),
        // @DocsDemo
      ),
      DocPadding(WithModel(
        false,
        (model) => Checkbox(
          label: "复选框",
          checked: model.value,
          shape: BoxShape.rectangle,
          onChange: (v) => model.value = v,
        ),
      )),

      const DocTitle("Color"),
      const NilChild(
        // @DocsDemo("颜色")
        Checkbox(checkedColor: Color(0xFFEE0A24), checked: true),
        // @DocsDemo
      ),
      DocPadding(WithModel(
        false,
        (model) => Checkbox(
          label: "复选框",
          checked: model.value,
          checkedColor: const Color(0xFFEE0A24),
          onChange: (v) => model.value = v,
        ),
      )),

      const DocTitle("Icon"),
      NilChild(
        // @DocsDemo("图标")
        Checkbox(
          checked: true,
          icon: (checked) {
            final icon = checked //
                ? Icons.visibility
                : Icons.visibility_off;
            return FittedBox(child: Icon(icon));
          },
        ),
        // @DocsDemo
      ),
      DocPadding(WithModel(
        false,
        (model) => Checkbox(
          label: "Icon",
          checked: model.value,
          onChange: (v) => model.value = v,
          icon: (checked) {
            final icon = checked //
                ? Icons.visibility
                : Icons.visibility_off;
            return FittedBox(child: Icon(icon));
          },
        ),
      )),
    ]);
  }
}
