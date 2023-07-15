import 'dart:ui';

import 'package:demo/widgets/watch_model.dart';
import 'package:flutter/widgets.dart';
import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';

// @DocsId("config")
// @DocsWidget("Config 全局配置")

class ConfigPage extends StatefulWidget {
  final Uri location;
  const ConfigPage(this.location, {super.key});

  @override
  State<StatefulWidget> createState() {
    return ConfigPageState();
  }
}

class ConfigPageState extends State<ConfigPage> {
  final rateValue = ValueNotifier(3.0);
  final sliderValue = ValueNotifier(60.0);

  @override
  void dispose() {
    rateValue.dispose();
    sliderValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final child = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CellGroup(children: [
          VanField(
            label: "评分",
            child: WatchModel(
              rateValue,
              (m) => Rate(
                value: m.value,
                onChange: (v) => m.value = v,
                count: 5,
              ),
            ),
          ),
          VanField(
            label: "滑块",
            child: WatchModel(
              sliderValue,
              (m) => Slider(
                value: m.value,
                onChange: (v) => m.value = v,
                max: 100,
              ),
            ),
          ),
        ]),
        const SizedBox(height: 8),
        const DocPadding(
            Button(text: "提交", type: ButtonType.primary, round: true)),
      ],
    );
    return ListView(children: [
      const DocTitle("默认主题"),
      // @DocsDemo("默认主题", "默认主题为浅色；内建浅色(light,fallback)、深色(dark) 主题")
      VanConfig(
        theme: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? VanTheme.dark
            : VanTheme.fallback,
        child: child,
      ),
      // @DocsDemo

      const DocTitle("定制主题"),
      // @DocsDemo("定制主题", "给出 theme 可以自定义主题颜色")
      VanConfig(
        theme: VanConfig.ofTheme(context).clone()
          ..primaryColor = const Color(0xFF58BE6A)
          ..dangerColor = const Color(0xFF58BE6A),
        child: child,
      ),
      // @DocsDemo
    ]);
  }
}
