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
          const Button(text: "Primary", type: ButtonType.primary),
          const Button(text: "Success", type: ButtonType.success),
          const Button(text: "Default", type: null),
          const Button(text: "Danger", type: ButtonType.danger),
          const Button(text: "Warning", type: ButtonType.warning),
          // @DocsDemo
        ])
      ]),

      const DocTitle("Plain Button"),
      Wrap(children: [
        ...mapWithGutter([
          // @DocsDemo("朴素按钮")
          const Button(text: "Plain", type: ButtonType.primary, plain: true),
          const Button(text: "Plain", type: ButtonType.success, plain: true),
          // @DocsDemo
        ]),
      ]),

      //
      const DocTitle("Disabled"),
      Wrap(children: [
        ...mapWithGutter([
          // @DocsDemo("禁用状态")
          const Button(
            text: "Disabled",
            type: ButtonType.primary,
            disabled: true,
          ),
          const Button(
            text: "Disabled",
            type: ButtonType.success,
            disabled: true,
          ),
          // @DocsDemo
        ])
      ]),

      const DocTitle("Shape"),
      Wrap(children: [
        ...mapWithGutter([
          // @DocsDemo("按钮形状")
          const Button(text: "Square", type: ButtonType.primary, square: true),
          const Button(text: "Round", type: ButtonType.success, round: true),
          // @DocsDemo
        ])
      ]),

      //
      const DocTitle("Size"),
      Wrap(crossAxisAlignment: WrapCrossAlignment.end, children: [
        ...mapWithGutter([
          // @DocsDemo("按钮大小")
          const Button(
            text: "Large",
            type: ButtonType.primary,
            size: ButtonSize.large,
            block: true,
          ),
          const Button(
            text: "Default",
            type: ButtonType.primary,
            size: null,
          ),
          const Button(
            text: "Small",
            type: ButtonType.primary,
            size: ButtonSize.small,
          ),
          const Button(
            text: "Mini",
            type: ButtonType.primary,
            size: ButtonSize.mini,
          ),
          // @DocsDemo
        ])
      ]),
    ]);
  }
}
