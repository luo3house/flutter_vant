import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:tailstyle/tailstyle.dart';
import 'package:flutter/widgets.dart';

// @DocsId("button")
// @DocsWidget("Button 按钮")
class ButtonPage extends StatelessWidget {
  final Uri location;
  const ButtonPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    mapWithGutter(Iterable<Widget> children) => children.map((child) {
          return TailBox().mx(6).mb(12).Container(child: child);
        });

    return ListView(children: [
      const DocTitle("Button Type"),
      Wrap(children: [
        ...mapWithGutter([
          // @DocsDemo("按钮类型")
          const VanBtn(text: "Primary", type: VanBtnType.primary),
          const VanBtn(text: "Success", type: VanBtnType.success),
          const VanBtn(text: "Default", type: null),
          const VanBtn(text: "Danger", type: VanBtnType.danger),
          const VanBtn(text: "Warning", type: VanBtnType.warning),
          // @DocsDemo
        ])
      ]),

      const DocTitle("Plain Button"),
      Wrap(children: [
        ...mapWithGutter([
          // @DocsDemo("朴素按钮")
          const VanBtn(text: "Plain", type: VanBtnType.primary, plain: true),
          const VanBtn(text: "Plain", type: VanBtnType.success, plain: true),
          // @DocsDemo
        ]),
      ]),

      //
      const DocTitle("Disabled"),
      Wrap(children: [
        ...mapWithGutter([
          // @DocsDemo("禁用状态")
          const VanBtn(
            text: "Disabled",
            type: VanBtnType.primary,
            disabled: true,
          ),
          const VanBtn(
            text: "Disabled",
            type: VanBtnType.success,
            disabled: true,
          ),
          // @DocsDemo
        ])
      ]),

      const DocTitle("Shape"),
      Wrap(children: [
        ...mapWithGutter([
          // @DocsDemo("按钮形状")
          const VanBtn(text: "Square", type: VanBtnType.primary, square: true),
          const VanBtn(text: "Round", type: VanBtnType.success, round: true),
          // @DocsDemo
        ])
      ]),

      //
      const DocTitle("Size"),
      Wrap(crossAxisAlignment: WrapCrossAlignment.end, children: [
        ...mapWithGutter([
          // @DocsDemo("按钮大小")
          const VanBtn(
            text: "Large",
            type: VanBtnType.primary,
            size: VanBtnSize.large,
            block: true,
          ),
          const VanBtn(
            text: "Default",
            type: VanBtnType.primary,
            size: null,
          ),
          const VanBtn(
            text: "Small",
            type: VanBtnType.primary,
            size: VanBtnSize.small,
          ),
          const VanBtn(
            text: "Mini",
            type: VanBtnType.primary,
            size: VanBtnSize.mini,
          ),
          // @DocsDemo
        ])
      ]),
    ]);
  }
}
