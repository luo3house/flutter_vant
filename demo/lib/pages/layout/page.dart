import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:tailstyle/tailstyle.dart';
import 'package:flutter/widgets.dart';

class LayoutPage extends StatelessWidget {
  final Uri location;

  const LayoutPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    deepBlue(String label) =>
        TailBox().py(12).bg(const Color(0xff39a9ed)).Container(
              child: TailTypo()
                  .text_color(const Color(0xFFFFFFFF))
                  .text_center()
                  .Text(label),
            );
    skyBlue(String label) =>
        TailBox().py(12).bg(const Color(0xff66c6f2)).Container(
              child: TailTypo()
                  .text_color(const Color(0xFFFFFFFF))
                  .text_center()
                  .Text(label),
            );

    return ListView(children: [
      const DocTitle("Basic Usage"),
      VanRow(children: [
        VanCol(span: 8, child: deepBlue("span: 8")),
        VanCol(span: 8, child: skyBlue("span: 8")),
        VanCol(span: 8, child: deepBlue("span: 8")),
      ]),
      const SizedBox(height: 8),
      VanRow(children: [
        VanCol(span: 4, child: deepBlue("span: 4")),
        VanCol(offset: 4, span: 10, child: skyBlue("offset: 4, span: 10")),
      ]),
      const SizedBox(height: 8),
      VanRow(children: [
        VanCol(offset: 12, span: 12, child: deepBlue("offset: 12, span: 12")),
      ]),
      const DocTitle("在列元素之间增加间距"),
      VanRow(gutter: 20, children: [
        VanCol(span: 8, child: deepBlue("span: 8")),
        VanCol(span: 8, child: skyBlue("span: 8")),
        VanCol(span: 8, child: deepBlue("span: 8")),
      ]),
      const DocTitle("对齐方式"),
      VanRow(justify: VanJustify.center, children: [
        VanCol(span: 6, child: deepBlue("span: 6")),
        VanCol(span: 6, child: skyBlue("span: 6")),
        VanCol(span: 6, child: deepBlue("span: 6")),
      ]),
      const SizedBox(height: 8),
      VanRow(justify: VanJustify.end, children: [
        VanCol(span: 6, child: deepBlue("span: 6")),
        VanCol(span: 6, child: skyBlue("span: 6")),
        VanCol(span: 6, child: deepBlue("span: 6")),
      ]),
      const SizedBox(height: 8),
      VanRow(justify: VanJustify.spaceBetween, children: [
        VanCol(span: 6, child: deepBlue("span: 6")),
        VanCol(span: 6, child: skyBlue("span: 6")),
        VanCol(span: 6, child: deepBlue("span: 6")),
      ]),
      const SizedBox(height: 8),
      VanRow(justify: VanJustify.spaceAround, children: [
        VanCol(span: 6, child: deepBlue("span: 6")),
        VanCol(span: 6, child: skyBlue("span: 6")),
        VanCol(span: 6, child: deepBlue("span: 6")),
      ]),
      const SizedBox(height: 8),
    ]);
  }
}
