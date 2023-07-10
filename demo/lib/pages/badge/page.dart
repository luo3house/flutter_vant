import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:tailstyle/tailstyle.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show Colors;

// @DocsId("badge")
// @DocsWidget("Badge 徽标")

class BadgePage extends StatelessWidget {
  final Uri location;
  const BadgePage(this.location, {super.key});

  withBadgeWrap(List<Widget> children) {
    return List.of(children.map((child) {
      return TailBox().ml(16).Container(child: child);
    }));
  }

  @override
  Widget build(BuildContext context) {
    final cube = TailBox()
        .rounded(4)
        .bg(Colors.grey.shade300)
        .Container(width: 40, height: 40);

    return ListView(children: [
      const DocTitle("基本用法"),
      DocPadding(Wrap(spacing: 16, children: [
        // @DocsDemo("基本用法")
        Badge(content: 5, child: cube),
        Badge(content: 10, child: cube),
        Badge(content: "Hot", child: cube),
        Badge(dot: true, child: cube),
        // @DocsDemo
      ])),

      //
      const DocTitle("最大值"),
      DocPadding(Wrap(spacing: 16, children: [
        // @DocsDemo("最大值")
        Badge(max: 9, content: 10, child: cube),
        Badge(max: 20, content: 21, child: cube),
        Badge(max: 99, content: 100, child: cube),
        // @DocsDemo
      ])),

      //
      const DocTitle("徽标颜色"),
      DocPadding(Wrap(spacing: 16, children: [
        // @DocsDemo("徽标颜色")
        Badge(
          color: const Color.fromRGBO(25, 137, 250, 1),
          content: 5,
          child: cube,
        ),
        // @DocsDemo
        Badge(
          color: const Color.fromRGBO(25, 137, 250, 1),
          content: 10,
          child: cube,
        ),
        Badge(
          color: const Color.fromRGBO(25, 137, 250, 1),
          dot: true,
          child: cube,
        ),
      ])),

      //
      const DocTitle("徽标图标"),
      DocPadding(Wrap(spacing: 16, children: [
        // @DocsDemo("徽标图标")
        Badge(content: VanIcons.success, child: cube),
        Badge(content: VanIcons.fail, child: cube),
        Badge(content: VanIcons.down, child: cube),
        // @DocsDemo
      ])),
    ]);
  }
}
