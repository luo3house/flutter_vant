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

  @override
  Widget build(BuildContext context) {
    badgeWrap(Widget child) => TailBox().ml(16).Container(child: child);
    final cube = TailBox()
        .rounded(4)
        .bg(Colors.grey.shade300)
        .Container(width: 40, height: 40);

    return ListView(children: [
      const DocTitle("Basic Usage"),
      Wrap(children: [
        // @DocsDemo("基本用法")
        badgeWrap(VanBadge(content: 5, child: cube)),
        badgeWrap(VanBadge(content: 10, child: cube)),
        badgeWrap(VanBadge(content: "Hot", child: cube)),
        badgeWrap(VanBadge(dot: true, child: cube)),
        // @DocsDemo
      ]),

      //
      const DocTitle("Maximum"),
      Wrap(children: [
        // @DocsDemo("最大值")
        badgeWrap(VanBadge(max: 9, content: 10, child: cube)),
        badgeWrap(VanBadge(max: 20, content: 21, child: cube)),
        badgeWrap(VanBadge(max: 99, content: 100, child: cube)),
        // @DocsDemo
      ]),

      //
      const DocTitle("Color"),
      Builder(builder: (_) {
        // @DocsDemo("徽标颜色")
        const color = Color.fromRGBO(25, 137, 250, 1);
        return Wrap(children: [
          badgeWrap(VanBadge(color: color, content: 5, child: cube)),
          badgeWrap(VanBadge(color: color, content: 10, child: cube)),
          badgeWrap(VanBadge(color: color, dot: true, child: cube)),
        ]);
        // @DocsDemo
      }),

      //
      const DocTitle("Icon"),
      Wrap(children: [
        // @DocsDemo("徽标图标")
        badgeWrap(VanBadge(content: VanIcons.success, child: cube)),
        badgeWrap(VanBadge(content: VanIcons.fail, child: cube)),
        badgeWrap(VanBadge(content: VanIcons.down, child: cube)),
        // @DocsDemo
      ]),
    ]);
  }
}
