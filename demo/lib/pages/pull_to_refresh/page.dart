import 'dart:math';

import 'package:demo/widgets/with_value.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';

// @DocsId("pull_refresh")
// @DocsWidget("PullRefresh 下拉刷新")

class PullToRefreshPage extends StatelessWidget {
  final Uri location;
  const PullToRefreshPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return Tabs(expands: true, children: [
      Tab("基本用法", child: _BasicUsage()),
      Tab("自定义绘制", child: _CustomHead()),
      Tab("刷新时禁用", child: _DisableDuringRefresh()),
    ]);
  }
}

// @DocsDemo("基本用法")
class _BasicUsage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WithModel(ScrollController(), (model) {
      final controller = model.value;
      return VanPullRefresh(
        controller: controller,
        // ignore: avoid_print
        onRefresh: () => Future.sync(() => print("refresh"))
            .then((_) => Future.delayed(const Duration(seconds: 1))),
        child: ListView(
          controller: controller,
          itemExtent: 50,
          children: List.generate(100, (index) {
            return Center(child: Text("Item $index"));
          }),
        ),
      );
    });
  }
}
// @DocsDemo

// @DocsDemo("自定义头部提示")
class _CustomHead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WithModel(ScrollController(), (model) {
      final controller = model.value;
      return VanPullRefresh(
        controller: controller,
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
        child: ListView(
          controller: controller,
          itemExtent: 50,
          children: List.generate(100, (index) {
            return Center(child: Text("Item $index"));
          }),
        ),
      );
    });
  }
}
// @DocsDemo

// @DocsDemo("刷新期间禁用滑动")
class _DisableDuringRefresh extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WithModel(ScrollController(), (model) {
      final controller = model.value;
      return VanPullRefresh(
        controller: controller,
        lockDuringRefresh: true,
        // ignore: avoid_print
        onRefresh: () => Future.sync(() => print("refresh"))
            .then((_) => Future.delayed(const Duration(seconds: 1))),
        child: ListView(
          controller: controller,
          itemExtent: 50,
          children: List.generate(100, (index) {
            return Center(child: Text("Item $index"));
          }),
        ),
      );
    });
  }
}
// @DocsDemo
