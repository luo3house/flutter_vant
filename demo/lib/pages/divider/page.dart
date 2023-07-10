import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';

// @DocsId("divider")
// @DocsWidget("Divider 分割线")

class DividerPage extends StatelessWidget {
  final Uri location;
  const DividerPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: const [
      DocTitle("Basic Usage"),
      // @DocsDemo("基本用法")
      Divider(),
      // @DocsDemo

      DocTitle("With Text"),
      // @DocsDemo("展示文本")
      Divider(child: Text("Text")),
      // @DocsDemo

      DocTitle("Position"),
      // @DocsDemo("内容位置")
      Divider(
        contentPosition: ContentPosition.left,
        child: Text("Text"),
      ),
      Divider(
        contentPosition: ContentPosition.right,
        child: Text("Text"),
      ),
      // @DocsDemo

      DocTitle("Custom Style"),
      // @DocsDemo("自定义样式")
      Divider(
        textStyle: TextStyle(color: Color.fromRGBO(25, 137, 250, 1)),
        child: Text("Text"),
      ),
      // @DocsDemo
    ]);
  }
}
