import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/flutter_vantui.dart';

class DemoLayout extends StatelessWidget {
  final Uri location;
  final String? title;
  final Widget child;
  const DemoLayout({
    required this.location,
    required this.child,
    this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, con) {
      return Container(
        width: con.maxWidth,
        height: con.maxHeight,
        color: const Color(0xFFF0F2F5),
        child: Column(children: [
          VanNavBar(
            title: title ?? "Flutter Vant UI",
            // leftArrow: window.history.length > 1,
            // onLeftTap: () => window.history.back(),
          ),
          Expanded(child: child),
        ]),
      );
    });

    // Material inside Scaffold changes the default text style
    // https://github.com/flutter/flutter/issues/120334
    //
    // return Scaffold(
    //   backgroundColor: Color(0xFFF0F2F5),
    //   body: child,
    // );
  }
}
