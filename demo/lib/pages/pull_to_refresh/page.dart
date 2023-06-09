import 'dart:math';

import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:tailstyle/tailstyle.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show Colors;

class PullToRefreshPage extends StatelessWidget {
  final Uri location;
  const PullToRefreshPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("Basic Usage"),
      WithModel(ScrollController(), (model) {
        final controller = model.value;
        return Container(
          color: Colors.white,
          height: 200,
          child: VanPullRefresh(
            controller: controller,
            // ignore: avoid_print
            onRefresh: () => Future.sync(() => print("refresh"))
                .then((_) => Future.delayed(const Duration(seconds: 1))),
            child: ListView(
              controller: controller,
              itemExtent: 50,
              children: List.generate(1000, (index) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  // ignore: avoid_print
                  onTap: () => print("tap index: $index"),
                  child: Center(child: Text("$index")),
                );
              }),
            ),
          ),
        );
      }),

      //
      const DocTitle("At Not Scrollable"),
      VanPullRefresh(
        // ignore: avoid_print
        onRefresh: () => Future.sync(() => print("refresh"))
            .then((_) => Future.delayed(const Duration(seconds: 1))),
        child: GestureDetector(
          onVerticalDragStart: (details) {},
          child: LayoutBuilder(builder: (_, con) {
            return TailBox().border().Container(
                  height: 100,
                  width: con.maxWidth,
                  child: const Text("drag me"),
                );
          }),
        ),
      ),

      //
      const DocTitle("Custom Head"),

      VanPullRefresh(
        // ignore: avoid_print
        onRefresh: () => Future.sync(() => print("refresh"))
            .then((_) => Future.delayed(const Duration(seconds: 1))),
        drawHead: (args) {
          return Image.network(
            args.status == PullRefreshStatus.pull
                ? "https://fastly.jsdelivr.net/npm/@vant/assets/doge.png"
                : "https://fastly.jsdelivr.net/npm/@vant/assets/doge-fire.jpeg",
            fit: BoxFit.fitHeight,
            height: min(args.headHeight, args.visibleHeight),
          );
        },
        child: GestureDetector(
          onVerticalDragStart: (details) {},
          child: LayoutBuilder(builder: (_, con) {
            return TailBox().border().Container(
                  height: 100,
                  width: con.maxWidth,
                  child: const Text("drag me"),
                );
          }),
        ),
      ),
    ]);
  }
}
