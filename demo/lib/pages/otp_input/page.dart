import 'package:demo/widgets/with_value.dart';
import 'package:flutter/widgets.dart';
import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';

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
          return OTPInput(
            autoFocus: true,
            value: model.value,
            onChange: (v) => model.value = v,
          );
        }),
        const DocTitle("自定义长度"),
        const OTPInput(length: 4, value: "123"),
        const DocTitle("间距"),
        const OTPInput(gutter: 10, value: "12345"),
        const DocTitle("隐藏文字"),
        const OTPInput(obsecure: true, value: "123"),
      ],
    );
  }
}
