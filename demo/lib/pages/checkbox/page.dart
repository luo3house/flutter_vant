import 'package:demo/doc/doc_title.dart';
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
      const DocTitle("Basic Usage"),
      // @DocsDemo("基本用法")
      DocPadding(WithModel(
        false,
        (model) => VanCheckbox(
          label: "Checkbox",
          checked: model.value,
          onChange: (v) => model.value = v,
        ),
      )),
      // @DocsDemo

      //
      const DocTitle("Disabled"),
      // @DocsDemo("禁用状态")
      const DocPadding(VanCheckbox(label: "Checkbox", disabled: true)),
      const SizedBox(height: 8),
      const DocPadding(
        VanCheckbox(label: "Checkbox", disabled: true, checked: true),
      ),
      // @DocsDemo

      const DocTitle("Shape"),
      // @DocsDemo("形状")
      DocPadding(WithModel(
        false,
        (model) => VanCheckbox(
          label: "Checkbox",
          checked: model.value,
          shape: BoxShape.rectangle,
          onChange: (v) => model.value = v,
        ),
      )),
      // @DocsDemo

      const DocTitle("Color"),
      // @DocsDemo("颜色")
      DocPadding(WithModel(
        false,
        (model) => VanCheckbox(
          label: "Checkbox",
          checked: model.value,
          checkedColor: const Color(0xFFEE0A24),
          onChange: (v) => model.value = v,
        ),
      )),
      // @DocsDemo

      const DocTitle("Icon"),
      // @DocsDemo("图标")
      DocPadding(WithModel(
        false,
        (model) => VanCheckbox(
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
      // @DocsDemo
    ]);
  }
}
