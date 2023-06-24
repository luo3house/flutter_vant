import 'package:flutter/widgets.dart';
import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';

class OTPInputPage extends StatelessWidget {
  final Uri location;
  const OTPInputPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: const [
      DocTitle("基本用法"),
      OTPInput(autoFocus: true, value: "123"),
      DocTitle("自定义长度"),
      OTPInput(length: 4, value: "123"),
      DocTitle("间距"),
      OTPInput(gutter: 10, value: "123456"),
      DocTitle("隐藏文字"),
      OTPInput(obsecure: true, value: "123"),
    ]);
  }
}
