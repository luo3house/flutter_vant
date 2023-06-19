import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';

class NavBarPage extends StatelessWidget {
  final Uri location;
  const NavBarPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("基本用法（自动发现路由返回）"),
      const VanNavBar(title: "Title"),

      const DocTitle("禁用自动路由返回"),
      const VanNavBar(title: "Title", leftArrow: false),

      //
      const DocTitle("Left"),
      const VanNavBar(title: "Title", leftText: "Back", leftArrow: true),

      //
      const DocTitle("Right"),
      const VanNavBar(
        title: "Title",
        leftText: "Back",
        leftArrow: true,
        rightArrow: VanIcons.search,
      ),

      //
      const DocTitle("Custom"),
      VanNavBar(
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
    ]);
  }
}
