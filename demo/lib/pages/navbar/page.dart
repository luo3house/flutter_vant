import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';

// @DocsId("navbar")
// @DocsWidget("NavBar 导航栏")

class NavBarPage extends StatelessWidget {
  final Uri location;
  const NavBarPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("基本用法（自动发现路由返回）"),
      // @DocsDemo("基本用法", "默认自动发现路由返回，可使用 leftArrow: false 取消")
      const NavBar(title: "Title"),
      // @DocsDemo

      const DocTitle("禁用自动路由返回"),
      const NavBar(title: "Title", leftArrow: false),

      const DocTitle("Left"),
      // @DocsDemo("渲染左侧文本和图标")
      const NavBar(title: "Title", leftText: "Back", leftArrow: true),
      // @DocsDemo

      const DocTitle("Right"),
      // @DocsDemo("渲染右侧文本和图标")
      const NavBar(
        title: "Title",
        leftText: "Back",
        leftArrow: true,
        rightArrow: VanIcons.search,
      ),
      // @DocsDemo

      const DocTitle("Custom"),
      // @DocsDemo("完全自定义一侧内容")
      NavBar(
        title: "Title",
        leftArrow: true,
        right: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            NavBarBtn(px: 10, icon: VanIcons.search),
            NavBarBtn(px: 10, icon: VanIcons.more_o),
          ],
        ),
      ),
      // @DocsDemo
    ]);
  }
}
