import 'package:flutter/widgets.dart';
import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:tailstyle/tailstyle.dart';

class SwipePage extends StatelessWidget {
  static const bgColors = <int, Color>{
    0: Color(0xFF66C6F2),
    1: Color(0xFF39A9ED),
    2: Color(0xFF80A1EF),
  };

  final Uri location;
  const SwipePage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    buildCarouselBox(int index) => Container(
          color: bgColors[index],
          child: Center(
              child: TailTypo().text_color(TailColors.gray_100).Text("$index")),
        );

    return ListView(children: [
      const DocTitle("基本用法"),
      Swipe(children: [
        buildCarouselBox(0),
        buildCarouselBox(1),
        buildCarouselBox(2),
      ]),

      //
      const DocTitle("自动轮播"),
      Swipe(
        count: 3,
        autoplay: const Duration(seconds: 3),
        builder: (index) => buildCarouselBox(index),
      ),

      //
      const DocTitle("无限滑动"),
      Swipe(loop: true, children: [
        buildCarouselBox(0),
        buildCarouselBox(1),
        buildCarouselBox(2),
      ]),

      //
      const DocTitle("监听 onChange 事件"),
      Swipe(
        loop: true,
        onChange: (index) => VanToastStatic.show(
          context,
          message: "onChange: $index",
        ),
        children: [
          buildCarouselBox(0),
          buildCarouselBox(1),
          buildCarouselBox(2),
        ],
      ),

      //
      const DocTitle("自定义滑块大小"),
      Swipe(padEnds: false, viewportFraction: 0.8, children: [
        buildCarouselBox(0),
        buildCarouselBox(1),
        buildCarouselBox(2),
      ]),

      //
      const DocTitle("自定义指示器"),
      Swipe(
        loop: true,
        indicator: SwipeIndicatorBuilder((e) {
          return Positioned(
            right: 10,
            bottom: 10,
            child: Container(
              padding: const EdgeInsets.all(10),
              color: TailColors.gray_400.withAlpha(0xAA),
              child: TailTypo()
                  .text_color(TailColors.gray_100)
                  .Text("${e.active}/${e.total}"),
            ),
          );
        }),
        children: [
          buildCarouselBox(0),
          buildCarouselBox(1),
          buildCarouselBox(2),
        ],
      ),

      const SizedBox(height: 20),
    ]);
  }
}
