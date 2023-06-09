import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';

class GridPage extends StatelessWidget {
  final Uri location;
  const GridPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("Basic Usage"),
      const VanGrid(children: [
        GridItem(icon: VanIcons.photo_o, text: "Text"),
        GridItem(icon: VanIcons.photo_o, text: "Text"),
        GridItem(icon: VanIcons.photo_o, text: "Text"),
        GridItem(icon: VanIcons.photo_o, text: "Text"),
      ]),

      //
      const DocTitle("Custom column length"),
      VanGrid(
        columnNum: 3,
        children: List.generate(
            6, (index) => const GridItem(icon: VanIcons.photo_o, text: "Text")),
      ),

      //
      const DocTitle("Custom content"),
      VanGrid(columnNum: 3, children: [
        GridItem(
            child: Image.network(
                "https://fastly.jsdelivr.net/npm/@vant/assets/apple-1.jpeg")),
        GridItem(
            child: Image.network(
                "https://fastly.jsdelivr.net/npm/@vant/assets/apple-2.jpeg")),
        GridItem(
            child: Image.network(
                "https://fastly.jsdelivr.net/npm/@vant/assets/apple-3.jpeg")),
      ]),

      //
      const DocTitle("Square"),
      VanGrid(
        columnNum: 4,
        children: List.generate(
          8,
          (index) => const GridItem(
            icon: VanIcons.photo_o,
            text: "Text",
          ),
        ),
      ),

      //
      const DocTitle("Gutter"),
      VanGrid(
        columnNum: 4,
        gutter: 10,
        children: List.generate(
          8,
          (index) => const GridItem(
            icon: VanIcons.photo_o,
            text: "Text",
          ),
        ),
      ),

      //
      const DocTitle("Horizontal"),
      VanGrid(
        columnNum: 3,
        children: List.generate(
          3,
          (index) => const GridItem(
            direction: Axis.horizontal,
            icon: VanIcons.photo_o,
            text: "Text",
          ),
        ),
      ),

      //
      const DocTitle("Clickable"),
      VanGrid(
        columnNum: 3,
        children: List.generate(
          3,
          (index) => const GridItem(
              clickable: true,
              direction: Axis.horizontal,
              icon: VanIcons.photo_o,
              text: "Text"),
        ),
      ),

      //
      const DocTitle("Badge"),
      const VanGrid(columnNum: 2, children: [
        GridItem(dot: true, icon: VanIcons.home_o, text: "Text"),
        GridItem(badge: "99+", icon: VanIcons.search, text: "Text"),
      ]),
    ]);
  }
}
