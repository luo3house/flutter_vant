import 'package:demo/routes.dart';
import 'package:demo/widgets/touch_opacity.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:tailstyle/tailstyle.dart';
import 'package:go_router/go_router.dart';

class DocsLayout extends StatelessWidget {
  final Uri location;
  final String? title;
  final Widget child;
  const DocsLayout({
    super.key,
    required this.location,
    this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, con) {
      return Container(
        width: con.maxWidth,
        height: con.maxHeight,
        color: const Color(0xFFF0F2F5),
        child: Column(children: [
          TailBox()
              .p(16)
              .bg(const Color(0xFFFFFFFF))
              .border_b(const Color(0xFFCECECE))
              .Container(
                child: Row(children: [
                  TailTypo() //
                      .text_lg()
                      .font_bold()
                      // .Text("Flutter Vant UI"),
                      .Text(""),
                ]),
              ),
          Expanded(
            child: Row(children: [
              TailBox().bg(const Color(0xFFFFFFFF)).p(16).Container(
                    width: 200,
                    child: buildSideBar(context),
                  ),
              Expanded(child: TailBox().p(20).Container(child: child)),
            ]),
          ),
        ]),
      );
    });

    // https://github.com/flutter/flutter/issues/120334
    // return Scaffold(
    //   backgroundColor: Color(0xFFF0F2F5),
    //   body: Column(children: [
    //     TailBox()
    //         .p(16)
    //         .bg(Color(0xFFFFFFFF))
    //         .border_b(Color(0xFFCECECE))
    //         .Container(
    //           child: Row(children: [
    //             TailTypo().text_lg().font_bold().Text("Flutter Vant UI"),
    //           ]),
    //         ),
    //     Expanded(
    //       child: Row(children: [
    //         TailBox().bg(Color(0xFFFFFFFF)).p(16).Container(
    //               width: 200,
    //               child: buildSideBar(context),
    //             ),
    //         Expanded(child: TailBox().p(20).Container(child: child)),
    //       ]),
    //     ),
    //   ]),
    // );
  }

  ListView buildSideBar(BuildContext context) {
    final widgets = kSidebarLinks.map((link) {
      if (link is SideBarTitle) {
        return TailBox().my(8).Container(
              child: TailTypo().font_bold().Text(link.title),
            );
      } else if (link is SideBarLink) {
        return Pressable((pressed) {
          return TouchOpacity(
            onTap: () => GoRouter.of(context).go(link.to.toString()),
            child: TailBox().my(8).as((styled) {
              final match = link.to.path == location.path;
              return styled.Container(
                child: TailTypo()
                    .text_color(match ? const Color(0xFF259BF7) : null)
                    .Text(link.title),
              );
            }),
          );
        });
      } else {
        return const SizedBox(height: 24);
      }
    });
    return ListView.builder(
      itemCount: widgets.length,
      itemBuilder: (context, index) => widgets.elementAt(index),
    );
  }
}

class SideBarTitle {
  final String title;
  SideBarTitle(this.title);
}

class SideBarLink {
  final String title;
  final Uri to;
  SideBarLink(this.title, this.to);
}

class SideBarVoid {}

final kSidebarLinks = <Object>{
  SideBarTitle("Basic Widgets"),
  ...kRoutes.map((route) => SideBarLink(route.name!, Uri.parse(route.path))),
  SideBarVoid(),
};
