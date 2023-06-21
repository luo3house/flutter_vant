import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';

class RatePage extends StatelessWidget {
  final Uri location;
  const RatePage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("基本用法"),
      DocPadding(WithModel(3.0, (model) {
        return VanRate(
          count: 5,
          value: model.value,
          onChange: (v) => model.value = v,
        );
      })),

      const DocTitle("自订图标"),
      DocPadding(WithModel(3.0, (model) {
        return VanRate(
          count: 5,
          value: model.value,
          onChange: (v) => model.value = v,
          voidIcon: VanIcons.like_o,
          icon: VanIcons.like,
        );
      })),

      const DocTitle("自订样式"),
      DocPadding(WithModel(3.0, (model) {
        return VanRate(
          count: 5,
          value: model.value,
          onChange: (v) => model.value = v,
          voidIcon: const Icon(VanIcons.star, color: Color(0xFFCCCCCC)),
          icon: const Icon(VanIcons.star, color: Color(0xFFF8D44E)),
        );
      })),

      //
      const DocTitle("半星"),
      DocPadding(WithModel(3.3, (model) {
        return VanRate(
          count: 5,
          value: model.value,
          allowHalf: true,
          onChange: (v) => model.value = v,
        );
      })),

      //
      const DocTitle("自订数量"),
      DocPadding(WithModel(4.0, (model) {
        return VanRate(
          count: 6,
          value: model.value,
          onChange: (v) => model.value = v,
        );
      })),
    ]);
  }
}
