import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';

// @DocsId("input")
// @DocsWidget("Input 输入框")

class InputPage extends StatelessWidget {
  final Uri location;
  const InputPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("Basic Usage"),
      // @DocsDemo("基本用法")
      WithModel("", (model) {
        return VanInput(
          onChange: print,
          hint: "Multi Line Available",
          value: model.value,
          autoFocus: true,
        );
      }),
      // @DocsDemo

      const DocTitle("Keyboard Type"),
      // @DocsDemo("键盘类型: 文字")
      WithModel("", (model) {
        return VanInput(
          value: model.value,
          hint: "Plain Text",
          keyboardType: TextInputType.text,
        );
      }),
      // @DocsDemo

      const SizedBox(height: 10),
      // @DocsDemo("键盘类型: 电话号码")
      WithModel("", (model) {
        return VanInput(
          value: model.value,
          hint: "Phone",
          keyboardType: TextInputType.phone,
        );
      }),
      // @DocsDemo

      const SizedBox(height: 10),
      // @DocsDemo("键盘类型: 数字")
      WithModel("", (model) {
        return VanInput(
          value: model.value,
          hint: "Integer",
          keyboardType: TextInputType.number,
        );
      }),
      // @DocsDemo

      const SizedBox(height: 10),
      // @DocsDemo("键盘类型: 小数")
      WithModel("", (model) {
        return VanInput(
          value: model.value,
          hint: "Decimal",
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        );
      }),
      // @DocsDemo

      const SizedBox(height: 10),
      WithModel("", (model) {
        // @DocsDemo("键盘类型: 密码")
        return VanInput(
          value: model.value,
          hint: "Password",
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
        );
        // @DocsDemo
      }),

      //
      const DocTitle("Disabled"),
      // @DocsDemo("禁用状态")
      const VanInput(
        value: "Input Disabled",
        disabled: true,
      ),
      // @DocsDemo

      const DocTitle("Max Length"),
      // @DocsDemo("最大输入长度")
      WithModel("", (model) {
        return VanInput(
          value: model.value,
          hint: "Max Length 6",
          maxLength: 6,
        );
      }),
      // @DocsDemo
    ]);
  }
}
