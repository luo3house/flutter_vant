import 'package:demo/widgets/child.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter/widgets.dart';
import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';

// @DocsId("otp_input")
// @DocsWidget("OTPInput 验证码输入框")
class OTPInputPage extends StatelessWidget {
  final Uri location;
  const OTPInputPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        const DocTitle("基本用法"),
        WithModel("123", (model) {
          return Child(
            // @DocsDemo("基本用法")
            OTPInput(
              autoFocus: true,
              value: model.value,
              onChange: (v) => model.value = v,
            ),
            // @DocsDemo
          );
        }),

        const DocTitle("自定义长度"),
        // @DocsDemo("自定义长度")
        const OTPInput(length: 4, value: "123"),
        // @DocsDemo

        const DocTitle("间距"),
        // @DocsDemo("间距")
        const OTPInput(gutter: 10, value: "12345"),
        // @DocsDemo

        const DocTitle("隐藏文字"),
        // @DocsDemo("隐藏文字")
        const OTPInput(obsecure: true, value: "123"),
        // @DocsDemo

        const DocTitle("接收输入完成事件"),
        // @DocsDemo("接收输入完成事件")
        OTPInput(
          obsecure: true,
          value: "123",
          onComplete: (chars) =>
              ToastStatic.show(context, message: "Codes: $chars"),
        ),
        // @DocsDemo
      ],
    );
  }
}
