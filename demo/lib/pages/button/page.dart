import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:tailstyle/tailstyle.dart';
import 'package:flutter/widgets.dart';

class ButtonPage extends StatelessWidget {
  final Uri location;
  const ButtonPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    mapWithGutter(Iterable<Widget> children) => children.map((child) {
          return TailBox().mx(6).mb(12).Container(child: child);
        });

    return ListView(children: [
      //
      const DocTitle("Button Type"),
      Wrap(children: [
        ...mapWithGutter([
          const VanBtn(text: "Primary", type: VanBtnType.primary),
          const VanBtn(text: "Success", type: VanBtnType.success),
          const VanBtn(text: "Default", type: null),
          const VanBtn(text: "Danger", type: VanBtnType.danger),
          const VanBtn(text: "Warning", type: VanBtnType.warning),
        ])
      ]),

      //
      const DocTitle("Plain Button"),
      Wrap(children: [
        ...mapWithGutter([
          const VanBtn(text: "Plain", type: VanBtnType.primary, plain: true),
          const VanBtn(text: "Plain", type: VanBtnType.success, plain: true),
        ]),
      ]),

      //
      const DocTitle("Disabled"),
      Wrap(children: [
        ...mapWithGutter([
          const VanBtn(
              text: "Disabled", type: VanBtnType.primary, disabled: true),
          const VanBtn(
              text: "Disabled", type: VanBtnType.success, disabled: true),
        ])
      ]),

      //
      const DocTitle("Loading"),
      Wrap(children: [
        ...mapWithGutter([
          const VanBtn(
              loading: true, loadingText: "Loading", type: VanBtnType.primary),
          const VanBtn(
              loading: true, loadingText: "Loading", type: VanBtnType.success),
        ])
      ]),

      //
      const DocTitle("Shape"),
      Wrap(children: [
        ...mapWithGutter([
          const VanBtn(text: "Square", type: VanBtnType.primary, square: true),
          const VanBtn(text: "Round", type: VanBtnType.success, round: true),
        ])
      ]),

      //
      const DocTitle("Size"),
      Wrap(crossAxisAlignment: WrapCrossAlignment.end, children: [
        ...mapWithGutter([
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
        ])
      ]),
    ]);
  }
}
