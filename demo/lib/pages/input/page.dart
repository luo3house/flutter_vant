import 'package:demo/doc/doc_title.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';
import 'package:tailstyle/tailstyle.dart';

// @DocsId("input")
// @DocsWidget("Input 输入框")

class InputPage extends StatelessWidget {
  final Uri location;
  const InputPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("基本用法"),
      // @DocsDemo("基本用法")
      const Input(
        onChange: print,
        hint: "支持多行",
        autoFocus: true,
      ),
      // @DocsDemo

      const DocTitle("键盘类型"),
      // @DocsDemo("键盘类型: 文字")
      const Input(
        hint: "Plain Text",
        keyboardType: TextInputType.text,
      ),
      // @DocsDemo,

      const SizedBox(height: 10),
      // @DocsDemo("键盘类型: 电话号码")
      const Input(
        hint: "Phone",
        keyboardType: TextInputType.phone,
      ),
      // @DocsDemo,

      const SizedBox(height: 10),
      // @DocsDemo("键盘类型: 数字")
      const Input(
        hint: "Integer",
        keyboardType: TextInputType.number,
      ),
      // @DocsDemo

      const SizedBox(height: 10),
      // @DocsDemo("键盘类型: 小数")
      const Input(
        hint: "Decimal",
        keyboardType: TextInputType.numberWithOptions(decimal: true),
      ),
      // @DocsDemo

      const SizedBox(height: 10),
      // @DocsDemo("键盘类型: 密码")
      const Input(
        hint: "Password",
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
      ),
      // @DocsDemo,

      //
      const DocTitle("禁用状态"),
      // @DocsDemo("禁用状态")
      const Input(
        hint: "无法输入内容和获取焦点",
        disabled: true,
      ),
      // @DocsDemo

      const DocTitle("最大输入长度"),
      // @DocsDemo("最大输入长度")
      const Input(
        hint: "Max Length 6",
        maxLength: 6,
      ),
      // @DocsDemo,

      const DocTitle("自定义风格"),
      DocPadding(
        // @DocsDemo("自定义风格", "默认渲染朴素、接近 Web input 的风格。而通过 as 可自定义 Input 绘制，比如装饰到一个华丽的盒子里")
        Input(
          hint: "Placeholder",
          bgColor: Colors.white,
          as: (child) => TailBox()
              .p(10)
              .rounded(8)
              .border(Colors.blue.shade800)
              .bg(Colors.white)
              .Container(child: child),
        ),
        // @DocsDemo
      ),
    ]);
  }
}
